import 'package:flutter/material.dart';

import '../../../../operations/student_course.dart';

class DisplayMyCourseSecondYear extends StatefulWidget {
  const DisplayMyCourseSecondYear({super.key});

  @override
  State<DisplayMyCourseSecondYear> createState() => _DisplayMyCourseSecondYearState();
}

class _DisplayMyCourseSecondYearState extends State<DisplayMyCourseSecondYear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      appBar: AppBar(title: Text('Second Year Courses'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('21'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses);
                  }
                },
              ),
            ),
            Text('First Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getEnrolledCourses('22'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  // } else if (snapshot.hasError) {
                  //   return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseList(List<Map<String, dynamic>> courses) {
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

            },
            // Add other information if needed
          ),
        );
      },
    );
  }





}
