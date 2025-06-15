import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskyapp/core/constants/storage_key.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';
import 'package:taskyapp/features/home/home_page.dart';
import 'package:taskyapp/features/profile/user_details_screen.dart';
import 'package:taskyapp/features/profile/widget/dialod_screen.dart';
import 'package:taskyapp/features/welcome/welcome_page.dart';
import 'package:taskyapp/services/controller/profile_controller.dart';
import 'package:taskyapp/services/controller/tasks_controller.dart';
import 'package:taskyapp/services/prefrencesetmanager_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
  
    final profileController = Provider.of<ProfileController>(context);
    final userImage = profileController.userImagePath;
    final username = profileController.username ?? 'Sara';
    final motivationQuote = profileController.motivationQuote.isEmpty
        ? 'One task at a time. One step closer.'
        : profileController.motivationQuote;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'My Profile',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 18),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: (userImage == null || userImage.isEmpty)
                          ? const AssetImage('assets/images/user.jpg')
                              as ImageProvider
                          : FileImage(File(userImage)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showImageSourceDialog(context, (XFile file) {
                          profileController.saveUserImage(file);
                          setState(() {}); // Refresh UI after image change
                        });
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: ThemeController.isDark()
                            ? const Color(0xFF282828)
                            : Colors.white,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Text(
                      username,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      motivationQuote,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Profile Info',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 24),
              ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserDetailsScreen(
                        userName: username,
                        motivationQuote: motivationQuote,
                      ),
                    ),
                  );
                  setState(() {}); 
                },
                contentPadding: EdgeInsets.zero,
                title: const Text('User Details'),
                leading: const Icon(Icons.person_outline, size: 32),
                trailing: const Icon(Icons.arrow_forward_ios, size: 24),
              ),
              const Divider(thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark Mode'),
                leading: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (_, mode, __) {
                    return ThemeController.isDark()
                        ? SvgPicture.asset('assets/images/moon.svg', width: 32, height: 32)
                        : SvgPicture.asset('assets/images/Light.svg', width: 32, height: 32);
                  },
                ),
                trailing: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (_, mode, __) {
                    return Switch(
                      value: ThemeController.isDark(),
                      onChanged: (_) => ThemeController.toggleTheme(),
                    );
                  },
                ),
              ),
              const Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await profileController.clearUserData();
                  await Provider.of<TasksController>(context, listen: false).clearTasks();
                  ThemeController.themeNotifier.value = ThemeMode.dark;
                  await PrefrencesetManagerService().setBool(StorageKey.theme, true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => WelcomePage()),
                  );
                },
                contentPadding: EdgeInsets.zero,
                title: const Text('Log Out'),
                leading: const Icon(Icons.logout, size: 32),
                trailing: const Icon(Icons.arrow_forward_ios, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
