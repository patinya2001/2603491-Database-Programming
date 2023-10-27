from django.http import HttpResponseRedirect
from django.http import HttpRequest
from django.shortcuts import render
from .forms import CustomUserCreationForm
from django.urls import reverse

def register(request: HttpRequest):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('complete'))
    else:
        form = CustomUserCreationForm()
        
    context = {'form': form}
    return render(request, 'users/register.html', context)