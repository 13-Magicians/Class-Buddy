import 'package:flutter/material.dart';

import '../../../operations/student_course.dart';

class CourseSection extends StatefulWidget {
  const CourseSection({super.key});

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(
      children: [
        Text('My Courses'),
        MyCourses(),

      ],
    ),);
  }
}


class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<Map<String, dynamic>>>(
          future: StudentOperations().getMyCourses(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Placeholder();

            },);
          },),
    );
  }
}



