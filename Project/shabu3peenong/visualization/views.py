from .forms import FilterInsert, DailyExpense, InsertProduct, ActivityForm, CSVUploadForm, FilterData, FilterCSV, ItemSaleDateForm
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.db import OperationalError
from django.shortcuts import render
from django.db import connection
from django.urls import reverse
from datetime import datetime
import plotly.express as px
import datetime as dt
import pandas as pd
import numpy as np
import ast

def home(request):
     try:
          with connection.cursor() as cursor:
               query = """
                         SELECT 
                         วันที่,
                         รายได้สุทธิรวม
                         FROM home_daily
                    """  
               
               cursor.execute(query)
               data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
               data = [{'Date': dt.date(d['วันที่'].year, d['วันที่'].day, d['วันที่'].month), 'Net': d['รายได้สุทธิรวม']} for d in data]
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
     except:
          context = None

     return render(request, 'visualization/home.html', context)

@login_required
def record(request):
     if request.method == 'POST':
          filterform = FilterInsert(request.POST, is_superuser=request.user.is_superuser)
          if filterform.is_valid():
               filter = filterform.cleaned_data
               if filter['filter'] == 'product':
                    form = InsertProduct()
               elif filter['filter'] == 'expenses':
                    form = DailyExpense()
               elif filter['filter'] == 'activity':
                    form = ActivityForm(user_branch=request.user.branch)
               request.session.pop('filter', None)
               request.session['filter'] = {'filter': filter}

          context = {'filterform': filterform, 'form': form}
          return render(request, 'visualization/record.html', context)

     filterform = FilterInsert(is_superuser=request.user.is_superuser)
     form = InsertProduct()
     request.session['filter'] = {'filter': {'filter': ('product' if request.user.is_superuser else 'expenses')}}
     context = {'filterform': filterform, 'form': form}

     return render(request, 'visualization/record.html', context)

