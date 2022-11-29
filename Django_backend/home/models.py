from django.db import models
from django.contrib.postgres.fields import ArrayField


# Create your models here.
class Userinfo(models.Model):
    email = models.CharField(max_length=100, unique = True)
    name = models.CharField(max_length=100, default = None)
    phone = models.CharField(max_length=13, default=None)
    password = models.CharField(max_length=50, default=None)
    image = models.CharField(max_length=100, default=None)

    def __str__(self):
        return self.name

class Educationinfo(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    degree = models.CharField(max_length=100, default=None)
    branch = models.CharField(max_length=50, default=None)
    year_joined = models.CharField(max_length=50, default=None)
    year_passed = models.CharField(max_length=50, default=None)


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
    connections = models.ManyToManyField(Userinfo, related_name='connections', blank=True, null = True)
    first_time = models.BooleanField(default=True)


class Userpost(models.Model):
    email = models.ForeignKey(Userinfo, on_delete=models.CASCADE)
    date = models.DateField(default=None)
    image = models.CharField(max_length=100, default=None)
    descript = models.CharField(max_length=500, default=None)

    class Meta:
        ordering = ['-date']
