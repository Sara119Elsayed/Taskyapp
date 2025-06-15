import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/features/home/home_page.dart';
import 'package:taskyapp/features/welcome/welcome_page.dart';
import 'package:taskyapp/screens/bottom_navigation.dart';
import 'package:taskyapp/services/controller/profile_controller.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

import 'core/constants/storage_key.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/theme_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefrencesetManagerService().init();
  ThemeController().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksController()..init()),
        ChangeNotifierProvider(
            create: (_) => ProfileController()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home:PrefrencesetManagerService().getString(StorageKey.username) == null? WelcomePage(): BottomNavigation(),
        );
      },
    );
  }
}