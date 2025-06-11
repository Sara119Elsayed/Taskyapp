import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/component/custom_textfiled.dart';
import 'package:taskyapp/core/enums/task_item_actions_enum.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/models/task_model.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
  });

  final TaskModel model;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : const Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          CustomCheckBox(
            value: model.isCompleted,
            onChanged: (bool? value) => onChanged(value),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: model.isCompleted
                      ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                            decoration: TextDecoration.lineThrough,
                          )
                      : Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                ),
                if (model.description.isNotEmpty)
                  Text(
                    model.description,
                    style: Theme.of(context).textTheme.displaySmall,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: SvgPicture.asset(
              'assets/images/dots-vertical.svg',
              width: 24,
              height: 24,
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                case TaskItemActionsEnum.edit:
                  await _showButtonSheet(context, model);
                case TaskItemActionsEnum.markAsDone:
                  // TODO: Handle this case.
                  throw UnimplementedError();
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionsEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text('Are you sure you want to delete this task '),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            Consumer<TasksController>(
              builder: (context, tasksController, child) {
                return TextButton(
                  onPressed: () {
                    tasksController.deleteTask(model.id);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Delete'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController =
        TextEditingController(text: model.name);
    TextEditingController taskDescriptionController =
        TextEditingController(text: model.description);
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    SizedBox(height: 20),
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
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          TaskModel newTask = TaskModel(
                            name: taskNameController.text,
                            description: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            id: model.id, // Ensure to pass the existing task ID
                          );

                          await Provider.of<TasksController>(context,
                                  listen: false)
                              .editTask(
                            newTask,
                          );
                          taskNameController.clear();
                          taskDescriptionController.clear();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      label: const Text('Edit Task'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}