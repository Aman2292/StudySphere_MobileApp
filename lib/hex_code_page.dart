import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:study_sphere/home_page.dart';
 // Use alias
import 'package:study_sphere/DatabaseHelper.dart';
import 'package:study_sphere/notes_page.dart';
import 'package:study_sphere/quiz_section.dart'; // Import your DatabaseHelper

class CharacterCodePage extends StatefulWidget {
  @override
  _CharacterCodePageState createState() => _CharacterCodePageState();
}

class _CharacterCodePageState extends State<CharacterCodePage> {
  final TextEditingController _codeController = TextEditingController();
  bool hasCopied = false; // Variable to track if the user has clicked "Copy"

  @override
  void initState() {
    super.initState();
    _generateAndStoreCode(); // Generate and store the code when the page initializes
  }

  // Generate a random 16-character code
  String _generateRandomCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';
    Random random = Random();
    return List.generate(16, (index) => characters[random.nextInt(characters.length)]).join();
  }

  // Generate and store the code in the database
  Future<void> _generateAndStoreCode() async {
    String generatedCode = _generateRandomCode();
    _codeController.text = generatedCode; // Set the generated code to the TextField

    // Save the code in the database (you may want to adjust this method in your DatabaseHelper)
    await DatabaseHelper().insertStudent("User Name", "user@example.com", "Class", 1, "Division", generatedCode);
  }

  // Prevent user from navigating back before copying the code
  Future<bool> _onWillPop() async {
    if (!hasCopied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please copy the code before going back.")),
      );
      return false; // Prevent navigation
    }
    return true; // Allow navigation if code is copied
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Intercept back button
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 12, 17, 27),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Stack(
            children: [
              Positioned(
                top: -25, // Adjust top position
                left: -19, // Adjust left position
                child: GestureDetector(
                  onTap: () {
                    if (hasCopied) {
                      Navigator.pop(context); // Allow back only if code is copied
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please copy the code before going back.")),
                      );
                    }
                  },
                  child: Image.asset(
                    'Assets/Images/Back_button.png',
                    height: 100, // Adjusted height
                    width: 100, // Adjusted width
                    fit: BoxFit.cover, // Ensure it scales properly
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Your 16 digit Character Code",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: Color.fromARGB(255, 232, 148, 46),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              const Text(
                "Please ensure to securely store this information. "
                    "It may serve as a backup login option in case you forget both your email and password.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 25),

              // TextField for displaying the code
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 80),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(225, 106, 107, 110).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  controller: _codeController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _codeController.text)); // Copy the text to the clipboard
                  setState(() {
                    hasCopied = true; // Set hasCopied to true when the user clicks "Copy"
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Code copied to clipboard!")),
                  );
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(225, 106, 107, 110).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Copy",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 232, 148, 46),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 140),

              // Image in the center
              Container(
                height: 170,
                width: 300,
                child: Image.asset(
                  'Assets/Images/16dig_char_icon.png',
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(),

              // "Done" button to navigate to QuizPage
              GestureDetector(
                onTap: () {
                  if (hasCopied) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentDashboardPage()), // Navigate to QuizPage
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please copy the code before proceeding.")),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 148, 46),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
