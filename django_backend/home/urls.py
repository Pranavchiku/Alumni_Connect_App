

from django.urls import path
from .views import *

urlpatterns = [
    path('get_user_info/', get_user_info, name="Userinfo"),
]