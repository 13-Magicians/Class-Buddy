
import 'package:flutter/material.dart';

import '../../../../operations/student_course.dart';

class DisplayAllCourseSecondYear extends StatefulWidget {
  const DisplayAllCourseSecondYear({super.key});

  @override
  State<DisplayAllCourseSecondYear> createState() => _DisplayAllCourseSecondYearState();
}

class _DisplayAllCourseSecondYearState extends State<DisplayAllCourseSecondYear> {
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
                future: StudentOperations().getAllCourses('21'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final courses = snapshot.data ?? [];
                    return buildCourseList(courses);
                  }
                },
              ),
            ),
            Text('Second Semester'),
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getAllCourses('22'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
        child: Text('Nothing found'),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PasscodeInputDialog(
                    onSubmitted: (passcode) {
                      // Do something with the submitted passcode
                      print('Submitted passcode: $passcode');
                    },
                  );
                },
              );
            },
            // Add other information if needed
          ),
        );
      },
    );
  }

}

class PasscodeInputDialog extends StatelessWidget {
  final Function(String)? onSubmitted;

  const PasscodeInputDialog({Key? key, this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String passcode = '';

    return AlertDialog(
      title: Text('Enter Passcode'),
      content: TextField(
        onChanged: (value) {
          passcode = value;
        },
        decoration: InputDecoration(hintText: 'Passcode'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onSubmitted != null) {
              onSubmitted!(passcode);
            }
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}


