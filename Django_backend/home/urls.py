

from django.urls import path
from .views import *

urlpatterns = [
    path('get_user_info/', get_user_info, name="Userinfo"),
    path('user_login/', user_login, name="Userlogin"),
    path('user_signup/', user_signup, name="Usersignup"),
    path('user_work_fields/', user_work_fields, name="Userworkfields"),
]