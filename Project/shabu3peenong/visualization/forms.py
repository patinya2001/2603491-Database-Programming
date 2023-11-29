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
    CSVFile = forms.FileField()