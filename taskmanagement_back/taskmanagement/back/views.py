from asyncio.windows_events import NULL
from datetime import datetime
import email
from genericpath import exists
from unicodedata import name
from django.shortcuts import render
from django.utils import timezone
# from requests import session
from rest_framework.response import Response
from django.http import HttpResponse, response
from rest_framework.generics import GenericAPIView, CreateAPIView, ListAPIView, RetrieveAPIView
from . import models
from . import serializers
from datetime import datetime, timedelta

class CreateAccount(CreateAPIView):
    serializer_class = serializers.PersonSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        email = request.data.get('email')
        password = request.data.get('password')

        allusernames = models.Person.objects.values_list('username' , flat=True)
        allemails = models.Person.objects.values_list('email' , flat=True)

        if (username in allusernames):
            return Response({"msg" : "This username already exists" , "status": 500})
        if (email in allemails):
            return Response({"msg" : "This email already exists" , "status": 500})
        if (username is None or email is None or password is None):
            return Response({"msg" : "Fill all the filds" , "status": 500})
        else:
            newPerson = models.Person(username=username , password = password,
                                      email = email )
            newPerson.save()
            print("newperson added to database")
            return Response({"msg" : "newperson added to database" , "pk" : newPerson.pk , "status": 200})

class Login(CreateAPIView):
    serializer_class = serializers.PersonSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        password = request.data.get('password')
        allusernames = models.Person.objects.values_list('username' , flat=True)
        if (username is None or password is None):
            return Response({"msg" : "fill all the fields" ,"status": 200})
        elif username in allusernames :
            person = models.Person.objects.get(username = username)
            if person.password == password :
                return Response({"msg" : "successful","pk" : person.pk ,"status": 200})
            else :
                return Response({"msg" : "Wrong password" ,"status": 200})
        else :
            return Response({"msg" : "wrong username" ,"status": 200})

class CreateBoard(CreateAPIView):
    serializer_class = serializers.BoardSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):

        personID = request.data.get('pk')
        members = request.data.get('members') ##it is a list wich contains username or email or both
        boardName = request.data.get('boardName')
        sessions = request.data.get('holdings')
        
        description = request.data.get('description')

        owner = models.Person.objects.get(pk = personID)
        allBoards = models.Board.objects.filter(owner = owner).values_list('name' , flat= True)

        if boardName in allBoards:
            return Response({"msg" : "You already have a board with this name!" ,"status": 200})

        else: ##here we have to create the board
            allPersons = models.Person.objects.all()
            membersList = []
            allsessions = []
            
            newBoard = models.Board(name = boardName , owner = owner , 
            # create_time = datetime.now ,
            description = description)
            newBoard.save()
            print("newBoard added !")

            for member in members:
                for person in allPersons :
                    if member == person.username:
                        membersList.append(person)
                        newBoard.members.add(person)
                    if member == person.email :
                        membersList.append(person)
                        newBoard.members.add(person)
                    else:
                        print("invalid member name or email")
                        print("persons")
                        print(person.username)
                        # return Response({"msg" : "invalid name or email!" , "status" : 200})        
            if sessions is not None:
                print("is not none")
                for eachSession in sessions :
                    
                    newSession = models.Holding(board = newBoard , day = eachSession[5:15] ,
                     startTime = eachSession[28:33] , endTime = eachSession[44:49])
                    newSession.save()
            else:
                print("is none")

            
            return Response({"msg" : "board and sessions added!" , "status" : 200})

class ProfileData(CreateAPIView):
    serializer_class = serializers.PersonSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personID = request.data.get("personID")
        print("person id is :")
        print(personID)
        person = models.Person.objects.get(pk = personID)
        print("person is :")
        print(person)
        username = person.username
        birthday = person.birthday
        email = person.email
        phoneNumber = person.phoneNumber
        about = person.about
        pic = person.pic
        password = person.password
        return Response({
            "msg" : "success" ,
            "username" : username ,
            "password" : password ,
            "birthday" : birthday ,
            "phoneNumber" : phoneNumber ,
            "about" : about ,
            "pic" : pic ,
            "email" : email
            })

class ChangeProfile(CreateAPIView):
    serializer_class = serializers.PersonSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        username = request.data.get("username")
        email = request.data.get("email")
        birthday = request.data.get("birthday")
        phoneNumber = request.data.get("phoneNumber")
        about = request.data.get("about")
        pk = request.data.get("pk")
        print("about")
        print(about)
        person = models.Person.objects.get(pk = pk)
        person.email = email
        person.username = username
        person.birthday = birthday
        person.phoneNumber = phoneNumber
        person.about = about
        person.save()
        return Response({
            "msg" : "success" ,
            "username" : person.username ,
            "birthday" : person.birthday ,
            "phoneNumber" : person.phoneNumber ,
            "about" : person.about ,
            "email" : person.email
            })

