import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import '../main.dart';
import '../services/authentication.dart';

class CBSplashScr extends StatefulWidget {
  const CBSplashScr(version, {super.key});

  @override
  State<CBSplashScr> createState() => _CBSplashScrState();
}

class _CBSplashScrState extends State<CBSplashScr>  with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _animationValue = 0.0;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {
        _animationValue = _animationController.value;
      });
    });

    // Start the animation
    _animationController.forward();

    // Add a status listener to the animation controller
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, dispose the controller
        _animationController.dispose();
        // Navigate to the next screen
        checkUserAndNavigate();
      }
    });
  }

  void checkUserAndNavigate() {
    AuthMethods().getCurrentUser().then((userId) {
      if (userId != null) {
        AuthMethods().signInWithGoogle(context);
      } else {
        Navigator.pushReplacementNamed(context, '/onboard');
      }
    });
  }


  bool _disposed = false;

  @override
  void dispose() {
    if (!_disposed) {
      _disposed = true;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(left:30.0,top:1.0),
              child: Column(
                children: [
                  Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(left:30.0,top:1.0),
                      child: const Text('Class', style: TextStyle(fontSize: 50.0, fontFamily: 'K2D',fontWeight: FontWeight.bold,color: Color(0xFF4F0000)),)
                  ),
                  Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(left:68.0,top:5.0),
                      child: const Text('Buddy', style: TextStyle(fontSize: 50.0, fontFamily: 'K2D',fontWeight: FontWeight.bold,color: Color(0xFF4F0000)),)
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 220.0,top: 2.0),
                    child: Image.asset('assets/images/CB_Ico.png',width:80.0,height:80.0),
                  ),
                ],
              )
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                margin: const EdgeInsets.only(top: 3.0),
                child: ProgressBar(
                  backgroundColor: Colors.black12,
                  value: _animationValue,
                  gradient: const LinearGradient(colors: [Colors.deepOrange,Colors.orange]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top:15.0),
                child: const Text(version),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: const Text('Magicians',style: TextStyle(fontSize: 26.0,fontFamily: 'K2D',color: Colors.black54),),
              )
            ],
          ),
        ],
      ),
    );
  }
}

