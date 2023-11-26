import 'package:flutter/material.dart';

class CB_Login extends StatefulWidget {
  const CB_Login({super.key});

  @override
  State<CB_Login> createState() => _CB_LoginState();
}

class _CB_LoginState extends State<CB_Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:30.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 10.0, left: 40.0),
                              child: const Text('Class', style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'K2D',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F0000)),)
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 1.0, left: 40.0),
                              child: const Text('Buddy', style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'K2D',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F0000)),)
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left:70.0),
                        child: Image.asset('assets/images/CB_Ico.png',width:80.0,height:80.0),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:25.0),
                  child: Text('Learn it easily',style: TextStyle(fontSize: 15.0,color: Colors.black87,fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                )
              ],
            )
          ),
          Container(
            width: 280.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('Welcome !',style: TextStyle(fontSize: 15.0,color: Color(0xFFEC6565),fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                ),
                Container(
                  margin: EdgeInsets.only(top:14.0),
                  child: Text('Find what you are looking for',style: TextStyle(fontSize: 48.0,color: Color(0xFF823232),fontWeight: FontWeight.w100),),
                ),
                Container(
                  margin: EdgeInsets.only(top:12.0),
                  child: Text('By personalize your account, we can help you to find what you like.',style: TextStyle(fontSize: 14.0,color: Color(0xFF9E7878),fontWeight: FontWeight.bold,letterSpacing: 0.8),),
                ),
                Container(
                    width: 280.0,
                    height: 45.0,
                    margin: EdgeInsets.only(top:40.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Sign in with Google',style: TextStyle(letterSpacing: 1.0,fontWeight: FontWeight.w500)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            backgroundColor: Color(0xFFD13838)
                        )
                    )
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
