from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from django.http import HttpResponse
import datetime
import os
from django.conf import settings

def home_view(request):
    # Используем шаблон home.html
    return render(request, 'app/home.html')

def current_time_view(request):
    # Получаем текущее время
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return HttpResponse(f"Текущее время: {current_time}")

def workdir_view(request):
    # Получаем список файлов в рабочей директории
    workdir = os.listdir(settings.BASE_DIR)
    # Форматируем вывод
    file_list = "<br>".join(workdir)
    return HttpResponse(f"Содержимое рабочей директории:<br>{file_list}")