class AddTaskDailyCalendar(CreateAPIView):
    serializer_class = serializers.TaskSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        memberID = request.data.get("pk")
        startTime = request.data.get("startTime")
        endTime = request.data.get("endTime")
        deadlineDate = request.data.get("date")
        taskName = request.data.get('name')

        person = models.Person.objects.get(pk = memberID)
        newTask = models.Task(name = taskName , startTime = startTime ,
         endTime = endTime , deadlineDay = deadlineDate , create_time = datetime.now())
        newTask.save()
        newTask.members.add(person)
        newTask.save()
        return Response({
            "new task added"
            })

        #################################################
        # boards = models.Board.objects.filter(members = person)
        # sessionLists = []
        # for board in boards :
        #     sessions = models.Holding.objects.filter(board = board , day = today)
        #     print("mitra")
        #     print(sessions)
        #     print("end mitra")
        #     for session in sessions :
        #         sessionLists.append(session)
        

        # for item in sessionLists:
        #     temp = {}
        #     temp["name"] = item.name
        #     temp["startTime"] = item.startTime
        #     temp["endTime"] = item.endTime
        #     todayTasks.append(temp)
        #     temp["boardName"] = item.board.name
        # print("session list is:")
        # print(sessionLists)

        #################################################
class DailyCalendar(CreateAPIView):
    serializer_class = serializers.TaskSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personID = request.data.get("pk")
        person = models.Person.objects.get(pk = personID)
        today = timezone.now().date()
        todayTasks = []

        TaskLists = models.Task.objects.filter(members= person, deadlineDay=today)
        if TaskLists.exists() :
            for item in TaskLists:
                temp = {}
                temp["name"] = item.name
                temp["startTime"] = item.startTime
                temp["endTime"] = item.endTime
                temp["is_done"] = item.is_done
                todayTasks.append(temp)
                if item.boardList != None :
                    temp["boardName"] = item.boardList.board.name
                else:
                    temp["boardName"] = None

        return Response(todayTasks)

class AllBoards(CreateAPIView):
    serializer_class = serializers.BoardSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personID = request.data.get("pk")
        person = models.Person.objects.get(pk = personID)
        allBoards = []
        allBoardsOwnered = models.Board.objects.filter(owner = person)
        allBoardsMemberIn = models.Board.objects.filter(members = person)

        for item in allBoardsOwnered:
            temp = {}
            members = []
        
            temp["pk"] = item.pk
            temp["boardName"] = item.name
            temp["description"] = item.description
            memberList = item.members.all()
            if memberList.exists() :
                for member in memberList :
                    members.append(member.username)

            temp["members"] = members
            allBoards.append(temp)

        for item in allBoardsMemberIn:
            temp = {}
            temp["pk"] = item.pk
            temp["boardName"] = item.name
            allBoards.append(temp)

        return Response(allBoards)


class SingleBoard(CreateAPIView):
    serializer_class = serializers.BoardSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        boardPk = request.data.get("pk")
        board = models.Board.objects.get(pk = boardPk)
        lists = models.BoardList.objects.filter(board = board)
        membersList = []
        boardLists = []
        boardResult = {}

        for member in board.members.all() :
            temp = {}
            temp["name"] = member.username
            temp["pk"] = member.pk
            membersList.append(temp)
        
        # boardLists["members"] = membersList

        for list in lists:
            temp = {}
            temp["listName"] = list.name
            temp["listPk"] = list.pk
            tasks = models.Task.objects.filter(boardList = list)
            taskList = []
            for task in tasks :
                temp2 = {}
                temp2["taskName"] = task.name
                temp2["taskPk"] = task.pk
                taskList.append(temp2)
            temp["tasks"] = taskList
            boardLists.append(temp)

        boardResult["boardName"] = board.name
        boardResult["members"] = membersList
        boardResult["lists"] = boardLists

        return Response(boardResult)

        

class NewList(CreateAPIView):
    serializer_class = serializers.BoardListSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        boardPk = request.data.get("pk")
        listName = request.data.get("listName")
        listDescription = request.data.get("description")
        board = models.Board.objects.get(pk = boardPk)
        newList = models.BoardList(board = board , name = listName , description = listDescription)
        newList.save()

        return Response({"msg" : "new list addded!"})
    

