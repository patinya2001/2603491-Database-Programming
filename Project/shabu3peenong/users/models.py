from django.db import models
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):
    branch_list = (
        (1, 'สาขาพหลโยธิน 52'),
        (2, 'สาขาม.รังสิต'),
        (3, 'สาขารังสิต 200 ปี'),
    )

    branch = models.IntegerField(choices=branch_list)