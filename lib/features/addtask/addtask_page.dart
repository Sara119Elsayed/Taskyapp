import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskyapp/component/custom_textfiled.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'New Task',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  CustomTextFiled(
                    textData: 'Task Name',
                    hintTextData: 'Finish UI design for login screen',
                    maxLines: 1,
                    controller: taskNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFiled(
                    textData: 'Task Description',
                    hintTextData:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    maxLines: 5,
                    controller: taskDescriptionController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'High Priority  ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Switch(
                          value: isHighPriority,
                          onChanged: (bool newValue) {
                            setState(() {
                              isHighPriority = newValue;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 90),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    icon: const Icon(Icons.add, size: 24),
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        TaskModel newTask = TaskModel(
                          name: taskNameController.text,
                          description: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                        );
            
                        await Provider.of<TasksController>(context, listen: false)
                            .addTask(
                                newTask); // Assuming you have an addTask method
                        taskNameController.clear();
                        taskDescriptionController.clear();
                        // if pop before add task, don't pop gain using Navigator.pop(context)
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    label: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}