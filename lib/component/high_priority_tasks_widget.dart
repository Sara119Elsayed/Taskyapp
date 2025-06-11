import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/core/widgets/custom_check_box.dart';
import 'package:taskyapp/screens/high_proritiy_screen.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';

import '../../../core/theme/theme_controller.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
        final tasksList = controller.tasks;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ThemeController.isDark()
                  ? Colors.transparent
                  : const Color(0xFFD1DAD6),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'High Priority Tasks',
                      style: TextStyle(
                        color: Color(0xFF15B86C),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...controller.tasks.reversed
                        .where((e) => e.isHighPriority)
                        .take(4)
                        .map((task) => Row(
                              children: [
                                CustomCheckBox(
                                  value: task.isCompleted,
                                  onChanged: (bool? value) {
                                    controller.changeTaskStatus(
                                        task.id, value ?? false);
                                  },
                                ),
                                Flexible(
                                  child: Text(
                                    task.name,
                                    style: task.isCompleted
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const HighPriorityTasksScreen();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  width: 48,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ThemeController.isDark()
                          ? const Color(0xFF6E6E6E)
                          : const Color(0xFFD1DAD6),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/arrow-up-right.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}