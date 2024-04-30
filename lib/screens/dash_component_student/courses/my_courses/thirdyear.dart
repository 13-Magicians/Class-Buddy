import 'package:flutter/material.dart';

import '../../../../operations/student_course.dart';
import 'courseinside.dart';

class DisplayMyCourseThirdYear extends StatefulWidget {
  const DisplayMyCourseThirdYear({super.key});

  @override
  State<DisplayMyCourseThirdYear> createState() => _DisplayMyCourseThirdYearState();
}

class _DisplayMyCourseThirdYearState extends State<DisplayMyCourseThirdYear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      appBar: AppBar(title: Text('Third Year Courses'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('31'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses, '31');
                  }
                },
              ),
            ),
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('32'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses, '32');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseList(List<Map<String, dynamic>> courses, String semNo) {
    if (courses.isEmpty) {
      return Center(
        child: Text('Nothing found\n or\n You need to select Academic Year in Profile section',),
      );
    }
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          color: Colors.red.shade50,
          child: ListTile(
            leading: Icon(Icons.ac_unit_outlined),
            title: Text(course['courseCode'] ?? ''),
            subtitle: Text(course['subjectName'] ?? ''),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourseInside(course['courseCode'],course['subjectName'],semNo)),);
            },
            // Add other information if needed
          ),
        );
      },
    );
  }





}
