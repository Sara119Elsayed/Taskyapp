import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

class TasksController with ChangeNotifier {

  String? username;
  String? userImage;
  List<TaskModel> tasks = [];
  int totalTasks  = 0 ; 
  int totalDoneTasks  = 0 ;
  double percent =  0;
  bool isLoading = false;
  List<TaskModel> doneTasks =[];


  initalFun()
  {
       loadUserData();
       loadTasks();
  }


  void loadUserData() async
  {

    username = PrefrencesetManagerService().getString("username");

    userImage = PrefrencesetManagerService().getString("userimage");
      
    notifyListeners();
  }



  void loadTasks() async
  {

    isLoading = true;
     
    final alltasks = PrefrencesetManagerService().getString("tasks");
    
    if(alltasks != null)
    {
        final tasksDecode = jsonDecode(alltasks) as List<dynamic>;


        tasks = tasksDecode.map((element)=>
        TaskModel.fromJson(element)).toList();
    }

        isLoading = false;
        notifyListeners();

  }



  void calculatePercent() 
  {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }


  void AddTask(int Id ,TextEditingController tasknameController,TextEditingController taskdescraptionController,bool isHighPriorityVal) async
  {
     final String? list =  PrefrencesetManagerService().getString('tasks');

      List<dynamic> listTasks = [];

      if (list != null) 
      {
        listTasks = jsonDecode(list);
      }

      TaskModel taskModel = TaskModel(
        id: listTasks.length + 1,
        taskName: tasknameController.text,
        taskDescription: taskdescraptionController.text,
        isHighPriority: isHighPriorityVal,
      );

        listTasks.add(taskModel.toJson());

      String value = jsonEncode(listTasks);

      await PrefrencesetManagerService().setString('tasks', value);

  }


 void doneTasksFun(bool? val , int? index) async
  {
     if(index != null)
     { 
    
        tasks[index].isDone = val ?? false;

        calculatePercent();

        final updatesTask = tasks.map((element)=>element.toJson()).toList();
        PrefrencesetManagerService().setString("tasks",jsonEncode(updatesTask)); 
        notifyListeners();    
     }
   
  }



  void deleteTask(int? index) async
  {

      if(index != null)
      {
         tasks.removeAt(index);

        calculatePercent();

        final updatedTask = tasks.map((element) => element.toJson()).toList();
        
        PrefrencesetManagerService().setString("tasks", jsonEncode(updatedTask));

        notifyListeners();
      }


  }

















}
