// import 'package:flutter/material.dart';
// import 'package:simple_progress_indicators/simple_progress_indicators.dart';
//
// import '../main.dart';
//
//
//
//
// class CBSplashScr extends StatefulWidget {
//   const CBSplashScr(version, {super.key});
//
//   @override
//   State<CBSplashScr> createState() => _CBSplashScrState();
// }
//
// class _CBSplashScrState extends State<CBSplashScr>  with TickerProviderStateMixin {
//   late AnimationController controller;
//
//
//
//   @override
//   void initState() {
//     controller = AnimationController(vsync: this, duration: const Duration(seconds: 2)
//     )..addListener(() {setState(() {
//       if (controller.value == 1) {
//         // Navigator.pushNamed(context, '/onboard');
//         // super.dispose();
//       }
//     });});
//     // controller.forward();
//     // super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//               width: double.maxFinite,
//               margin: const EdgeInsets.only(left:30.0,top:140.0),
//               child: const Text('Class', style: TextStyle(fontSize: 50.0, fontFamily: 'K2D',fontWeight: FontWeight.bold,color: Color(0xFF4F0000)),)
//           ),
//           Container(
//               width: double.maxFinite,
//               margin: const EdgeInsets.only(left:68.0,top:5.0),
//               child: const Text('Buddy', style: TextStyle(fontSize: 50.0, fontFamily: 'K2D',fontWeight: FontWeight.bold,color: Color(0xFF4F0000)),)
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 220.0,top: 20.0),
//             child: Image.asset('assets/images/CB_Ico.png',width:80.0,height:80.0),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 80.0),
//             margin: EdgeInsets.only(top: 300.0),
//             child: ProgressBar(
//               backgroundColor: Colors.black12,
//               value: controller.value,
//               gradient: LinearGradient(colors: [Colors.deepOrange,Colors.orange]),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top:15.0),
//             child: Text(version),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 10.0),
//             child: Text('Magicians',style: TextStyle(fontSize: 26.0,fontFamily: 'K2D',color: Colors.black54),),
//           )
//
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
// // class CBSplashScr extends StatelessWidget {
// //   const CBSplashScr({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Future.delayed(const Duration(seconds: 5), () {
// //     //   Navigator.of(context).pushReplacement(MaterialPageRoute(
// //     //       builder: (BuildContext context) => const CBHomeScr(),
// //     //   ));
// //     // });
// //     return Scaffold(
// //         body: Container(
// //           width:double.maxFinite ,
// //           color: Colors.greenAccent,
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: <Widget>[
// //               const Text(
// //                 'First Text',
// //                 style: TextStyle(fontFamily: 'K2D-Medium',fontSize:30.0),
// //
// //               ),
// //               Column(
// //
// //                 children: [
// //                   const Text(
// //                     'Second Text',
// //                     style: TextStyle(fontFamily: 'K2D-Medium',fontSize:20.0),
// //
// //                   ),
// //                   ElevatedButton(
// //                       onPressed:() {
// //                         Navigator.of(context).pushNamed('/home');
// //                       },
// //                       child: const Text('Click Here',
// //                       style: TextStyle(
// //                         fontSize: 25.0,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.black54,
// //                       )),
// //                   ),
// //
// //                 ],
// //
// //               ),
// //
// //
// //
// //             ],
// //           ),
// //         ));
// //   }
// // }
