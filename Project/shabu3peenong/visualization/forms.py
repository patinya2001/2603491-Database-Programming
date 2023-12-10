from django import forms
from django.db import connection

class FilterInsert(forms.Form):
    def __init__(self, *args, is_superuser=False, **kwargs):
        super(FilterInsert, self).__init__(*args, **kwargs)

        if is_superuser:
            field_choices = [
                ('product', 'เพิ่มสินค้า'),
                ('expenses', 'ค่าใช้จ่าย'),
                ('activity', 'เช็คชื่อพนักงาน'),
            ]
        else:
            field_choices = [
                ('expenses', 'ค่าใช้จ่าย'),
                ('activity', 'เช็คชื่อพนักงาน'),
            ]

        self.fields['filter'] = forms.ChoiceField(choices=field_choices, required=False, label='หมวดหมู่')

class InsertProduct(forms.Form):
    SKU = forms.IntegerField(required=True, label='รหัส SKU')
    salesType = forms.ChoiceField(required=True, label='ประเภทการขาย')
    productName = forms.CharField(required=True, label='ชื่อสินค้า')
    productPrice = forms.FloatField(required=True, label='ราคา')
    productCost = forms.FloatField(required=True, label='ต้นทุน')
    productDescription = forms.CharField(required=False, label='คำอธิบาย')

    def __init__(self, *args, **kwargs):
        super(InsertProduct, self).__init__(*args, **kwargs)

        with connection.cursor() as cursor:
            cursor.execute("SELECT sales_id, sales_name FROM sales_type")
            field = cursor.fetchall()

        self.fields['salesType'] = forms.ChoiceField(required=True, choices=field, label='ประเภทการขาย')

class CSVUploadForm(forms.Form):
    CSVFile = forms.FileField(label='เลือกไฟล์ CSV')

class FilterData(forms.Form):
    field = [
        ('showInfo', 'ข้อมูลทั้งหมด'),
        ('average', 'ค่าเฉลี่ย'),
    ]

    filter = forms.ChoiceField(choices=field, required=False, label='หมวดหมู่')

class FilterCSV(forms.Form):
    field = [
        ('receipts', 'Receipts'),
        ('itemSales', 'Item Sales'),
    ]

    filter = forms.ChoiceField(choices=field, required=False, label='ประเภทไฟล์')

class DailyExpense(forms.Form):
    expenseType = forms.ChoiceField(required=True, label='ประเภทค่าใช้จ่าย')
    expenseBranch = forms.ChoiceField(required=True, label='สาขา')
    expenseDate = forms.DateTimeField(
        required=True,
        label='วันที่',
        widget=forms.DateTimeInput(attrs={'type': 'datetime-local'}),
        input_formats=['%Y-%m-%dT%H:%M'],
    )
    expensePrice = forms.FloatField(required=True, label='จำนวน (บาท)')
    expenseDescription = forms.CharField(required=False, label='คำอธิบาย')

    def __init__(self, *args, **kwargs):
        super(DailyExpense, self).__init__(*args, **kwargs)

        with connection.cursor() as cursor:
            cursor.execute("SELECT expense_id, expense_name FROM expense_type")
            expense_type_field = cursor.fetchall()

        self.fields['expenseType'] = forms.ChoiceField(required=True, choices=expense_type_field, label='ประเภทค่าใช้จ่าย')

        with connection.cursor() as cursor:
            cursor.execute("SELECT branch_id, branch_name FROM branch WHERE branch_id != 0")
            branch_field = cursor.fetchall()

        self.fields['expenseBranch'] = forms.ChoiceField(required=True, choices=branch_field, label='สาขา')