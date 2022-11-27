from django.shortcuts import render
from django.http import JsonResponse
from django.core import serializers
from home.models import *
from rest_framework import views
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import json

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

@api_view(['POST'])
def user_login(request):
	body = request.body.decode('utf-8')
	body = json.loads(body)

	try:
		if Userinfo.objects.get(email=body['email']) or Userinfo.objects.get(phone=body['email']):
			if Userinfo.objects.get(email=body['email']).password == body['password'] or Userinfo.objects.get(phone=body['email']).password == body['password']:
				return Response(json.dumps({"message": "User succesfully logged in."}), status=status.HTTP_202_ACCEPTED, content_type='application/json')
			else:
				return Response(json.dumps({"message": "Password is incorrect."}), status=status.HTTP_400_BAD_REQUEST, content_type='application/json')
	except:
		return Response(json.dumps({"message": "User does not exist."}), status=status.HTTP_400_BAD_REQUEST, content_type='application/json')


@api_view(['POST'])
def user_signup(request):
	body = request.body.decode('utf-8')
	body = json.loads(body)

	try:
		if Userinfo.objects.get(email=body['email']) or Userinfo.objects.get(phone=body['email']):
				return Response(json.dumps({"message": "User already exists."}), status=status.HTTP_400_BAD_REQUEST, content_type='application/json')
	except Userinfo.DoesNotExist:
		pass

	new_user = Userinfo.objects.create(
		name = body['name'],
		email = body['email'],
		phone = body['phone'],
		password = body['password'],
	)

	res = Response(json.dumps({"message": "User succesfully created."}), status=status.HTTP_201_CREATED, content_type='application/json')

	return res

@api_view(['POST'])
def user_work_fields(request):
	body = request.body.decode('utf-8')
	body = json.loads(body)

	curr_user = Userinfo.objects.get(email=body['email'])
	new_user = Workfield.objects.create(
		email = curr_user,
		SDE = body['SDE'],
		ML_DL = body['ML_DL'],
		DS = body['DS'],
		Management = body['Management'],
		Others = body['Others']
	)

	res = Response(json.dumps({"message": "User work fields succesfully created."}), status=status.HTTP_201_CREATED, content_type='application/json')

	return res