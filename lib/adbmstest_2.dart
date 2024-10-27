import 'package:flutter/material.dart';
import 'quiz_section.dart'; // Ensure you import your QuizSection here

class ADBMSTest_second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(color: const Color.fromARGB(255, 12, 17, 27)),
          // Positioned back button
          Positioned(
            top: -12, // Adjust top position as needed
            left: -18, // Adjusted left position
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Image.asset(
                'Assets/Images/Back_button.png', // Path to your back button image
                height: 100, // Adjust height
                width: 100, // Adjust width
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
              children: [
                const SizedBox(height: 50), // Increased height to move title down
                // Title text
                const Text(
                  'Advance DataBase\nManagement System',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins', // Use local Poppins font
                    fontSize: 26,
                    color: Color.fromARGB(255, 232, 148, 46), // Orange color
                    fontWeight: FontWeight.bold, // Bold style
                  ),
                ),
                const SizedBox(height: 20), // Space between title and subtitle
                // Subtitle text
                const Text(
                  'Select one of the sub-chapters to start the quiz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Encouragement text
                const Text(
                  'I wish you the best of luck on your test; may it serve to enhance your knowledge and understanding!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.blue, // Blue encouragement text
                  ),
                ),
                const SizedBox(height: 10),
                // Wrap GridView in SingleChildScrollView
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      shrinkWrap: true, // Important to prevent overflow
                      physics: const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10, // Space between columns
                      mainAxisSpacing: 10,  // Space between rows
                      childAspectRatio: 1.5, // Aspect ratio for buttons
                      children: [
                        _buildQuizOption(context, 'Unit 1.1', 20, isSpecial: false, isNavigable: true), // Add true for isNavigable
                        _buildQuizOption(context, 'Unit 1.2', 20),
                        _buildQuizOption(context, 'Unit 1.1 & 1.2', 20),
                        _buildQuizOption(context, 'Unit 1.2 & 1.3', 20),
                        _buildQuizOption(context, 'Unit 1.3', 20),
                        _buildQuizOption(context, 'Unit 1.3 ', 20),
                        _buildQuizOption(context, 'Unit 1.1 & 1.2', 20),
                        _buildQuizOption(context, 'Overall Unit - 1', 0, isSpecial: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizOption(BuildContext context, String title, int questionCount, {bool isSpecial = false, bool isNavigable = false}) {
    return GestureDetector(
      onTap: () {
        if (isNavigable && title == 'Unit 1.1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizPage()), // Navigate to QuizSection
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          color: isSpecial ? const Color.fromARGB(255, 232, 148, 46) : const Color.fromARGB(225, 186, 187, 180).withOpacity(0.2), // Special color for overall
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white, // White text
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isSpecial) const SizedBox(height: 8),
            if (!isSpecial)
              Text(
                '$questionCount Questions',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
