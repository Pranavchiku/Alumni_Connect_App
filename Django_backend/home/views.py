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

	print(body['email'])
	try:
		if Userinfo.objects.get(email=body['email']) or Userinfo.objects.get(phone=body['email']):
			if (Userinfo.objects.get(email=body['email']).password == body['password'] )or Userinfo.objects.get(phone=body['email']).password == body['password']:
				message = {
					"message": "Login successful",
				}
				return Response(message, status=status.HTTP_200_OK)


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

@api_view(['POST'])
def user_education_info(request):
	body = request.body.decode('utf-8')
	body = json.loads(body)

	curr_user = Userinfo.objects.get(email=body['email'])
	year_of_joining = body['year_joined'] + "-01-01"
	year_of_passing = body['year_passed'] + "-01-01"
	new_user = Educationinfo.objects.create(
		email = curr_user,
		degree = body['degree'],
		year_joined = year_of_joining,
		year_passed = year_of_passing,
		branch = body['branch'],
	)

	res = Response(json.dumps({"message": "User education info succesfully created."}), status=status.HTTP_201_CREATED, content_type='application/json')

	return res

@api_view(['POST'])
def user_work_info(request):
	body = request.body.decode('utf-8')
	body = json.loads(body)

	curr_user = Userinfo.objects.get(email=body['email'])
	new_user = Workinfo.objects.create(
		email=curr_user,
		company = body['company'],
		working_experience = body['work']
	)

	res = Response(json.dumps({"message": "Work info succesfully created."}), status=status.HTTP_201_CREATED, content_type='application/json')

	return res
@api_view(['POST','GET'])
def top_suggestion(request):
	
	body = request.body.decode('utf-8')
	body = json.loads(body)

	curr_user = Userinfo.objects.get(email=body['email'])
	user_fields = Workfield.objects.get(email = curr_user)
	SDE = user_fields.SDE
	ML_DL = user_fields.ML_DL
	DS = user_fields.DS
	Management = user_fields.Management
	Others = user_fields.Others

	if SDE:
		# find those users who have SDE in their fields
		suggestions = serializers.serialize('json', Workfield.objects.filter(SDE=True))
		# make suggestion a json
		suggestions = json.loads(suggestions)

		#iterate over suggestions, and find name of the user with same email
		final_list = []
		for suggestion in suggestions:
			print(suggestion)
			email = suggestion['fields']['email']
			print(email)
			user = Userinfo.objects.get(id=email)
			dict = {
				"name": user.name,
				"email": user.email
			}
			final_list.append(dict)

		
		top_suggestion_list = {
			"top_suggestion": final_list
		}
		return Response(top_suggestion_list, status=status.HTTP_200_OK)
	elif ML_DL:
		suggestions = serializers.serialize('json', Workfield.objects.filter(ML_DL=True))
		suggestions = json.loads(suggestions)

		print(suggestions)
		#iterate over suggestions, and find name of the user with same email
		final_list = []
		for suggestion in suggestions:
			print(suggestion)
			email = suggestion['fields']['email']
			print(email)
			user = Userinfo.objects.get(id=email)
			dict = {
				"name": user.name,
				"email": user.email
			}
			final_list.append(dict)

		top_suggestion_list = {
			"top_suggestion": final_list
		}
		return Response(top_suggestion_list, status=status.HTTP_200_OK)
	elif DS:
		suggestions = serializers.serialize('json', Workfield.objects.filter(DS=True))
		suggestions = json.loads(suggestions)

		print(suggestions)
		#iterate over suggestions, and find name of the user with same email
		final_list = []
		for suggestion in suggestions:
			print(suggestion)
			email = suggestion['fields']['email']
			print(email)
			user = Userinfo.objects.get(id=email)
			final_list.append(dict)


		top_suggestion_list = {
			"top_suggestion": final_list
		}
		return Response(top_suggestion_list, status=status.HTTP_200_OK)
	elif Management:
		suggestions = serializers.serialize('json', Workfield.objects.filter(Management=True))
		suggestions = json.loads(suggestions)

		print(suggestions)
		#iterate over suggestions, and find name of the user with same email
		final_list = []
		for suggestion in suggestions:
			print(suggestion)
			email = suggestion['fields']['email']
			print(email)
			user = Userinfo.objects.get(id=email)
			dict = {
				"name": user.name,
				"email": user.email
			}
			final_list.append(dict)

		top_suggestion_list = {
			"top_suggestion": final_list
		}
		return Response(top_suggestion_list, status=status.HTTP_200_OK)
	elif Others:
		suggestions = serializers.serialize('json', Workfield.objects.filter(Others=True))
		suggestions = json.loads(suggestions)

		print(suggestions)
		#iterate over suggestions, and find name of the user with same email
		final_list = []
		for suggestion in suggestions:
			print(suggestion)
			email = suggestion['fields']['email']
			print(email)
			user = Userinfo.objects.get(id=email)
			dict = {
				"name": user.name,
				"email": user.email
			}
			final_list.append(dict)

		top_suggestion_list = {
			"top_suggestion": final_list
		}
		return Response(top_suggestion_list, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_field_count(request):
	sde_count = Workfield.objects.filter(SDE=True).count()
	ml_dl_count = Workfield.objects.filter(ML_DL=True).count()
	ds_count = Workfield.objects.filter(DS=True).count()
	management_count = Workfield.objects.filter(Management=True).count()

	field_count = {
		"SDE": sde_count,
		"ML_DL": ml_dl_count,
		"DS": ds_count,
		"Management": management_count
	}

	return Response(field_count, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_sde(request):
	sde = Workfield.objects.filter(SDE=True)
	sde = serializers.serialize('json', sde)
	sde = json.loads(sde)

	final_list = []
	for user in sde:
		email = user['fields']['email']
		user = Userinfo.objects.get(id=email)
		dict = {
			"name": user.name,
			"email": user.email
		}
		final_list.append(dict)

	return Response(final_list, status=status.HTTP_200_OK)