@login_required
def insert(request):
     if request.method == 'POST':
          session = request.session.get('filter')
          filter = session.get('filter')
          if filter['filter'] == 'product':
               form = InsertProduct(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    procedure = 'CALL InsertProduct(%s, %s, NULL, %s, %s, %s, %s)'
                    value = [data['SKU'], data['salesType'], data['productName'], data['productPrice'], data['productCost'], data['productDescription']]

                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(procedure, value)
                    except OperationalError as e:
                         context = {'error': str(ast.literal_eval(str(e))[1])}
                         return render(request, 'visualization/productError.html', context)
                         
          elif filter['filter'] == 'expenses':
               form = DailyExpense(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    procedure = 'CALL InsertExpense(%s, %s, %s, %s, %s)'
                    value = [data['expenseType'], data['expenseBranch'], data['expenseDate'], data['expensePrice'], data['expenseDescription']]

                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(procedure, value)
                    except OperationalError as e:
                         None

          elif filter['filter'] == 'activity':
               form = ActivityForm(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    procedure = 'CALL InsertActivity(%s, %s, %s, %s, %s, %s)'
                    print(data['activityAbsent'])
                    value = [request.user.is_superuser, request.user.branch, data['activityEmployee'], data['activityDate'], data['activityAbsent'], data['activityLate']]
                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(procedure, value)
                    except OperationalError as e:
                         None
               
          request.session.pop('filter', None)
          return HttpResponseRedirect(reverse('complete'))

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
               if filter['filter'] == 'receipts':
                    with connection.cursor() as cursor:
                         query = """
                              SELECT SKU FROM product_list
                         """
                         cursor.execute(query)
                         data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                         dataList = [item['SKU'] for item in data]
                         itemNotAdd = list(set(dataframe['รหัสSKUสินค้า'].tolist()) - set(dataList))
                         if itemNotAdd == []:
                              context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm, 
                                        'file': CSVFile}
                         else:
                              dataframeNotAdd = dataframe[dataframe['รหัสSKUสินค้า'].isin(itemNotAdd)]
                              dataframeNotAdd['ราคาต่อหน่วย'] = dataframeNotAdd['ยอดขายรวม'] / dataframeNotAdd['จำนวน']
                              dataframeNotAdd['ต้นทุนต่อหน่วย'] = dataframeNotAdd['ต้นทุนของสินค้า'] / dataframeNotAdd['จำนวน']
                              dataframeNotAdd = dataframeNotAdd[['รหัสSKUสินค้า', 'ประเภท', 'รายการ', 'ราคาต่อหน่วย', 'ต้นทุนต่อหน่วย']]
                              dataframeNotAdd = dataframeNotAdd.drop_duplicates()
                              dataframeNotAdd = dataframeNotAdd.sort_values(by='รหัสSKUสินค้า')
                              request.session['addProduct'] = {'addProduct': dataframeNotAdd.to_json(indent=False)}
                              context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm, 
                                        'file': CSVFile, 'addProduct': dataframeNotAdd.to_html(index=False)}
                              
               elif filter['filter'] == 'itemSales':
                    with connection.cursor() as cursor:
                         query = """
                              SELECT SKU FROM product_list
                         """
                         cursor.execute(query)
                         data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                         dataList = [item['SKU'] for item in data]
                         itemNotAdd = list(set(dataframe['รหัสSKUสินค้า'].tolist()) - set(dataList))
                         if itemNotAdd == []:
                              yearMonth = ItemSaleDateForm()
                              context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm,
                                        'yearMonth': yearMonth, 'file': CSVFile}
                         else:
                              dataframeNotAdd = dataframe[dataframe['รหัสSKUสินค้า'].isin(itemNotAdd)]
                              dataframeNotAdd['ราคาต่อหน่วย'] = dataframeNotAdd['ยอดขายรวม'] / dataframeNotAdd['สินค้าที่ขาย']
                              dataframeNotAdd['ต้นทุนต่อหน่วย'] = dataframeNotAdd['ต้นทุนของสินค้า'] / dataframeNotAdd['สินค้าที่ขาย']
                              dataframeNotAdd = dataframeNotAdd[['รหัสSKUสินค้า', 'ประเภท', 'รายการ', 'ราคาต่อหน่วย', 'ต้นทุนต่อหน่วย']]
                              dataframeNotAdd = dataframeNotAdd.drop_duplicates()
                              dataframeNotAdd = dataframeNotAdd.sort_values(by='รหัสSKUสินค้า')
                              request.session['addProduct'] = {'addProduct': dataframeNotAdd.to_json(indent=False)}
                              yearMonth = ItemSaleDateForm()
                              context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm,
                                        'yearMonth': yearMonth, 'file': CSVFile, 'addProduct': dataframeNotAdd.to_html(index=False)}
               session = {
                'dataframe': dataframe.to_json(indent=False),
                'filter': filter,
               }

               request.session['session'] = session
               return render(request, 'visualization/uploadCSV.html', context)
     else:
          CSVForm = CSVUploadForm()
          filterForm = FilterCSV()
     context = {'CSVForm': CSVForm, 'filterForm': filterForm}

     return render(request, 'visualization/uploadCSV.html', context)

@login_required
def addProduct(request):
     if request.method == 'POST':
               yearMonth = ItemSaleDateForm(request.POST)
               if yearMonth.is_valid():
                    cleanedData = yearMonth.cleaned_data
                    try:
                         request.session.pop('yearMonth', None)
                    except:
                         None
                    request.session['yearMonth'] = {'yearMonth': cleanedData}
     session = request.session.get('addProduct')
     dataframe = session.get('addProduct')
     dataframe = pd.read_json(dataframe)
     context = {'addProduct': dataframe.to_html(index=False)}
     return render(request, 'visualization/addProduct.html', context)

