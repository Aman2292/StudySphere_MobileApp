import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:study_sphere/home_page.dart';
import 'adbmstest.dart'; // Make sure to import your ADBMSTest class

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  int currentIndex = 1; // Track the current index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 27), // Dark background color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 17, 27),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('Assets/Images/Avatar.png'), // Profile image
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User1_C 6008',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
            ),
            Text(
              'Student',
              style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Poppins'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset('Assets/Images/Search_icon.png', width: 70, height: 90, fit: BoxFit.cover),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('Assets/Images/Notification_icon.png', width: 35, height: 35, fit: BoxFit.cover),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Here are notes for you.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
            const SizedBox(height: 10),
            GlassmorphicBackground(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                  children: [
                    subjectCard(context, 'Java Framework', 'Assets/Images/JavaFramework.png'),
                    subjectCard(context, 'Hybrid Programming', 'Assets/Images/Flutter.png'),
                    subjectCard(context, 'Advance DBMS', 'Assets/Images/ADBMS.png'),
                    subjectCard(context, 'Emotional Intelligence', 'Assets/Images/Emotional_int.png'),
                    subjectCard(context, 'Web Services', 'Assets/Images/Webservices.png'),
                    subjectCard(context, 'Game Programming', 'Assets/Images/Game_pro.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'Challenge Your Knowledge with a Test.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
            GlassmorphicBackground(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                  children: [
                    testCard(context, 'Java Framework', 'Assets/Images/Test_sec_icon.png'),
                    testCard(context, 'Hybrid Programming', 'Assets/Images/Test_sec_icon.png'),
                    testCard(context, 'Emotional Intelligence', 'Assets/Images/Test_sec_icon.png'),
                    testCard(context, 'Game Programming', 'Assets/Images/Test_sec_icon.png'),
                    testCard(context, 'Advance DBMS', 'Assets/Images/Test_sec_icon.png'), // This will navigate to ADBMSTest
                    testCard(context, 'Web Services', 'Assets/Images/Test_sec_icon.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/questionPapers');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 148, 46),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: const Text(
                      'Question Paper\'s',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 17, 27), fontFamily: 'Poppins'),
                    ),
                    subtitle: const Text(
                      'Total Papers uploaded: 35',
                      style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins'),
                    ),
                    trailing: Image.asset(
                      'Assets/Images/question_paper_icon.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 12, 17, 27),
        elevation: 0,
        selectedItemColor: const Color.fromARGB(255, 232, 148, 46),
        unselectedItemColor: const Color.fromARGB(255, 12, 17, 27),
        showUnselectedLabels: true,
        currentIndex: currentIndex, // Use the state variable
        onTap: (index) {
          setState(() {
            currentIndex = index; // Update the current index
          });
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StudentDashboardPage()),
                    (Route<dynamic> route) => false, // Remove all previous routes
              );
              break;
            case 1:
            // Already on NotesPage, do nothing
              break;
            case 2:
              Navigator.pushNamed(context, '/video');
              break;
            case 3:
              Navigator.pushNamed(context, '/forum');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                boxShadow: currentIndex == 0
                    ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 232, 148, 46).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                    : [],
              ),
              child: Image.asset(
                'Assets/Images/Home_quicknav.png',
                width: 44,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                boxShadow: currentIndex == 1
                    ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 232, 148, 46).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                    : [],
              ),
              child: Image.asset(
                'Assets/Images/Notes_quicknav.png',
                width: 44,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                boxShadow: currentIndex == 2
                    ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 232, 148, 46).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                    : [],
              ),
              child: Image.asset(
                'Assets/Images/video_lect_quicknav.png',
                width: 44,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                boxShadow: currentIndex == 3
                    ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 232, 148, 46).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                    : [],
              ),
              child: Image.asset(
                'Assets/Images/community_quicknav.png',
                width: 44,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                boxShadow: currentIndex == 4
                    ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 232, 148, 46).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ]
                    : [],
              ),
              child: Image.asset(
                'Assets/Images/Avatar.png',
                width: 44,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget subjectCard(BuildContext context, String title, String iconPath) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/subject/${title.replaceAll(' ', '')}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(225, 186, 187, 180).withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 500,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Poppins'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget testCard(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == 'Advance DBMS') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ADBMSTest()), // Navigate to ADBMSTest
          );
        } else {
          Navigator.pushNamed(context, '/test/${title.replaceAll(' ', '')}');
        }
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(225, 186, 187, 180).withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassmorphicBackground extends StatelessWidget {
  final Widget child;

  const GlassmorphicBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // Adjust the radius for your preference
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 12, 17, 27).withOpacity(0.05), // Adjust this for the background color effect
          ),
          child: child,
        ),
      ),
    );
  }
}
