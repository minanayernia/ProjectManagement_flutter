
import 'package:flutter/material.dart';

class ListCard{
  ListCard(this.name , this.description , this.tasks);

  String name ;
  String? description ;
  List<TaskCard>? tasks ;
}

class TaskCard{
  TaskCard(this.taskName , this.taskDescription , this.members , this.deadLine);

  String taskName ;
  String? taskDescription ;
  List? members;
  DateTime? deadLine ;
}