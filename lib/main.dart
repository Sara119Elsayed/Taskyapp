import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:taskyapp/screens/home_page.dart';
// import 'package:taskyapp/screens/welcome_page.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? username = prefs.getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {

   MyApp({super.key, this.username});
 
   String? username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF181818),
           switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF15B86C);
            }
            return Colors.white;
          }),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Color(0xFF9E9E9E);
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.transparent;
            }
            return Color(0xFF9E9E9E);
          }),
          trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return 0;
            }
            return 2;
          }),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF15B86C),
            foregroundColor: Color(0xFFFFFCFC),
            fixedSize: Size(MediaQuery.of(context).size.width, 40),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        textTheme: TextTheme(
          displaySmall: TextStyle(
            fontSize: 24,
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w400,
          ),
          displayLarge: TextStyle(
            fontSize: 32,
            color: Color(0xFFFFFCFC),
            fontWeight: FontWeight.w400,
          ),
          titleSmall: TextStyle(
            color: Color(0xFFC6C6C6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            color: Color(0xFFFFFCFC),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          // For Done Task
          titleLarge: TextStyle(
            color: Color(0xFFA0A0A0),
            fontSize: 16,
            decoration: TextDecoration.lineThrough,
            decorationColor: Color(0xFFA0A0A0),
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFCFC),
            fontSize: 20,
          ),
          labelMedium: TextStyle(color: Colors.white, fontSize: 16),
          labelLarge: TextStyle(color: Colors.white, fontSize: 24),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
          fillColor: Color(0xFF282828),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF181818),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Color(0xFFC6C6C6),
          selectedItemColor: Color(0xFF15B86C),
        )
     ),
     home:Scaffold()// username == null ? WelcomePage():HomePage(),
     );
  }
}


