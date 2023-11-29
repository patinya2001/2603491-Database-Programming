from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import render
from .forms import RecordModelForm
from .forms import CSVUploadForm
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import pandas as pd
import json


def home(request):
     return render(request, 'visualization/home.html')

@login_required
def record(request):
     if request.method == 'POST':
          form = RecordModelForm(request.POST)
          if form.is_valid():
               data = form.cleaned_data

               insert_query = """
                    INSERT INTO visualization_dailyperformance (date, cash, transferPayment, delivery) 
                    VALUES (%s, %s, %s, %s)
               """

               with connection.cursor() as cursor:
                    cursor.execute(insert_query, [data['date'], data['cash'], data['transferPayment'], data['delivery']])

               return HttpResponseRedirect(reverse('complete'))
          
     form = RecordModelForm()
     context = {'form': form}

     return render(request, 'visualization/record.html', context)

@login_required
def complete(request):
     return render(request, 'visualization/complete.html')

@login_required
def showinfo(request):
     arr = []
     query = """
          SELECT *
          FROM visualization_dailyperformance
     """

     with connection.cursor() as cursor:
          cursor.execute(query)
          data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]

     for date in data:
          date['date'] = datetime(date['date'].year, date['date'].month, date['date'].day)
     
     dataframe = pd.DataFrame(data)

     fig = px.bar(data, x='date', y=['cash', 'transferPayment', 'delivery'])

     context = {'dataframe': dataframe.to_html, 'chart': fig.to_html()}

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