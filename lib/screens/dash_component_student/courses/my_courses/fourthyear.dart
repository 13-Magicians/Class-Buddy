import 'package:flutter/material.dart';

import '../../../../operations/student_course.dart';
import 'courseinside.dart';

class DisplayMyCourseFourthYear extends StatefulWidget {
  const DisplayMyCourseFourthYear({super.key});

  @override
  State<DisplayMyCourseFourthYear> createState() => _DisplayMyCourseFourthYearState();
}

class _DisplayMyCourseFourthYearState extends State<DisplayMyCourseFourthYear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      appBar: AppBar(title: Text('Fourth Year Courses'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('41'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses, '41');
                  }
                },
              ),
            ),
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('42'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses, '42');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseList(List<Map<String, dynamic>> courses,String semNo) {
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
