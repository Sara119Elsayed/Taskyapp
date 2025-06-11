import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/component/task_list_widget.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';


class HighPriorityTasksScreen extends StatelessWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'High Priority Tasks',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Consumer<TasksController>(
                  builder: (context, tasksController, child) {
                    return tasksController!.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              value: 20,
                            ),
                          )
                        : TaskListWidget(
                            tasks: tasksController!.tasks
                                .where((task) => task.isHighPriority)
                                .toList(),
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