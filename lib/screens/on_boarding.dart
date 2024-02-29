import 'package:flutter/material.dart';
import '../main.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: double.maxFinite,
              child: Column(children: [
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top:100.0),
                  child: Center(child: const Text('Class Buddy', style: TextStyle(fontSize: 50.0, fontFamily: 'K2D',fontWeight: FontWeight.bold,color: Color(0xFF4F0000)),)),
                ),
                Container(
                  margin: EdgeInsets.only(top:15.0),
                  child: Text('Learn it easily',style: TextStyle(fontSize: 16.0,color: Colors.black54,fontWeight: FontWeight.bold),),
                ),
              ],)
          ),
          Container(
            margin: const EdgeInsets.only(top: 1.0),
            child: Image.asset('assets/images/CB_Ico.png',width:80.0,height:80.0),
          ),
          Container(
            margin: EdgeInsets.only(top:1.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:1.0),
                  child: Text('Learning Management System',style: TextStyle(fontSize: 15.0,color: Colors.black87,fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                ),
                Container(
                  width: 230.0,
                  margin: EdgeInsets.only(top:20.0),
                  child: Text('Our LMS app is designed to make online learning efficient, and accessible.',textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0,color: Colors.black87,fontWeight: FontWeight.w300,letterSpacing: 0.6),),
                ),
                Container(
                    width: 240.0,
                    height: 40.0,
                    margin: EdgeInsets.only(top:20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('Lets Get Started',style: TextStyle(color: Color(0xFFEAEAEA))),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            backgroundColor: Color(0xFFD13838)
                        )
                    )
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}

