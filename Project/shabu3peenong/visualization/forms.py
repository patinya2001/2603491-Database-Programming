from django import forms
from .models import DailyPerformance

class RecordModelForm(forms.ModelForm):
    class Meta:
        model = DailyPerformance
        fields = ['date', 'cash', 'transferPayment', 'delivery']
        labels = {
            'date': 'วันที่',
            'cash': 'เงินสด',
            'transferPayment': 'เงินโอน',
            'delivery': 'Delivery'
        }

        widgets = {
            'date': forms.DateInput(attrs={'type': 'date'})
        }

class CSVUploadForm(forms.Form):
    CSVFile = forms.FileField(label='เลือกไฟล์ CSV')

class FilterData(forms.Form):
    field = [
        ('showInfo', 'ข้อมูลทั้งหมด'),
        ('average', 'ค่าเฉลี่ย'),
    ]

    filter = forms.ChoiceField(choices=field, required=False)