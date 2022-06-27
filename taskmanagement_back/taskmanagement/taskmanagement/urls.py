"""taskmanagement URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from back import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('CreateAccount/', views.CreateAccount.as_view()) ,
    path('login/', views.Login.as_view()),
    path('CreateBoard/' , views.CreateBoard.as_view()),
    path('Profile/' , views.ProfileData.as_view()),
    path('ChangeProfile/' , views.ChangeProfile.as_view()),
    path('AddTaskDailyCalendar/' , views.AddTaskDailyCalendar.as_view()),
    path('DailyCalendar/', views.DailyCalendar.as_view()),
    path('allBoards/' , views.AllBoards.as_view()),
    path('singleBoard/' , views.SingleBoard.as_view()),
    path('newList/' , views.NewList.as_view()),
    path('addNewTask/' , views.NewTask.as_view()),
    path('weeklyCalendar/' , views.weeklyCalendar.as_view()),
    path('changePassword/' , views.changePassword.as_view())
    # path('singleBoard/' , views.SingleBoard.as_view())

]
