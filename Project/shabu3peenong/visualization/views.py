from django.http import HttpResponseRedirect
from django.shortcuts import render
from .forms import RecordModelForm
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import pandas as pd
import json


def home(request):
     return render(request, 'visualization/home.html')

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

def complete(request):
     return render(request, 'visualization/complete.html')

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
     
     fig = px.bar(data, x='date', y=['cash', 'transferPayment', 'delivery'])
     chart = fig.to_html()

     context = {'dataframe': data, 'chart': chart}

     return render(request, 'visualization/showinfo.html', context)