import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:study_sphere/DatabaseHelper.dart';
import 'package:study_sphere/home_page.dart'; // Import the StudentDashboardPage

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 27),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  // Main Image
                  Center(
                    child: Image.asset(
                      'Assets/Images/signin_combine.png',
                      width: 390,
                      height: 290,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 1),

                  // Glassmorphic login box
                  GlassmorphicEffect(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Login Text
                          const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 232, 148, 46),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Email Field
                          customGlassTextField(
                            controller: _emailController,
                            hintText: 'Your email id...',
                            label: 'Email',
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          customGlassTextField(
                            controller: _passwordController,
                            hintText: 'Password...',
                            label: 'Password',
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // Handle forgot password action
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 232, 148, 46),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Submit Button
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                String email = _emailController.text.trim();
                                String password = _passwordController.text.trim();

                                // Check user credentials
                                bool isValidUser = await DatabaseHelper().checkUser(email, password);

                                if (isValidUser) {
                                  // Navigate to StudentDashboardPage
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => StudentDashboardPage()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Invalid email or password')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 232, 148, 46), // Background color
                                foregroundColor: const Color.fromARGB(255, 12, 17, 27), // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 13), // Padding
                                elevation: 5, // Shadow effect
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18, // Adjust font size as needed
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // OR section
                          orSection(),

                          const SizedBox(height: 20),

                          // Google Glassmorphic Effect with tap effect
                          GestureDetector(
                            onTap: () {
                              // Handle Google logo button tap
                            },
                            child: GlassmorphicEffect(
                              child: Center(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 60), // Adjust padding as needed
                                  leading: Image.asset(
                                    'Assets/Images/google_logo.png',
                                    height: 44,
                                    width: 44,
                                    fit: BoxFit.cover,
                                  ),
                                  title: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16, // Set the same font size for all parts
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Only ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: 'mes',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 232, 148, 46), // Color for "mes"
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' account',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Character logo with Glassmorphic Effect with tap effect
                          GestureDetector(
                            onTap: () {
                              // Handle Character logo button tap
                            },
                            child: GlassmorphicEffect(
                              child: Center(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 50), // Remove default padding
                                  leading: Image.asset(
                                    'Assets/Images/character_logo.png',
                                    height: 54,
                                    width: 44,
                                    fit: BoxFit.cover,
                                  ),
                                  title: const Text(
                                    'Your 16 Digit Character',
                                    style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Back button
              Positioned(
                top: 10,
                left: -20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    'Assets/Images/Back_button.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom glassmorphism text field widget
  Widget customGlassTextField({
    required String hintText,
    required String label,
    required TextEditingController controller,
    IconData? icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
        color: Color.fromARGB(255, 232, 148, 46),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 198, 203, 210)),
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(25, 106, 107, 110).withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
        ),
      ),
    );
  }

  // OR section with dotted lines and image
  Widget orSection() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 12, 17, 27),
            thickness: 3,
            indent: 10,
            endIndent: 10,
          ),
        ),
        Image.asset(
          'Assets/Images/or_logo.png',
          height: 54,
          width: 54,
          fit: BoxFit.cover,
        ),
        const Expanded(
          child: Divider(
            color: Color.fromARGB(255, 12, 17, 27),
            thickness: 3,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}

// Glassmorphic Effect Widget
class GlassmorphicEffect extends StatelessWidget {
  final Widget child;
  GlassmorphicEffect({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(218, 153, 153, 154).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(218, 153, 153, 154).withOpacity(0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
