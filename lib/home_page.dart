import 'package:flutter/material.dart';
import 'package:study_sphere/notes_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  _StudentDashboardPageState createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  int currentIndex = 0; // Track the current index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 17, 27), // Dark background color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 17, 27),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(1.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('Assets/Images/Avatar.png'), // Profile image
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User1_C 6008',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Student',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Poppins',
              ),
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
          children: <Widget>[
            // Recent Announcements Section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Announcement',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    ' ${DateTime.now().day} ${getMonthName(DateTime.now().month)}, ${DateTime.now().year}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 232, 148, 46),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 148, 46),
                borderRadius: BorderRadius.circular(10), // Reduced border radius
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Due to heavy rain, there is no college tomorrow.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image.asset('Assets/Images/Announcement_icon.png', width: 50, height: 40, fit: BoxFit.cover),
                ],
              ),
            ),

            // Current Progress Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Text(
                'Your Current Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            GlassmorphicContainer(
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(10),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0), // Hide grid lines on X-axis
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0), // Hide grid lines on Y-axis
                  ),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.semester,
                      yValueMapper: (ChartData data, _) => data.score,
                      color: Colors.orange,
                      width: 2,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                  plotAreaBorderWidth: 0, // Hide plot area border
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Attendance Section with View Timetable
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Present Attendance:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(225, 186, 187, 180).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10), // Reduced border radius
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          '89%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 232, 148, 46),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  // View Timetable Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigation logic here
                    },
                    child: const Text(
                      'View Timetable',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 12, 17, 27),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 148, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Reduced border radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Recently Watched Lectures Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                'Recently Watched Lectures',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Java Framework Lecture Container
            GlassmorphicContainer(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align to the left
                  children: [
                    LectureCard(
                      imagePath: 'Assets/Images/JavaFramework.png',
                      title: 'Java Framework',
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Lecture: Java Framework',
                            style: TextStyle(
                              color: Color.fromARGB(255, 232, 148, 46),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Lecture by: Mansi maam',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Duration: 40 mins',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LectureCard(
                      imagePath: 'Assets/Images/Continue_watching_icon.png',
                      title: 'Continue Watching',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ADBMS Lecture Container
            GlassmorphicContainer(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align to the left
                  children: [
                    LectureCard(
                      imagePath: 'Assets/Images/ADBMS.png',
                      title: 'ADBMS',
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Lecture: Advanced DBMS',
                            style: TextStyle(
                              color: Color.fromARGB(255, 232, 148, 46),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Lecture by: Shubhangi maam',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Duration: 43 mins',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LectureCard(
                      imagePath: 'Assets/Images/Continue_watching_icon.png',
                      title: 'Continue Watching',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 235, 239), // Background color
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), // Adjust the radius as needed
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -2), // Adjust shadow position
            ),
          ],
        ),
        child: BottomNavigationBar(
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
              // Home - already on StudentDashboardPage, do nothing
                break;
              case 1:
              // Navigate to NotesPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesPage()),
                );
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
      ),
    );
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  List<ChartData> getChartData() {
    return [
      ChartData('Sem 1', 8.5),
      ChartData('Sem 2', 8.2),
      ChartData('Sem 3', 8.2),
      ChartData('Sem 4', 8.4),
      ChartData('Sem 5', 8.3),
      ChartData('Sem 6', 8.1),
    ];
  }
}

class ChartData {
  final String semester;
  final double score;

  ChartData(this.semester, this.score);
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;

  const GlassmorphicContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // Reduced border radius
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(225, 186, 187, 180).withOpacity(0.22),
            borderRadius: BorderRadius.circular(10), // Reduced border radius
          ),
          child: child,
        ),
      ),
    );
  }
}

class LectureCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const LectureCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 90,
          height: 80,
        ),
        const SizedBox(height: 1),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
