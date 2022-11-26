from django.db import models
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField

class custom_user(models.Model):
    name  = models.CharField(max_length= 100)
    profile= models.CharField(max_length= 100)
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=13)
    branch = models.CharField(max_length=50)
    isAlumni = models.BooleanField(default=1) #if 1 then alumni, if not , then i dont know
    year_joined = models.DateField()
    year_passed = models.DateField(default=True)
    password = models.CharField(max_length=50)
    connections = ArrayField(models.CharField(max_length=100), default=list)
    company = models.CharField(max_length=100)
    working_experience = models.IntegerField()
    
    #fields for students/alumni
    SDE = models.BooleanField(default=False)
    ML_DL = models.BooleanField(default=False)
    DS = models.BooleanField(default=False)
    Management = models.BooleanField(default=False)
    Others = models.BooleanField(default=False)



    

