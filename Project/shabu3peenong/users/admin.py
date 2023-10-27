from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserCreationForm
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'is_superuser', 'branch')
    list_filter = ('is_superuser', 'branch')
    add_form = CustomUserCreationForm

admin.site.register(CustomUser, CustomUserAdmin)