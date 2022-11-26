from django.shortcuts import render
from django.http import JsonResponse
from django.core import serializers
from home.models import *
from rest_framework import views
from rest_framework.decorators import api_view

# Create your views here.
@api_view(['GET'])
def get_user_info(request):
	user_info = serializers.serialize('json', Userinfo.objects.all())
	data = {
		"status": "success",
		"message": "User info fetched successfully",
		"data": user_info
	}
	return JsonResponse(data)
