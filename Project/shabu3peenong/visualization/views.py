from .forms import FilterInsert, DailyExpense, InsertProduct, CSVUploadForm, FilterData, FilterCSV
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
                    form = None
               request.session['filter'] = {'filter': filter}

          context = {'filterform': filterform, 'form': form}
          return render(request, 'visualization/record.html', context)

     filterform = FilterInsert(is_superuser=request.user.is_superuser)
     form = InsertProduct()
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
                    if data['productDescription'] == '':
                         query = """
                              INSERT INTO product_list (SKU, sales_id, product_name, product_price, product_cost) 
                              VALUES (%s, %s, %s, %s, %s)
                              """
                         value = [data['SKU'], int(data['salesType']), data['productName'], data['productPrice'], data['productCost']]
                    else:
                         query = """
                              INSERT INTO product_list (SKU, sales_id, product_name, product_price, product_cost, product_description) 
                              VALUES (%s, %s, %s, %s, %s, %s)
                              """
                         value = [data['SKU'], int(data['salesType']), data['productName'], data['productPrice'], data['productCost'], data['productDescription']]

                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(query, value)
                    except OperationalError as e:
                         context = {'error': str(ast.literal_eval(str(e))[1])}
                         return render(request, 'visualization/productError.html', context)
                         
          elif filter['filter'] == 'expenses':
               form = DailyExpense(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    if data['expenseDescription'] == '':
                         query = """
                              INSERT INTO daily_expense (expense_id, branch_id, daily_expense_date, daily_expense_price) 
                              VALUES (%s, %s, %s, %s)
                              """
                         value = [int(data['expenseType']), int(data['expenseBranch']), data['expenseDate'], data['expensePrice']]
                    else:
                         query = """
                              INSERT INTO daily_expense (expense_id, branch_id, daily_expense_date, daily_expense_price, daily_expense_description) 
                              VALUES (%s, %s, %s, %s, %s)
                              """
                         value = [int(data['expenseType']), int(data['expenseBranch']), data['expenseDate'], data['expensePrice'], data['expenseDescription']]

                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(query, value)
                    except OperationalError as e:
                         None

          elif filter['filter'] == 'activity':
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
                              dataframeNotAdd = dataframeNotAdd.to_html(index=False)
                              context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm, 
                                        'file': CSVFile, 'addProduct': dataframeNotAdd}
               elif filter['filter'] == 'itemSales':
                    context = {'dataframe': dataframe.to_html(index=False), 'CSVForm': CSVForm, 'filterForm': filterForm, 
                              'file': CSVFile}
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
                         mapping = {'Buffet': 1, 'Delivery': 2, 'Take Home': 3, 'A la carte': 4, 
                                   'รายการปรับ และเก็บเพิ่มเติม': 5, 'เครื่องดื่ม': 6, 'เนื้อสัตว์และอื่นๆ': 7, 'น้ำซุป': 8}
                         productDataframe = pd.read_json(productDataframe)
                         productDataframe['ประเภท'] = productDataframe['ประเภท'].replace(mapping)
                         query = """
                                   INSERT INTO product_list 
                                   (SKU, sales_id, product_name, product_price, product_cost) 
                                   VALUES (%s, %s, %s, %s, %s)
                              """
                         for i in range(productDataframe.shape[0]):
                                   data = [
                                        int(productDataframe.iloc[i, 0]), int(productDataframe.iloc[i, 1]), productDataframe.iloc[i, 2], 
                                        float(productDataframe.iloc[i, 3]), float(productDataframe.iloc[i, 4])]
                                   with connection.cursor() as cursor:
                                        cursor.execute(query, data)
                         
                         request.session.pop('addProduct', None)
               except:
                    None

               try:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%y %H:%M"))
               except:
                    dataframe['วันที่'] = dataframe['วันที่'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y %H:%M"))

               receipt_mapping = {'ชาบู 3 พี่น้อง | สาขาพหลโยธิน 52': '1', 'ชาบู 3 พี่น้อง | สาขาม.รังสิต': '2', 'Take ชาบู 3 พี่น้อง | สาขารังสิต 200 ปี': '3'}
               dataframe['ร้านค้า'] = dataframe['ร้านค้า'].replace(receipt_mapping)
               dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']] = dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']].replace(np.nan, 'NA')
               receipt_dataframe = dataframe.groupby(['วันที่', 'เลขที่ใบเสร็จ', 'ประเภทใบเสร็จ', 
                                                       'ทางเลือกสั่งออเดอร์', 'ระบบขายหน้าร้าน', 'ร้านค้า', 
                                                       'ชื่อแคชเชียร์', 'ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 
                                                       'ความคิดเห็น', 'สถานะ']).sum().reset_index()
               receipt_dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']] = receipt_dataframe[['ชื่อลูกค้า', 'รายชื่อติดต่อลูกค้า', 'ความคิดเห็น']].replace('NA', np.nan)
               
               receipt_by_product_query = """
                         INSERT INTO receipt_by_product 
                         (SKU, receipt_id, rbp_quantity, rbp_total, rbp_discount, rbp_net, rbp_cost, rbp_profit) 
                         VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    """
               
               receipt_query = """
                         INSERT INTO receipt 
                         (receipt_id, branch_id, receipt_date, receipt_type, receipt_order, receipt_system, receipt_cashier, receipt_customer_name, receipt_customer_contact, receipt_comment, receipt_status) 
                         VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """

               for i in range(dataframe.shape[0]):
                    data = [
                         int(dataframe.iloc[i, 4]), dataframe.iloc[i, 1], int(dataframe.iloc[i, 8]), 
                         float(dataframe.iloc[i, 9]), float(dataframe.iloc[i, 10]), float(dataframe.iloc[i, 11]),
                         float(dataframe.iloc[i, 12]), float(dataframe.iloc[i, 13])
                         ]
                    with connection.cursor() as cursor:
                         cursor.execute(receipt_by_product_query, data)

               for i in range(receipt_dataframe.shape[0]):
                    receipt_data = [
                         receipt_dataframe.iloc[i, 1], int(receipt_dataframe.iloc[i, 5]), receipt_dataframe.iloc[i, 0], 
                         receipt_dataframe.iloc[i, 2], receipt_dataframe.iloc[i, 3], receipt_dataframe.iloc[i, 4],
                         receipt_dataframe.iloc[i, 6], receipt_dataframe.iloc[i, 7], receipt_dataframe.iloc[i, 8],
                         receipt_dataframe.iloc[i, 9], receipt_dataframe.iloc[i, 10]
                         ]
                    with connection.cursor() as cursor:
                         cursor.execute(receipt_query, receipt_data)     
          else:
               None
     request.session.pop('session', None)
     
     return HttpResponseRedirect(reverse('complete'))