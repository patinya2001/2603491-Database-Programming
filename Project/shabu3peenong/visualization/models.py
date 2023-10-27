from django.db import models

class DailyPerformance(models.Model):
    date = models.DateTimeField()
    cash = models.IntegerField()
    transferPayment = models.IntegerField()
    delivery = models.IntegerField()