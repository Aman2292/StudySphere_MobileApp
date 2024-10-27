import 'package:flutter/material.dart';
import 'package:study_sphere/DatabaseHelper.dart';
import 'package:study_sphere/hex_code_page.dart';
import 'package:study_sphere/signin.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _rememberMe = false;

  void _register() async {
    String name = _nameController.text.trim();
    String className = _classController.text.trim();
    int rollNo = int.tryParse(_rollNoController.text.trim()) ?? 0;
    String division = _divisionController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Basic validation
    if (name.isEmpty || className.isEmpty || rollNo == 0 || division.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid email address')));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be at least 6 characters long')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // Insert into database
    await DatabaseHelper().insertStudent(name, email, className, rollNo, division, password);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful')));

    // Navigate to CharacterCodePage after successful registration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CharacterCodePage()), // Navigate to CharacterCodePage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 12, 17, 27),
      body: Stack(
        children: [
          // Signup image positioned within a stack
          Positioned(
            top: 10,
            left: 30,
            child: Image.asset(
              'Assets/Images/signup_combine.png',
              height: 350,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          // Back button positioned within a stack
          Positioned(
            top: 2,
            left: -27,
            child: IconButton(
              icon: Image.asset(
                'Assets/Images/Back_button.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Form section with glassmorphism effect, including "Register" text
          Positioned(
            top: 290,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(13.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(250, 69, 70, 74).withOpacity(0.5), // Glassmorphism effect
              ),
              child: Column(
                children: [
                  // "Register" text inside the glassmorphism container
                  Text(
                    'Register',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 232, 148, 46),
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Name and Class fields
                  Row(
                    children: [
                      Expanded(
                        child: customGlassTextField(
                          controller: _nameController,
                          hintText: 'eg. Rahul',
                          label: 'Name',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: customGlassTextField(
                          controller: _classController,
                          hintText: 'eg. TYCS',
                          label: 'Class',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Roll No and Division fields
                  Row(
                    children: [
                      Expanded(
                        child: customGlassTextField(
                          controller: _rollNoController,
                          hintText: 'eg. 6008',
                          label: 'Roll No',
                          isNumber: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: customGlassTextField(
                          controller: _divisionController,
                          hintText: 'eg. C',
                          label: 'Division',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  customGlassTextField(
                    controller: _emailController,
                    hintText: 'example22cs@student.mes.ac.in',
                    label: 'Email',
                  ),
                  const SizedBox(height: 16),

                  // Password and Confirm Password fields
                  customGlassTextField(
                    controller: _passwordController,
                    hintText: 'Password...',
                    label: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  customGlassTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password...',
                    label: 'Confirm password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),

                  // Remember me checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            _rememberMe = newValue ?? false;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 232, 148, 46),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          color: Color.fromARGB(255, 232, 148, 46),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),

                  // Submit button and Sign In text with single glassmorphism effect
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 232, 148, 46), // Button color
                            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 12, 17, 27),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // Redirect to sign in page
                            Navigator.pushNamed(context, '/signing');
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 198, 203, 210), fontFamily: 'Poppins'),
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFFe09145),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
          ),
        ],
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
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(
        color: Color.fromARGB(255, 232, 148, 46),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 198, 203, 210)),
        labelStyle: const TextStyle(color: Colors.white),
        suffixIcon: icon != null
            ? Icon(
          icon,
          color: Colors.black,
          size: 30.0, // Adjust size as needed
        )
            : null,
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
}
