import 'package:flutter/material.dart';
import 'package:study_sphere/adbmstest_2.dart';

class ADBMSTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomePage(),
      backgroundColor: const Color.fromARGB(255, 12, 17, 27), // Set background color for the entire screen
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center all children
            children: [
              const SizedBox(height: 50), // Space for the back button

              // Welcome Text
              const Text(
                'Welcome to the world of testing.',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6), // Reduced space
              const Text(
                'Put your knowledge to the test with our incredible tests.',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                'Advance Database Management System',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Units List
              Expanded(
                child: ListView(
                  children: [
                    _buildUnitCard(
                      context,
                      'Assets/Images/test_pg2_adbms1.png',
                      'Total Questions: 126',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ADBMSTest_second()),
                        );
                      },
                    ),
                    _buildUnitCard(
                      context,
                      'Assets/Images/test_pg2_adbms2.png',
                      'Total Questions: 116',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ADBMSTest_second()),
                        );
                      },
                    ),
                    _buildUnitCard(
                      context,
                      'Assets/Images/test_pg2_adbms3.png',
                      'Total Questions: 107',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ADBMSTest_second()),
                        );
                      },
                    ),
                    _buildUnitCard(
                      context,
                      'Assets/Images/test_pg2_adbms4.png',
                      'Total Questions: 106',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ADBMSTest_second()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Back Button Image
        Positioned(
          top: -12, // Adjust top position as needed
          left: -18, // Adjust right position as needed
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Go back to the previous screen
            },
            child: Image.asset(
              'Assets/Images/Back_button.png', // Path to your back button image
              height: 100, // Adjust height as needed
              width: 100, // Adjust width as needed
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnitCard(BuildContext context, String imagePath, String totalQuestionsText, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 12, 17, 27), // Card background color
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // Image
            Image.asset(
              imagePath, // Use the provided image path
              fit: BoxFit.cover, // Adjust as needed
              width: double.infinity, // Full width
              height: 60, // Adjust height as needed
            ),
            // Total Questions aligned to the right
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 6.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalQuestionsText, // Use the passed text
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the ADBMSTest_2 class here
class ADBMSTest_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADBMSTest 2')),
      body: Center(child: const Text('Welcome to ADBMSTest 2')),
    );
  }
}
