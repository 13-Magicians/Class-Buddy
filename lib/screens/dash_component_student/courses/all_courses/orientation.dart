import 'package:flutter/material.dart';

import '../../../../operations/student_course.dart';

class DisplayAllCourseOrientation extends StatefulWidget {
  const DisplayAllCourseOrientation({super.key});

  @override
  State<DisplayAllCourseOrientation> createState() => _DisplayAllCourseOrientationState();
}

class _DisplayAllCourseOrientationState extends State<DisplayAllCourseOrientation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade100,
      appBar: AppBar(title: Text('Oriantation Courses'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: StudentOperations().getAllCourses('01'),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PasscodeInputDialog(
                    onSubmitted: (passcode) {
                      // Do something with the submitted passcode
                      print('Submitted passcode: $passcode');
                      StudentOperations().enrollToCourse('01', course['courseCode'], passcode);


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

  // popup dialog

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

