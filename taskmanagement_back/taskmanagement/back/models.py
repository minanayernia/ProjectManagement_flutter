from pyexpat import model
from django.db import models

class Person(models.Model):
    username    = models.CharField(max_length=30)
    email       = models.CharField(max_length=256)
    pic         = models.CharField(max_length=256 ,null=True , blank= True)
    password    = models.CharField(max_length=20)
    about       = models.CharField(max_length=256 ,null=True , blank= True)
    phoneNumber = models.CharField(max_length=20 , null=True , blank= True)
    birthday    = models.DateField(null = True)
    def __str__(self) -> str:
        return str(self.username) + str(self.pk)

class Board(models.Model):
    name        = models.CharField(max_length=30)
    description = models.CharField(max_length=256)
    owner       = models.ForeignKey(Person , on_delete=models.CASCADE , related_name="owner")
    members     = models.ManyToManyField(Person , null=True , blank=True , related_name="members")
    create_time = models.DateTimeField(auto_now_add=True)
    def __str__(self) -> str:
        return str(self.name)

class Holding(models.Model):
    board       = models.ForeignKey(Board , on_delete=models.CASCADE)
    day         = models.DateField(null=True , blank=True)
    startTime   = models.TimeField(null=True , blank=True)
    endTime     = models.TimeField(null=True , blank=True)
    def __str__(self) -> str:
        return str(self.board.name) + str(self.day) + str(self.startTime) + str(self.endTime)

class BoardList(models.Model):
    board       = models.ForeignKey(Board , on_delete=models.CASCADE)
    name        = models.CharField(max_length=30)
    description = models.CharField(max_length=256)
    create_time = models.DateTimeField(auto_now_add=True)
    def __str__(self) -> str:
        return str(self.name)

class Task(models.Model):
    boardList   = models.ForeignKey(BoardList , on_delete=models.CASCADE , null=True , blank=True)
    name        = models.CharField(max_length=30)
    description = models.CharField(max_length=256, null=True , blank=True)
    members     = models.ManyToManyField(Person ,null=True , blank=True)
    deadlineDay = models.DateField(null=True , blank=True)
    startTime   = models.TimeField(null=True , blank=True)
    endTime     = models.TimeField(null=True , blank=True)
    create_time = models.DateTimeField(auto_now_add=True)
    is_done     = models.BooleanField(null=True , blank=True)
    def __str__(self) -> str:
        return str(self.name)

class Comment(models.Model):
    text        = models.CharField(max_length=256)
    person      = models.ForeignKey(Person , on_delete=models.CASCADE)
    task        = models.ForeignKey(Task , on_delete=models.CASCADE) 
    def __str__(self) -> str:
        return str(self.text)