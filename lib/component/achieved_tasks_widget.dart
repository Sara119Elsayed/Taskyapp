import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';

import '../../../core/theme/theme_controller.dart';

class AnalysisAchievedTasks extends StatefulWidget {
  const AnalysisAchievedTasks({super.key});

  @override
  State<AnalysisAchievedTasks> createState() => _AnalysisAchievedTasksState();
}

class _AnalysisAchievedTasksState extends State<AnalysisAchievedTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : const Color(0xFFD1DAD6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Achieved Tasks',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 4),
                Consumer<TasksController>(
                  builder: (context, tasksController, child) {
                    return Text(
                      '${tasksController.totalDoneTasks} out of ${tasksController.tasks.length} Done',
                      style: Theme.of(context).textTheme.displaySmall,
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: -0.5,
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: CircularProgressIndicator(
                      value: context.watch<TasksController>().percent,
                      backgroundColor: const Color(0xFF6D6D6D),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF15B86C)),
                      strokeWidth: 4,
                    ),
                  ),
                ),
                Text(
                  "${(context.watch<TasksController>().percent * 100).toStringAsFixed(0)}%",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}