from .forms import RecordModelForm, CSVUploadForm, FilterData
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import pandas as pd

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
          
     return query

def home(request):
     return render(request, 'visualization/home.html')

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
     arr = []

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
                         context = {'dataframe': dataframe.to_html, 'chart': fig.to_html(), 'form': form}
                    else:
                         dataframe = pd.DataFrame(data)
                         context = {'dataframe': dataframe.to_html, 'form': form}
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
          context = {'dataframe': dataframe.to_html, 'chart': fig.to_html(), 'form': form}

     return render(request, 'visualization/showinfo.html', context)

@login_required
def uploadCSV(request):
     if request.method == 'POST':
          form = CSVUploadForm(request.POST, request.FILES)
          if form.is_valid():
               CSVFile = request.FILES['CSVFile']
               dataframe = pd.read_csv(CSVFile)
               context = {'dataframe': dataframe.to_html}
               return render(request, 'visualization/checkCSV.html', context)


     else:
          form = CSVUploadForm()
          context = {'form': form}
     return render(request, 'visualization/uploadCSV.html', context)