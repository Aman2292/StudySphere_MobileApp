import 'package:flutter/material.dart';
import 'package:study_sphere/adbmstest.dart';
import 'package:study_sphere/adbmstest_2.dart';
import 'package:study_sphere/hex_code_page.dart';
import 'package:study_sphere/home_page.dart';
import 'package:study_sphere/login_signin_page.dart';
import 'package:study_sphere/notes_page.dart';
import 'package:study_sphere/quiz_section.dart';
import 'package:study_sphere/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      initialRoute: '/login', // Set the initial route to your home or login page
      routes: {
        '/': (context) =>  LoginPage(), // Home or login page
        '/quiz_page': (context) => QuizPage(), // Your QuizPage
        '/quiz_2': (context) => ADBMSTest_second(), // Second quiz page
        '/quiz': (context) => ADBMSTest(), // Another quiz page
        '/login': (context) => const LoginSigninPage(), // Login page route
        '/notes': (context) => const NotesPage(), // Notes page route
        '/hex_code_page': (context) => CharacterCodePage(), // Hex code page
      },
    );
  }
}
