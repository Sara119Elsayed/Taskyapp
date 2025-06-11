import 'package:flutter/material.dart';
import 'package:taskyapp/features/completetask/completetask_page.dart';
import 'package:taskyapp/features/home/home_page.dart';
import 'package:taskyapp/features/profile/profile_page.dart';
import 'package:taskyapp/features/todo/todotask_page.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  List<Widget> screens=[
    HomePage(),
    ToDoTaskPage(),
    CompleteTasksScreen(),
    ProfileScreen()
  ];

  int curindex = 0;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: curindex,

         onTap: (int? index) {
          setState(() {
            curindex = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/home.svg",0),  
            label: "Home",
          ),
           BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/todo.svg",1),  
            label: "To Do",
          ),
           BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/todo_complete.svg",2),  
            label: "Completed",
          ),
           BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/profile_icon.svg",3),  
            label: "Profile",
          )
        ],
      ),
     body: SafeArea(child: screens[curindex]),
    );
  }
   SvgPicture _buildSvgPicture(String path, int index) => SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(
          curindex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
          BlendMode.srcIn,
        ),
  );
}