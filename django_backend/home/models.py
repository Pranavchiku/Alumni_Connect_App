from django.db import models
from django.contrib.postgres.fields import ArrayField


# Create your models here.

class customuser(models.Model):
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100, default=None)
    phone = models.CharField(max_length=13, default=None)
    branch = models.CharField(max_length=50, default=None)
    isAlumni = models.BooleanField(default=1) #if 1 then alumni, if not , then i dont know

    #fields for students/alumni
    SDE = models.BooleanField(default=False)
    ML_DL = models.BooleanField(default=False)
    DS = models.BooleanField(default=False)
    Management = models.BooleanField(default=False)
    Others = models.BooleanField(default=False)

    year_joined = models.DateField(default=None)
    year_passed = models.DateField(default= None)
    password = models.CharField(max_length=50 ,default = None)
    working_experience = models.IntegerField(default = None)
    company = models.CharField(max_length=100 ,default = None)
    # connections = ArrayField(models.CharField(max_length=100, default=None), default=None)
    connections = models.ManyToManyField('self')

class post(models.Model):
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=100, default=None)
    date = models.DateField( default=None)
    image = models.CharField(max_length=100, default=None)
    descript = models.CharField(max_length=500,  default=None)

class Userinfo(models.Model):
    email = models.CharField(max_length=100, unique = True)
    name = models.CharField(max_length=100, default = None)
    phone = models.CharField(max_length=13, default=None)
    password = models.CharField(max_length=50, default=None)

class Educationinfo(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    degree = models.CharField(max_length=100, default=None)
    branch = models.CharField(max_length=50, default=None)
    year_joined = models.DateField(default=None)
    year_passed = models.DateField(default=None)

class Workinfo(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    company = models.CharField(max_length=100, default=None)
    working_experience = models.IntegerField(default=None)

class Workfield(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    SDE = models.BooleanField(default=False)
    ML_DL = models.BooleanField(default=False)
    DS = models.BooleanField(default=False)
    Management = models.BooleanField(default=False)
    Others = models.BooleanField(default=False)

class Userconnection(models.Model):
    user_email = models.ForeignKey(Userinfo, on_delete=models.CASCADE, related_name='user_email')
    connections = models.ManyToManyField(Userinfo, related_name='connections')

class Userpost(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    date = models.DateField(default=None)
    image = models.CharField(max_length=100, default=None)
    descript = models.CharField(max_length=500, default=None)
    