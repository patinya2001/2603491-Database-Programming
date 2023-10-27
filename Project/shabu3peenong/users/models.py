from django.db import models
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):
    branch_list = (
        ('0', 'สาขาพหลโยธิน 52'),
        ('1', 'สาขารังสิต 200 ปี'),
        ('2', 'สาขาม.รังสิต'),
    )

    branch = models.CharField(max_length=20, choices=branch_list)