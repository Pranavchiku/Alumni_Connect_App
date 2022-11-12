from django.db import models
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField

class user(models.Model):
    name = models.CharField(max_length=100)

# Create your models here.

class custom_user(models.Model):
    name  = models.CharField(max_length= 100, null=False)
    email = models.CharField(max_length=100, null= False)
    phone = models.CharField(max_length=13, null = True)
    branch = models.CharField(max_length=50, null=False)
    year_joined = models.DateField()
    year_passed = models.DateField()
    password = models.CharField(max_length=50, null = False)
    connections = ArrayField(models.CharField(max_length=100), default=list)


