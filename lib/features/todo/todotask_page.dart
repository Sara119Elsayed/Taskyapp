import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/component/task_list_widget.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';

class ToDoTaskPage extends StatefulWidget {
  const ToDoTaskPage({super.key});

  @override
  State<ToDoTaskPage> createState() => _ToDoTaskPageState();
}

class _ToDoTaskPageState extends State<ToDoTaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'To Do Tasks',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Consumer<TasksController>(
                  builder: (context, tasksController, child) {
                    return tasksController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              value: 20,
                            ),
                          )
                        : TaskListWidget(
                            tasks: tasksController.todoTasks,
                            onTap: (value, id) {
                              tasksController.changeTaskStatus(
                                  id!, value ?? false);
                            },
                            emptyMessage: 'No Task Found',
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}