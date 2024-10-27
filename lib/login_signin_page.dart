import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:study_sphere/login_signin_page.dart';
import 'package:study_sphere/signin.dart';
import 'signup.dart';

void main() {
  runApp( WelcomeScreen());
}

class LoginSigninPage extends StatelessWidget {
  const LoginSigninPage({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 27),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Study Sphere',
                style: TextStyle(
                  fontSize: 36,
                  color: Color.fromARGB(255, 232, 148, 46),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'Assets/Images/login_combine.png',
                    width: screenWidth,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  // Confetti background with blur effect
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 10.0),
                        child: Container(
                          color: const Color.fromARGB(126, 22, 28, 40).withOpacity(0.6),
                          child: Image.asset(
                            'Assets/Images/background_login.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Glassmorphism effect for the text and buttons
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(250, 69, 70, 74).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(25, 106, 107, 110).withOpacity(0.2),
                            blurRadius: 0.1,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Hello!\nStudents',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 250, 172, 77),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Let us commence a remarkable journey towards achieving your utmost potential.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => LoginPage()),);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 232, 148, 46),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 253, 227, 194),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),

                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}