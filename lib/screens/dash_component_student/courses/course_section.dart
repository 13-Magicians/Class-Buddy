import 'package:classbuddy/screens/dash_component_student/courses/all_courses/firstyear.dart';
import 'package:flutter/material.dart';
import 'all_courses/fourthyear.dart';
import 'all_courses/orientation.dart';
import 'all_courses/secondyear.dart';
import 'all_courses/thirdyear.dart';
import 'my_courses/firstyear.dart';
import 'my_courses/fourthyear.dart';
import 'my_courses/orientation.dart';
import 'my_courses/secondyear.dart';
import 'my_courses/thirdyear.dart';

class CourseSection extends StatefulWidget {
  const CourseSection({super.key});

  @override
  State<CourseSection> createState() => _CourseSectionState();
}

class _CourseSectionState extends State<CourseSection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Card(
            color: Colors.deepOrangeAccent,
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 8),
            child: Text('My Courses'),
          )),
          MyCourseMenu(),
          // MyCourses(),
          Card(
              color: Colors.deepOrangeAccent,
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50,vertical: 8),
            child: Text('All Courses'),
          )),
          AllCourseMenu(),
        ],
      ),
    ),);
  }
}


class MyCourseMenu extends StatefulWidget {
  const MyCourseMenu({super.key});

  @override
  State<MyCourseMenu> createState() => _MyCourseMenuState();
}

class _MyCourseMenuState extends State<MyCourseMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Orientation'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseOrientation()),);
              },

            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    First Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseFirstYear()),);
              },


            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Second Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseSecondYear()),);
              },


            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Third Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseThirdYear()),);
              },

            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Fourth Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseFourthYear()),);
              },

            ),
          ),

        ],),
    );
  }
}

class AllCourseMenu extends StatefulWidget {
  const AllCourseMenu({super.key});

  @override
  State<AllCourseMenu> createState() => _AllCourseMenuState();
}

class _AllCourseMenuState extends State<AllCourseMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Orientation'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayAllCourseOrientation()),);
              },
            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    First Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayAllCourseFirstYear()),);
              },

            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Second Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayAllCourseSecondYear()),);
              },

            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Third Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayAllCourseThirdYear()),);
              },

            ),
          ),
          Card(
            color: Colors.deepOrange.shade100,
            child: ListTile(
              title: const Text('    Fourth Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayAllCourseFourthYear()),);
              },

            ),
          ),

        ],),
    );
  }
}