@login_required
def saveCSV(request):
     session = request.session.get('session')
     dataframe = session.get('dataframe')
     filter = session.get('filter')

     if dataframe:
          dataframe = pd.read_json(dataframe)
          if filter['filter'] == 'receipts':
               try:
                    productSession = request.session.get('addProduct')
                    productDataframe = productSession.get('addProduct')
                    if productDataframe:
                         productDataframe = pd.read_json(productDataframe)
                         procedure = 'CALL InsertProduct(%s, NULL, %s, %s, %s, %s, %s)'

                         for i in range(productDataframe.shape[0]):
                                   data = [
                                        productDataframe.iloc[i, 0], productDataframe.iloc[i, 1], productDataframe.iloc[i, 2], 
                                        productDataframe.iloc[i, 3], productDataframe.iloc[i, 4]
                                        ]
                                   with connection.cursor() as cursor:
                                        cursor.execute(procedure, data)
                         
                         request.session.pop('addProduct', None)
               except:
                    None

               try:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%y %H:%M"))
               except:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y %H:%M"))

               dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']] = dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']].replace(np.nan, 'NA')
               receipt_dataframe = dataframe.groupby(['วันที่', 'เลขที่ใบเสร็จ', 'ประเภทใบเสร็จ', 'ทางเลือกสั่งออเดอร์', 'ระบบขายหน้าร้าน', 'ร้านค้า', 
                                                       'ชื่อแคชเชียร์', 'ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น', 'สถานะ']).sum().reset_index()
               receipt_dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']] = receipt_dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']].replace('NA', np.nan)
               
               receipt_procedure = 'CALL InsertReceipt(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'

               receipt_by_product_procedure = 'CALL InsertReceiptByProduct(%s, %s, %s, %s)'

               for i in range(receipt_dataframe.shape[0]):
                    receipt_data = [
                         receipt_dataframe.iloc[i, 1], receipt_dataframe.iloc[i, 5], receipt_dataframe.iloc[i, 0], 
                         receipt_dataframe.iloc[i, 2], receipt_dataframe.iloc[i, 3], receipt_dataframe.iloc[i, 4],
                         receipt_dataframe.iloc[i, 6], receipt_dataframe.iloc[i, 17], receipt_dataframe.iloc[i, 18],
                         receipt_dataframe.iloc[i, 19], receipt_dataframe.iloc[i, 7], receipt_dataframe.iloc[i, 8],
                         receipt_dataframe.iloc[i, 9], receipt_dataframe.iloc[i, 10]
                         ]
                    with connection.cursor() as cursor:
                         cursor.execute(receipt_procedure, receipt_data) 

               for i in range(dataframe.shape[0]):
                    data = [
                         dataframe.iloc[i, 4], dataframe.iloc[i, 1], dataframe.iloc[i, 8], dataframe.iloc[i, 10]]
                    with connection.cursor() as cursor:
                         cursor.execute(receipt_by_product_procedure, data)
    
          elif filter['filter'] == 'itemSales':
               try:
                    productSession = request.session.get('addProduct')
                    productDataframe = productSession.get('addProduct')
                    if productDataframe:
                         productDataframe = pd.read_json(productDataframe)
                         procedure = 'CALL InsertProduct(%s, NULL, %s, %s, %s, %s, %s)'

                         for i in range(productDataframe.shape[0]):
                                   data = [
                                        productDataframe.iloc[i, 0], productDataframe.iloc[i, 1], productDataframe.iloc[i, 2], 
                                        productDataframe.iloc[i, 3], productDataframe.iloc[i, 4]
                                        ]
                                   with connection.cursor() as cursor:
                                        cursor.execute(procedure, data)
                         
                         request.session.pop('addProduct', None)
               except:
                    None

               if request.method == 'POST':
                    yearMonth = ItemSaleDateForm(request.POST)
                    if yearMonth.is_valid():
                         cleanedData = yearMonth.cleaned_data
               try:
                    session_YM = request.session.get('yearMonth')
                    cleanedData = session_YM.get('yearMonth')
               except:
                    None
               
               procedure = 'CALL InsertItemSales(%s, %s, %s, %s, %s, %s)'

               for i in range(dataframe.shape[0]):
                    data = [
                         dataframe.iloc[i, 1], cleanedData['month'], cleanedData['year'], 
                         dataframe.iloc[i, 3], dataframe.iloc[i, 5], dataframe.iloc[i, 6]
                    ]
                    with connection.cursor() as cursor:
                         cursor.execute(procedure, data)

     request.session.pop('session', None)
     
     return HttpResponseRedirect(reverse('complete'))