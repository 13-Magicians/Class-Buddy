import 'package:flutter/material.dart';

import '../services/auth.dart';


class StuDash extends StatefulWidget {
  const StuDash({super.key});

  @override
  State<StuDash> createState() => _StuDashState();
}

class _StuDashState extends State<StuDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70.0,
              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFF9DEC9),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Student",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.notifications_active))
                ],
              ),
            ),
            Container(
              height: 400.0,
              child: ListView(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        authMethods().userSignOut(context);
                      },
                      child: Text('Press')),
                  ElevatedButton(
                      onPressed: () {
                        authMethods().getCurrentUser();
                      },
                      child: Text('Get'))
                ],
              ),

            ),


          ],
        ),
      ),
    );
  }
}
