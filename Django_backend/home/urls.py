

from django.urls import path
from .views import *

urlpatterns = [
    path('get_user_info/', get_user_info, name="Userinfo"),
    path('user_login/', user_login, name="Userlogin"),
    path('user_signup/', user_signup, name="Usersignup"),
    path('user_work_fields/', user_work_fields, name="Userworkfields"),
    path('user_education_info/', user_education_info, name="Usereducationinfo"),
    path('user_work_info/', user_work_info, name="Userworkinfo"),
    path('top_suggestion/', top_suggestion, name="Topsuggestions"),
    path('field_count/', get_field_count, name="Fieldcount"),
    path('get_sde/', get_sde, name="SDE"),
    path('get_ml_dl/', get_ml_dl, name="ML_DL"),
    path('get_ds/', get_ds, name="DS"),
    path('get_management/', get_management, name="Management"),
    path('connect_user/', connection_request, name="Connectuser"),
    path('create_post/', create_post, name="Createpost"),
    path('get_posts/', get_posts, name="Getposts"),
    path('get_all_users/', get_all_users, name="Getallusers"),
]