import 'package:flutter/material.dart';
import 'package:taskyapp/models/task_model.dart';
import 'task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SingleChildScrollView(
          child: Center(
              child: Text(
                emptyMessage ?? 'No Data',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
        )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom: 60),
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, tasks[index].id);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}