import 'package:classbuddy/operations/user_handler.dart';
import 'package:classbuddy/screens/dash_component_student/courses/all_courses/firstyear.dart';
import 'package:flutter/material.dart';
import '../../../operations/student_course.dart';
import 'all_courses/orientation.dart';
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
          Text('My Courses'),
          MyCourseMenu(),
          // MyCourses(),
          Text('All Courses'),
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
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
            color: Colors.amber,
            child: ListTile(
              title: const Text('    Second Year'),
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
            color: Colors.amber,
            child: ListTile(
              title: const Text('    Third Year'),
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
            color: Colors.amber,
            child: ListTile(
              title: const Text('    Fourth Year'),
              trailing: IconButton(onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined)
              ),
              leading: const Icon(Icons.sailing),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DisplayMyCourseOrientation()),);
              },

            ),
          ),

        ],),
    );
  }
}





//
//
// class MyCourses extends StatefulWidget {
//   const MyCourses({super.key});
//
//   @override
//   State<MyCourses> createState() => _MyCoursesState();
// }
//
// class _MyCoursesState extends State<MyCourses> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: FutureBuilder<List<Map<String, dynamic>>>(
//           future: StudentOperations().getMyCourses(),
//           builder: (context, snapshot) {
//             return ListView.builder(
//               itemBuilder: (context, index) {
//                 return const Placeholder();
//
//             },);
//           },),
//     );
//   }
// }



