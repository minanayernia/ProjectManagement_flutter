import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_taskmanagement/Login.dart';
import 'package:my_taskmanagement/SingleBoard.dart';

class DataProvider{

  static Future<Map> createAccount(String username , String password , String email)async{
    var url = Uri.parse('http://127.0.0.1:8000/CreateAccount/');
    Map data = {
      'username' : username ,
      'password' : password ,
      'email' : email 
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    print(tmp);
    print(response.statusCode.toString());
    return tmp ;
  }

  static Future<Map> login(String username , String password)async{
    var url = Uri.parse('http://127.0.0.1:8000/login/');
    Map data = {
      'username' : username ,
      'password' : password ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    print("heeeey");
    print(tmp);
    print(response.statusCode.toString());
    return tmp ;
  }

  static Future<Map> profile(int pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/Profile/');
    Map data = {
      'personID' : pk 
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);

    return tmp;
  }

  static Future<Map> changeProfile(int? pk , String? username , DateTime? birthday , String? email , String? phoneNumber , String? about)async{
    var url = Uri.parse('http://127.0.0.1:8000/ChangeProfile/');
    Map data = {
      'pk' : pk ,
      "username" : username ,
      "email" : email ,
      "birthday" : birthday,
      "phoneNumber" : phoneNumber ,
      "about" : about ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    print("response in front");
    print(tmp);

    return tmp;
  }


  static Future<List> addTaskDailyCalendar(int pk, String taskName,String? startTime, String? endTime, String? date)async{
    var url = Uri.parse('http://127.0.0.1:8000/AddTaskDailyCalendar/');
    Map data = {
      'name' : taskName ,
      'pk': pk ,
      'startTime': startTime,
      'endTime': endTime,
      'date': date
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    List tmp = jsonDecode(response.body);
    // print("response in front");
    // print(tmp);

    return tmp;
  }

  static Future<List> dailyCalendar(int pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/DailyCalendar/');
    Map data = {
      'pk': pk ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    List tmp = jsonDecode(response.body);
    return tmp;

  }

  static Future<Map> addNewBoard(int pk , String boardName , List members , List holdings , String description)async{
    var url = Uri.parse('http://127.0.0.1:8000/CreateBoard/');
    Map data = {
      'pk': pk ,
      "members" : members ,
      "boardName": boardName ,
      "holdings" : holdings ,
      "description" : description ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }

  static Future<List> allBoards(int pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/allBoards/');
    Map data = {
      'pk': pk ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    List tmp = jsonDecode(response.body);
    return tmp;

  }

  static Future<Map> singleBoard(int? pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/singleBoard/');
    Map data = {
      'pk': pk ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }

  static Future<Map> addNewList(int? pk , String listName , String description)async{
    var url = Uri.parse('http://127.0.0.1:8000/newList/');
    Map data = {
      'pk': pk ,
      'listName' : listName,
      'description' : description
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }

  static Future<Map> addNewTask( int? personPk,int pk , String taskName , String description , String date , String startTime , String endTime , List members)async{
    var url = Uri.parse('http://127.0.0.1:8000/addNewTask/');
    Map data = {
      'personPk' : personPk ,
      'pk': pk ,
      'taskName' : taskName,
      'description' : description,
      'date' :date ,
      "startTime" : startTime ,
      "endTime" : endTime ,
      "members" :members
    };
    print("personpk is:");
    print(personPk);

    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }

  static Future<Map> listData(int pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/listData/');
    Map data = {
      'pk': pk ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }

  static Future<List> weeklyCalendar(int pk)async{
    var url = Uri.parse('http://127.0.0.1:8000/weeklyCalendar/');
    Map data = {
      'pk': pk ,
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    List tmp = jsonDecode(response.body);
    return tmp;

  }

  static Future<Map> changePassword(int pk , String oldPass , String newPass)async{
    var url = Uri.parse('http://127.0.0.1:8000/changePassword/');
    Map data = {
      'pk': pk ,
      'oldPassword':oldPass ,
      'newPassword': newPass
    };
    var body = json.encode(data);
    var response = await http.post(url , headers: {"Content-Type": "application/json"} ,body: body);
    Map tmp = jsonDecode(response.body);
    return tmp;
  }
}