class NewTask(CreateAPIView):
    serializer_class = serializers.TaskSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personPk = request.data.get("personPk")
        person = models.Person.objects.get(pk = personPk)
        listPk = request.data.get("pk")
        boardList = models.BoardList.objects.get(pk = listPk)
        taskName = request.data.get("taskName")
        description = request.data.get("description")
        date = request.data.get("date")
        startTime = request.data.get("startTime")
        endTime = request.data.get("endTime")
        membersIds = request.data.get("members")
        members = []

        newTask = models.Task(boardList = boardList ,name = taskName ,
         description = description , startTime = startTime , endTime = endTime , deadlineDay = date ,
        is_done = False)
        newTask.save()
        newTask.members.add(person)
        newTask.save()
        for id in membersIds:
            member = models.Person.objects.get(pk = id)
            newTask.members.add(member)
            newTask.save()

        return Response({"msg" : "new task added!"})

class ListData(CreateAPIView):
    serializer_class = serializers.BoardListSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        listPk = request.data.get("pk")
        list = models.BoardList.objects.get(pk = listPk)

        res = {}
        res["boardName"] = list.board.name 
        res["listName"] = list.name
        res["description"] = list.description
        res["createDate"] = list.create_time

        return Response(res)

class deleteList(CreateAPIView):
    serializer_class = serializers.BoardListSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        listPk = request.data.get("pk")
        list = models.BoardList.objects.get(pk = listPk)
        list.remove()
        return Response({"msg" : "list deleted"})

class deleteTask(CreateAPIView):
    serializer_class = serializers.TaskSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        taskPk = request.data.get("pk")
        task = models.Task.objects.get(pk = taskPk)
        task.remove()
        return Response({"msg" : "task deleted"})

class deleteBoard(CreateAPIView):
    serializer_class = serializers.BoardSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        boardPk = request.data.get("pk")
        board = models.Task.objects.get(pk = boardPk)
        board.remove()
        return Response({"msg" : "board deleted"})

class weeklyCalendar(CreateAPIView):
    serializer_class = serializers.TaskSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personPk = request.data.get("pk")
        person = models.Person.objects.get(pk = personPk)
        today = datetime.today()
        todayweekday = today.weekday()
        sat = today
        friday = today
        # find previous saturday
        while True:
            if sat.weekday() == 5 :
                break
            sat = sat - timedelta(days=1)
        # find next friday
        while True:
            if friday.weekday() == 5 :
                break
            friday = friday + timedelta(days=1)
        allTasks = []
        for i in range(0,6):
            taskList = models.Task.objects.filter(members = person , deadlineDay = sat + timedelta(days=i))
            for task in taskList:
                allTasks.append(task)    
        res = []
        for item in allTasks:
            temp = {}
            temp["name"] = item.name
            temp["startTime"] = item.startTime
            temp["endTime"] = item.endTime
            temp["day"] = item.deadlineDay
            res.append(temp)
        return Response(res)

class changePassword(CreateAPIView):
    serializer_class = serializers.PersonSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):
        personPk = request.data.get("pk")
        oldPass = request.data.get("oldPassword")
        newPass = request.data.get("newPassword")
        person = models.Person.objects.get(pk = personPk)
        if person.password == oldPass :
            person.password = newPass
            person.save()
            return Response({"msg" : "password changed succesfully!"})
        else:
            return Response({"msg" :"incorrect old password"})

class showList(CreateAPIView):
    serializer_class = serializers.BoardListSerializer
    allowed_methods = ["POST"]
    def post(self, request, *args, **kwargs):

        listPk = request.data.get("pk")
        list = models.BoardList.objects.get(pk = listPk)
        listName = list.name
        listDescription = list.description
        create_time = list.create_time

        res = {}
        res["name"] = listName
        res["description"] = listDescription
        res["create_time"] = create_time

        return Response(res)

from django.core.mail import send_mail

class sendEmail(CreateAPIView):
    today = timezone.now().date()
    allTasks = models.Task.objects.all()
    for task in allTasks:
        if task.deadlineDay == today :
            members = task.members.all()
            for member in members :
                msg = "Hi " + member.name + "!     " +task.name + "has to be done today! dont forget :)"
                send_mail(
                    'task reminder', #subject
                    msg , #message
                    "managementproject2223@gmail.com" , #from
                    [member.email ], #to
                    fail_silently= False
                )
                    





        





