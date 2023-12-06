from .forms import RecordModelForm, CSVUploadForm, FilterData, FilterCSV
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import datetime as dt
import pandas as pd

def home(request):
     with connection.cursor() as cursor:

          query = """
                    SELECT *
                    FROM daily
               """  
          
          cursor.execute(query)
          data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
          data = [{'Date': dt.date(d['Date'].year, d['Date'].day, d['Date'].month), 'Net': d['Net']} for d in data]
          fig = px.line(data, x='Date', y='Net')
          fig.update_layout( 
               title = 'รายได้รายวัน',
               title_x = 0.5,
               xaxis_title = 'วันที่', 
               yaxis_title = 'รายได้สุทธิ',
               plot_bgcolor = 'rgb(23, 32, 66)',
               paper_bgcolor = 'rgb(23, 32, 66)',
               font = dict(color='rgb(107, 111, 138)', family='Mitr'),
               title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
               xaxis_title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
               yaxis_title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
               xaxis = dict(gridcolor='rgb(107, 111, 138)', zerolinecolor='rgb(107, 111, 138)'),
               yaxis = dict(gridcolor='rgb(107, 111, 138)', zerolinecolor='rgb(107, 111, 138)')
               )
          
          fig.update_traces(
               line=dict(color='rgb(234, 51, 93)'),
               hovertemplate = 'วันที่: %{x}<br>รายได้สุทธิ: %{y}',
               )
     
     context = {'data': data[-3:], 'chart': fig.to_html}

     return render(request, 'visualization/home.html', context)

@login_required
def record(request):
     if request.method == 'POST':
          form = RecordModelForm(request.POST)
          if form.is_valid():
               data = form.cleaned_data

               query = """
                    INSERT INTO visualization_dailyperformance (date, cash, transferPayment, delivery) 
                    VALUES (%s, %s, %s, %s)
                    """

               with connection.cursor() as cursor:
                    cursor.execute(query, [data['date'], data['cash'], data['transferPayment'], data['delivery']])

               return HttpResponseRedirect(reverse('complete'))
          
     form = RecordModelForm()
     context = {'form': form}

     return render(request, 'visualization/record.html', context)

@login_required
def complete(request):
     return render(request, 'visualization/complete.html')

@login_required
def showInfo(request):
     def queryField(case):          
          if case == 'showInfo':
               query = """
                         SELECT *
                         FROM visualization_dailyperformance
               """
          elif case == 'average':
               query = """
                         SELECT *
                         FROM getavg
                    """
          return query

     if request.method == 'POST':
          form = FilterData(request.POST)
          if form.is_valid():
               filter = form.cleaned_data
               with connection.cursor() as cursor:
                    query = queryField(filter['filter'])
                    cursor.execute(query)
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    if filter['filter'] == 'showInfo':
                         for date in data:
                              date['date'] = datetime(date['date'].year, date['date'].month, date['date'].day)
                         fig = px.bar(data, x='date', y=['cash', 'transferPayment', 'delivery'])
                         dataframe = pd.DataFrame(data)
                         context = {'dataframe': dataframe.to_html(index=False), 'chart': fig.to_html(), 'form': form}
                    else:
                         dataframe = pd.DataFrame(data)
                         context = {'dataframe': dataframe.to_html(index=False), 'form': form}
     else:
          with connection.cursor() as cursor:
               query = queryField('showInfo')
               cursor.execute(query)
               data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
               for date in data:
                    date['date'] = datetime(date['date'].year, date['date'].month, date['date'].day)
          fig = px.bar(data, x='date', y=['cash', 'transferPayment', 'delivery'])
          dataframe = pd.DataFrame(data)
          form = FilterData()
          context = {'dataframe': dataframe.to_html(index=False), 'chart': fig.to_html(), 'form': form}

     return render(request, 'visualization/showinfo.html', context)

@login_required
def uploadCSV(request):
     if request.method == 'POST':
          CSVForm = CSVUploadForm(request.POST, request.FILES)
          filterForm = FilterCSV(request.POST)
          if CSVForm.is_valid() and filterForm.is_valid():
               CSVFile = request.FILES['CSVFile']
               filter = filterForm.cleaned_data
               dataframe = pd.read_csv(CSVFile)

               session = {
                'dataframe': dataframe.to_json(indent=False),
                'filter': filter,
               }

               request.session['session'] = session
               context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm, 'file': CSVFile}
               return render(request, 'visualization/uploadCSV.html', context)
     else:
          CSVForm = CSVUploadForm()
          filterForm = FilterCSV()
     context = {'CSVForm': CSVForm, 'filterForm': filterForm}

     return render(request, 'visualization/uploadCSV.html', context)

@login_required
def saveCSV(request):
     session = request.session.get('session')
     dataframe = session.get('dataframe')
     filter = session.get('filter')
     if dataframe:
          dataframe = pd.read_json(dataframe)
          if filter['filter'] == 'receipts':
               try:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%y %H:%M"))
               except:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y %H:%M"))

               query = """
                         INSERT INTO receipt (receipt_id, receipt_date, receipt_SKU, receipt_quantity, receipt_total, receipt_discount, receipt_net) 
                         VALUES (%s, %s, %s, %s, %s, %s, %s)
                    """

               for i in range(dataframe.shape[0]):
                    data = [
                         str(dataframe.iloc[i, 1]), dataframe.iloc[i, 0], int(dataframe.iloc[i, 4]),int(dataframe.iloc[i, 8]),
                         float(dataframe.iloc[i, 9]), float(dataframe.iloc[i, 10]), float(dataframe.iloc[i, 11])
                         ]
                    with connection.cursor() as cursor:
                         cursor.execute(query, data)
          else:
               None
     request.session.pop('session', None)
     
     return HttpResponseRedirect(reverse('complete'))