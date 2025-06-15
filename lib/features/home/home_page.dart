import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/component/achieved_tasks_widget.dart';
import 'package:taskyapp/component/high_priority_tasks_widget.dart';
import 'package:taskyapp/component/task_list_widget.dart';
import 'package:taskyapp/features/home/component/achieved_tasks_widget.dart';
import 'package:taskyapp/features/addtask/addtask_page.dart';
import 'package:taskyapp/services/controller/profile_controller.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Selector<ProfileController, String?>(
                  selector: (context, ProfileController controller) =>
                      controller.userImagePath,
                  builder: (BuildContext context, String? userImagePath,
                      Widget? child) {
                    return CircleAvatar(
                      backgroundImage: userImagePath == null
                          ? const AssetImage('assets/images/user.jpg')
                          : FileImage(File(userImagePath)),
                    );
                  },
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<ProfileController>(
                      builder: (context, userController, _) {
                        return Text(
                         '${Theme.of(context).brightness == Brightness.dark ? 'Good Evening' : 'Good Morning'}, ${userController.username}',
                          style: Theme.of(context).textTheme.displayMedium,
                        );
                      },
                    ),
                    Text('One task at a time.One step closer.',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
           
              Text(
                'Yuhuu ,Your work Is',
                style: Theme.of(context).textTheme.displayLarge,
              ),
           
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'almost done ! ',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(width: 8),
               SvgPicture.asset(
                  'assets/images/handimage.svg',
                  width: 32,
                  height: 32,
                ),

              ],
            ),
            const SizedBox(height: 16),
            const AnalysisAchievedTasks(),
            const SizedBox(height: 8),
            Consumer<TasksController>(
              builder: (context, tasksController, child) {
                return const HighPriorityTasksWidget();
              },
            ),
            const SizedBox(height: 16),
            Text(
              'My Tasks',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<TasksController>(
                  builder: (context, tasksController, child) {
                return tasksController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        value: 20,
                      ))
                    : TaskListWidget(
                        tasks: tasksController.tasks,
                        onTap: (value, id) {
                          tasksController.changeTaskStatus(id!, value ?? false);
                        },
                        emptyMessage: 'No Task Found',
                      );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTaskPage(),
                      ),
                    );
                  },
                  label: const Text('Add Task'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(160, 40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}