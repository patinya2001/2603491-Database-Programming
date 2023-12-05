from .forms import RecordModelForm, CSVUploadForm, FilterData
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import pandas as pd
import datetime

def queryField(case):
     if case == 'insertRecord':
          query = """
                    INSERT INTO visualization_dailyperformance (date, cash, transferPayment, delivery) 
                    VALUES (%s, %s, %s, %s)
             """
          
     elif case == 'showInfo':
          query = """
                    SELECT *
                    FROM visualization_dailyperformance
             """
          
     elif case == 'average':
          query = """
                    SELECT *
                    FROM getavg
               """
     elif case == 'receipt':
          query = """
                    INSERT INTO receipt (receipt_id, receipt_date, receipt_SKU, receipt_quantity, receipt_total, receipt_discount, receipt_net) 
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
               """
     elif case == 'daily':
          query = """
                    SELECT *
                    FROM daily
                    LIMIT 3
               """     
     
     return query

def home(request):
     with connection.cursor() as cursor:
          query = queryField('daily')
          cursor.execute(query)
          data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
          data = [{'Date': datetime.date(d['Date'].year, d['Date'].day, d['Date'].month), 'Net': d['Net']} for d in data]
          fig = px.bar(data, x='Date', y='Net')
          
          context = {'data': data, 'chart': fig.to_html}

     return render(request, 'visualization/home.html', context)

@login_required
def record(request):
     if request.method == 'POST':
          form = RecordModelForm(request.POST)
          if form.is_valid():
               data = form.cleaned_data

               query = queryField('insertRecord')

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
          form = CSVUploadForm(request.POST, request.FILES)
          if form.is_valid():
               CSVFile = request.FILES['CSVFile']
               dataframe = pd.read_csv(CSVFile)
               request.session['dataframe'] = dataframe.to_json(indent=False)
               context = {'dataframe': dataframe.to_html(index=False), 'form': form, 'file': CSVFile}
               return render(request, 'visualization/uploadCSV.html', context)
     else:
          form = CSVUploadForm()
     context = {'form': form}

     return render(request, 'visualization/uploadCSV.html', context)

@login_required
def saveCSV(request):
     dataframe = request.session.get('dataframe')
     if dataframe:
          dataframe = pd.read_json(dataframe)

          try:
               dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%y %H:%M"))
          except:
               dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y %H:%M"))

          query = queryField('receipt')

          for i in range(dataframe.shape[0]):
               data = [
                    str(dataframe.iloc[i, 1]), dataframe.iloc[i, 0], int(dataframe.iloc[i, 4]),int(dataframe.iloc[i, 8]),
                    float(dataframe.iloc[i, 9]), float(dataframe.iloc[i, 10]), float(dataframe.iloc[i, 11])
                    ]
               with connection.cursor() as cursor:
                    cursor.execute(query, data)

     request.session.pop('dataframe', None)
     
     return HttpResponseRedirect(reverse('complete'))