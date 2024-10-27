import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle

// GlassmorphicBackground widget for the glass effect
class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  final Color color;

  GlassmorphicBackground({required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
          ),
          child: child,
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0; // Start from the first question
  List<Map<String, dynamic>> _questions = [];
  int? _selectedOption;
  bool _showExplanation = false;
  List<int?> _userAnswers = []; // Store selected answers for each question
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  int _remainingTime = 10; // 10 seconds for each question
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    final String response = await rootBundle.loadString('Assets/Json/ADBMS.json');
    final data = json.decode(response);

    setState(() {
      _questions = List<Map<String, dynamic>>.from(data['questions']);
      _userAnswers = List<int?>.filled(_questions.length, null); // Initialize user answers
      _startTimer();
    });
  }

  void _startTimer() {
    _remainingTime = 10; // Reset timer to 10 seconds
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel(); // Stop the timer when it reaches 0
          _nextQuestion(); // Automatically go to the next question
        }
      });
    });
  }

  void _checkAnswer(int index) {
    setState(() {
      _selectedOption = index;
      _userAnswers[_currentQuestion] = index; // Store the selected answer

      // Check if the answer is correct
      if (_questions[_currentQuestion]['Correct Answer'] == index) {
        _correctAnswers++;
      } else {
        _incorrectAnswers++;
      }

      _showExplanation = true; // Show explanation after selecting an answer
    });

    // Automatically proceed to the next question after a short delay
    Future.delayed(const Duration(seconds: 3), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
        _selectedOption = _userAnswers[_currentQuestion]; // Restore the previous answer
        _showExplanation = _userAnswers[_currentQuestion] != null; // Show explanation if an answer was previously selected
        _startTimer(); // Restart the timer for the next question
      } else {
        _showResults(); // Show results if it's the last question
      }
    });
  }

  void _showResults() {
    _timer?.cancel(); // Stop the timer when showing results
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Results'),
          content: Text(
            'Correct Answers: $_correctAnswers\n'
                'Incorrect Answers: $_incorrectAnswers\n'
                'Unanswered: ${_questions.length - _correctAnswers - _incorrectAnswers}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Reset the quiz if needed
                setState(() {
                  _currentQuestion = 0;
                  _correctAnswers = 0;
                  _incorrectAnswers = 0;
                  _userAnswers = List<int?>.filled(_questions.length, null);
                  _selectedOption = null;
                  _showExplanation = false;
                });
                Navigator.of(context).pushReplacementNamed('/ADBMSTest_2'); // Navigate to the next page
              },
              child: const Text('Done'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Color _getOptionColor(int index) {
    if (_userAnswers[_currentQuestion] == index) {
      // Check if the selected option is correct
      return _questions[_currentQuestion]['Correct Answer'] == index
          ? Colors.green
          : Colors.red;
    }
    return Colors.transparent; // Default color
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 27), // Set background color
      body: Stack(
        children: [
          SingleChildScrollView( // Wrap the content in a SingleChildScrollView
            padding: const EdgeInsets.only(top: 80, bottom: 80), // Add padding to avoid overlap with the exit button
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Time left: $_remainingTime secs', // Display remaining time
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width * (_currentQuestion / (_questions.length > 0 ? _questions.length : 1))),
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 1),
                      Image.asset(
                        'Assets/Images/Quiz_timer.png',
                        width: 70,
                        height: 50,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Questions: ${_currentQuestion + 1} - ${_questions.length}",
                    style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Topic: Fundamentals of PL/SQL - Unit: 1.1",
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GlassmorphicBackground(
                    color: const Color.fromARGB(218, 153, 153, 154),
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _questions.isNotEmpty ? _questions[_currentQuestion]['Question'] : "Loading...",
                            style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GlassmorphicBackground(
                    color: const Color.fromARGB(218, 153, 153, 154),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(
                          _questions.isNotEmpty ? _questions[_currentQuestion]['Answer Options'].length : 0,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (!_showExplanation) {
                                    _checkAnswer(index);
                                  }
                                },
                                child: GlassmorphicBackground(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: _getOptionColor(index), // Set color based on correctness
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'Assets/Images/Option_${String.fromCharCode(65 + index)}.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            _questions.isNotEmpty ? _questions[_currentQuestion]['Answer Options'][index] : "Loading...",
                                            style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_showExplanation) // Show explanation if selected
                    GlassmorphicBackground(
                      color: const Color.fromARGB(218, 153, 153, 154),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Explanation:",
                              style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _questions[_currentQuestion]['Overall Explanation'],
                              style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentQuestion > 0
                          ? GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_currentQuestion > 0) {
                              _currentQuestion--;
                              _selectedOption = _userAnswers[_currentQuestion]; // Restore the previous answer
                              _showExplanation = _userAnswers[_currentQuestion] != null; // Show explanation if an answer was previously selected
                              _startTimer(); // Restart the timer for the previous question
                            }
                          });
                        },
                        child: Image.asset(
                          'Assets/Images/Quiz_back.png',
                          width: 80,
                          height: 80,
                        ),
                      )
                          : const SizedBox.shrink(),
                      GestureDetector(
                        onTap: () {
                          if (_userAnswers[_currentQuestion] != null) { // Check if an answer is selected
                            _nextQuestion();
                          } else {
                            // Optionally show a message to select an answer
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select an answer before proceeding.')),
                            );
                          }
                        },
                        child: Image.asset(
                          'Assets/Images/Quiz_next.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10, // Position the exit button at the top left corner
            left: 10,
            child: GestureDetector(
              onTap: () {
                _showExitConfirmation();
              },
              child: Column(
                children: [
                  Image.asset(
                    'Assets/Images/Quiz_exit.png',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'Exit',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
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

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Quiz'),
          content: const Text('Are you sure you want to exit the quiz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushReplacementNamed('/quiz_2'); // Navigate to ADBMSTest_2
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}
