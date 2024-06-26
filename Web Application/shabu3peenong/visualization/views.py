from .forms import FilterInsert, DailyExpense, InsertProduct, ActivityForm, CSVUploadForm, FilterData, FilterCSV, ItemSaleDateForm, MonthYearFilter, AdvancedPay
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

def updateFig(fig, type, title, xlab, ylab):
     fig.update_layout( 
          title = title,
          title_x = 0.5,
          xaxis_title = xlab, 
          yaxis_title = ylab,
          plot_bgcolor = 'rgb(23, 32, 66)',
          paper_bgcolor = 'rgb(23, 32, 66)',
          font = dict(color='rgb(107, 111, 138)', family='Mitr'),
          title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
          xaxis_title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
          yaxis_title_font = dict(color='rgb(255, 255, 255)', family='Mitr'),
          xaxis = dict(gridcolor='rgb(107, 111, 138)', zerolinecolor='rgb(107, 111, 138)'),
          yaxis = dict(gridcolor='rgb(107, 111, 138)', zerolinecolor='rgb(107, 111, 138)')
          )
     
     if type == 'line':
          fig.update_traces(
               line=dict(color='rgb(234, 51, 93)'),
               hovertemplate = 'วันที่: %{x}<br>รายได้สุทธิ: %{y}',
               )
     elif type == 'bar':
          fig.update_traces(marker=dict(color='rgb(234, 51, 93)', line=dict(color='rgb(234, 51, 93)', width=0)))

     return fig

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
               data = [{'Date': dt.date(d['วันที่'].year, d['วันที่'].month, d['วันที่'].day), 'Net': d['รายได้สุทธิรวม']} for d in data]
               fig = px.line(data, x='Date', y='Net')
               fig = updateFig(fig, 'line', 'รายได้รายวัน', 'วันที่', 'รายได้สุทธิ')
          
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
               elif filter['filter'] == 'pay':
                    form = AdvancedPay(user_branch=request.user.branch)
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
                         return render(request, 'visualization/error.html', context)
                         
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
                         context = {'error': str(ast.literal_eval(str(e))[1])}
                         return render(request, 'visualization/error.html', context)

          elif filter['filter'] == 'activity':
               form = ActivityForm(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    procedure = 'CALL InsertActivity(%s, %s, %s, %s, %s, %s)'
                    value = [request.user.is_superuser, request.user.branch, data['activityEmployee'], data['activityDate'], data['activityAbsent'], data['activityLate']]
                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(procedure, value)
                    except OperationalError as e:
                         None
                         
          elif filter['filter'] == 'pay':
               form = AdvancedPay(request.POST)
               if form.is_valid():
                    data = form.cleaned_data
                    procedure = 'CALL UpdateAdvancedPay(%s, %s, %s)'
                    value = [data['advancedPayEmployee'], data['advancedPayDate'], data['advancedPayAmount']]
                    try:
                         with connection.cursor() as cursor:
                              cursor.execute(procedure, value)
                    except OperationalError as e:
                         context = {'error': str(ast.literal_eval(str(e))[1])}
                         return render(request, 'visualization/error.html', context)
                    
          request.session.pop('filter', None)
          return HttpResponseRedirect(reverse('complete'))

@login_required
def complete(request):
     return render(request, 'visualization/complete.html')

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
def product(request):
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
     return render(request, 'visualization/product.html', context)

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
                         procedure = 'CALL InsertProduct(%s, NULL, %s, %s, %s, %s, '')'

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
                    dataframe['วันที่'] = (pd.to_datetime(dataframe['วันที่'], format='%d/%m/%y %H:%M')).dt.strftime('%m/%d/%y %H:%M')
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
                         print(productDataframe.iloc[:, 0])
                         procedure = 'CALL InsertProduct(%s, NULL, %s, %s, %s, %s, %s)'

                         for i in range(productDataframe.shape[0]):
                              data = [
                                   productDataframe.iloc[i, 0], productDataframe.iloc[i, 1], productDataframe.iloc[i, 2], 
                                   productDataframe.iloc[i, 3], productDataframe.iloc[i, 4], ''
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

@login_required
def showInfo(request):
     if request.method == 'POST':
          session = request.session.get('monthFilterCleaned')
          monthFilterCleaned = session.get('monthFilterCleaned')

          if monthFilterCleaned['monthYear'] == '':
               monthFilterCleaned = {'monthYear': '2023-09'}

          filterSession = request.session.get('showInfoFilter')
          showInfoFilter = filterSession.get('showInfoFilter')
          
          form = FilterData(request.POST, init=showInfoFilter['filter'])
          if form.is_valid():
               filter = form.cleaned_data

               if filter['filter'] != '':
                    showInfoFilter['filter'] = ''

               if filter['filter'] == 'summary' or showInfoFilter['filter'] == 'summary':
                    context = {'form': FilterData(init='summary'), 'monthFilter': MonthYearFilter(monthYear=monthFilterCleaned['monthYear']), 'filter': 1}
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT total_expense, avg_expense, total_income, avg_income
                                        FROM summary_view
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              context.update(data[0])
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, total_income
                                        FROM total_income_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='total_income')
                              fig = updateFig(fig, 'bar', 'รายได้แยกตามสาขา', 'สาขา', 'รายได้รวม')
                              context.update({'chart1': fig.to_html()})
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, total_expense
                                        FROM total_expense_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='total_expense')
                              fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามสาขา', 'สาขา', 'ค่าใช้จ่ายรวม')
                              context.update({'chart2': fig.to_html()})
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT receipt_type, total_income
                                        FROM total_income_by_type
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='receipt_type', y='total_income')
                              fig = updateFig(fig, 'bar', 'รายได้แยกตามประเภทใบเสร็จ', 'ประเภทใบเสร็จ', 'รายได้รวม')
                              context.update({'chart3': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT expense_name, total_expense
                                        FROM total_expense_by_type
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='expense_name', y='total_expense')
                              fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามประเภท', 'ประเภทค่าใช้จ่าย', 'ค่าใช้จ่ายรวม')
                              context.update({'chart4': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT product_name, total_sales
                                        FROM top_ten_sales
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='product_name', y='total_sales')
                              fig = updateFig(fig, 'bar', 'Top 10 Sales', 'ชื่อสินค้า', 'จำนวน')
                              context.update({'chart5': fig.to_html()})
                    except:
                         None

                    if filter['filter'] == '':
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': showInfoFilter}
                    else:
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': filter}

                    return render(request, 'visualization/showinfo.html', context)
               
               elif filter['filter'] == 'income' or showInfoFilter['filter'] == 'income':
                    context = {'form': FilterData(init='income'), 'monthFilter': MonthYearFilter(monthYear=monthFilterCleaned['monthYear']), 'filter': 2}
         
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT total_income, total_net_income
                                        FROM total_income_before_after_discount
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              context.update(data[0])
                    except:
                         None
         
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, total_income
                                        FROM total_income_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='total_income')
                              fig = updateFig(fig, 'bar', 'รายได้แยกตามสาขา', 'สาขา', 'รายได้รวม')
                              context.update({'chart1': fig.to_html()})
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT receipt_type, total_income
                                        FROM total_income_by_type
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='receipt_type', y='total_income')
                              fig = updateFig(fig, 'bar', 'รายได้แยกตามประเภทใบเสร็จ', 'ประเภทใบเสร็จ', 'รายได้รวม')
                              context.update({'chart2': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT receipt_date, total_income
                                        FROM total_income_by_day
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              data = [{'receipt_date': d['receipt_date'].strftime('%Y-%m-%d'),
                                        'total_income': d['total_income']} for d in data]
                              fig = px.line(data, x='receipt_date', y='total_income')
                              fig = updateFig(fig, 'line', 'รายได้รายวัน', 'วันที่', 'รายได้รวม')
                              context.update({'chart3': fig.to_html()})
                    except:
                         None

                    if filter['filter'] == '':
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': showInfoFilter}
                    else:
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': filter}

                    return render(request, 'visualization/showinfo.html', context)
               
               elif filter['filter'] == 'expenses' or showInfoFilter['filter'] == 'expenses':
                    context = {'form': FilterData(init='expenses'), 'monthFilter': MonthYearFilter(monthYear=monthFilterCleaned['monthYear']), 'filter': 3}
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT total_expense, count
                                        FROM total_expense_and_count_by_month
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              context.update(data[0])
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, total_expense
                                        FROM total_expense_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='total_expense')
                              fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามสาขา', 'สาขา', 'ค่าใช้จ่ายรวม')
                              context.update({'chart1': fig.to_html()})
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT expense_name, total_expense
                                        FROM total_expense_by_type
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='expense_name', y='total_expense')
                              fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามประเภท', 'ประเภทค่าใช้จ่าย', 'ค่าใช้จ่ายรวม')
                              context.update({'chart2': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT daily_expense_date, total_expense
                                        FROM total_expense_by_day
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              data = [{'daily_expense_date': d['daily_expense_date'].strftime('%Y-%m-%d'),
                                        'total_expense': d['total_expense']} for d in data]
                              print(data)
                              fig = px.line(data, x='daily_expense_date', y='total_expense')
                              fig = updateFig(fig, 'line', 'รายจ่ายรายวัน', 'วันที่', 'ค่าใช้จ่ายรวม')
                              context.update({'chart3': fig.to_html()})
                    except:
                         None

                    if filter['filter'] == '':
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': showInfoFilter}
                    else:
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': filter}

                    return render(request, 'visualization/showinfo.html', context)
               elif filter['filter'] == 'employee' or showInfoFilter['filter'] == 'employee':
                    context = {'form': FilterData(init='employee'), 'monthFilter': MonthYearFilter(monthYear=monthFilterCleaned['monthYear']), 'filter': 4}

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT count_late, count_absent
                                        FROM total_emp_late_absent
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              context.update(data[0])
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, count_late
                                        FROM total_emp_late_absent_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='count_late')
                              fig = updateFig(fig, 'bar', 'พนักงานที่มาสายแยกตามสาขา', 'สาขา', 'จำนวนพนักงานที่มาสาย')
                              context.update({'chart1': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT branch_name, count_absent
                                        FROM total_emp_late_absent_by_branch
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='branch_name', y='count_absent')
                              fig = updateFig(fig, 'bar', 'พนักงานที่ไม่มาทำงานแยกตามสาขา', 'สาขา', 'จำนวนพนักงานที่ไม่มาทำงาน')
                              context.update({'chart2': fig.to_html()})
                    except:
                         None
                    
                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT by_date, count_late
                                        FROM total_emp_late_absent_by_day
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='by_date', y='count_late')
                              fig = updateFig(fig, 'bar', 'พนักงานที่มาสายแยกตามวัน', 'วันที่', 'จำนวนพนักงานที่มาสาย')
                              context.update({'chart3': fig.to_html()})
                    except:
                         None

                    try:
                         with connection.cursor() as cursor:
                              query = """
                                        SELECT by_date, count_absent
                                        FROM total_emp_late_absent_by_day
                                        WHERE month_year = %s
                                        """
                              cursor.execute(query, (monthFilterCleaned['monthYear'],))
                              data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                              fig = px.bar(data, x='by_date', y='count_absent')
                              fig = updateFig(fig, 'bar', 'พนักงานที่ไม่มาทำงานแยกตามวัน', 'วันที่', 'จำนวนพนักงานที่ไม่มาทำงาน')
                              context.update({'chart4': fig.to_html()})
                    except:
                         None

                    if filter['filter'] == '':
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': showInfoFilter}
                    else:
                         request.session.pop('showInfoFilter', None)
                         request.session['showInfoFilter'] = {'showInfoFilter': filter}
                    
                    return render(request, 'visualization/showinfo.html', context)

     else:
          form = FilterData(init='summary')
          monthFilter = MonthYearFilter(monthYear='2023-09')
          request.session.pop('showInfoFilter', None)
          request.session['showInfoFilter'] = {'showInfoFilter': {'filter': 'summary'}}
          context = {'form': form, 'monthFilter': monthFilter, 'filter': 1}
          
          try:
               with connection.cursor() as cursor:
                    query = """
                              SELECT total_expense, avg_expense, total_income, avg_income
                              FROM summary_view
                              WHERE month_year = %s
                              """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    context.update(data[0])
          except:
               None

          try:
               with connection.cursor() as cursor:
                    query = """
                              SELECT branch_name, total_income
                              FROM total_income_by_branch
                              WHERE month_year = %s
                              """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    fig = px.bar(data, x='branch_name', y='total_income')
                    fig = updateFig(fig, 'bar', 'รายได้แยกตามสาขา', 'สาขา', 'รายได้รวม')
                    context.update({'chart1': fig.to_html()})
          except:
               None

          try:
               with connection.cursor() as cursor:
                    query = """
                              SELECT branch_name, total_expense
                              FROM total_expense_by_branch
                              WHERE month_year = %s
                              """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    fig = px.bar(data, x='branch_name', y='total_expense')
                    fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามสาขา', 'สาขา', 'ค่าใช้จ่ายรวม')
                    context.update({'chart2': fig.to_html()})
          except:
               None

          try:
               with connection.cursor() as cursor:
                    query = """
                              SELECT receipt_type, total_income
                              FROM total_income_by_type
                              WHERE month_year = %s
                              """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    fig = px.bar(data, x='receipt_type', y='total_income')
                    fig = updateFig(fig, 'bar', 'รายได้แยกตามประเภทใบเสร็จ', 'ประเภทใบเสร็จ', 'รายได้รวม')
                    context.update({'chart3': fig.to_html()})
          except:
               None
          
          try:
               with connection.cursor() as cursor:
                    query = """
                         SELECT expense_name, total_expense
                         FROM total_expense_by_type
                         WHERE month_year = %s
                    """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    fig = px.bar(data, x='expense_name', y='total_expense')
                    fig = updateFig(fig, 'bar', 'ค่าใช้จ่ายแยกตามประเภท', 'ประเภทค่าใช้จ่าย', 'ค่าใช้จ่ายรวม')
                    context.update({'chart4': fig.to_html()})
          except:
               None

          try:
               with connection.cursor() as cursor:
                    query = """
                         SELECT product_name, total_sales
                         FROM top_ten_sales
                         WHERE month_year = %s
                         """
                    cursor.execute(query, ('2023-09',))
                    data = [dict(zip([col[0] for col in cursor.description], row)) for row in cursor.fetchall()]
                    fig = px.bar(data, x='product_name', y='total_sales')
                    fig = updateFig(fig, 'bar', 'Top 10 Sales', 'ชื่อสินค้า', 'จำนวน')
                    context.update({'chart5': fig.to_html()})
          except:
               None
          
          return render(request, 'visualization/showinfo.html', context)

@login_required
def cleanMonth(request):
     if request.method == 'POST':
          monthFilter = MonthYearFilter(request.POST)
          if monthFilter.is_valid():
               monthFilterCleaned = monthFilter.cleaned_data
               request.session.pop('monthFilterCleaned', None)
               request.session['monthFilterCleaned'] = {'monthFilterCleaned': monthFilterCleaned}
          return showInfo(request)

