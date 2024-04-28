import 'package:flutter/material.dart';

class DisplayAllCourseOrientation extends StatefulWidget {
  const DisplayAllCourseOrientation({super.key});

  @override
  State<DisplayAllCourseOrientation> createState() => _DisplayAllCourseOrientationState();
}

class _DisplayAllCourseOrientationState extends State<DisplayAllCourseOrientation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Card(child: Container(child: Column(
        children: [
          ListTile(title: Text('list text'),),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('back'))
        ],
      ),))),
    );
  }
}
