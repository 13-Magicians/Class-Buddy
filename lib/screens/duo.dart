import 'package:flutter/material.dart';

class Duo extends StatelessWidget {
  const Duo({super.key});


  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: "CB Test",
      home: HomePage(),
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 0;

  void Incresment() {
    setState(() {
      count = count + 1;
      print(count);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have push the button times'),
            Text(count.toString(), style: const TextStyle(color: Colors.black45,fontSize: 20.0),
            ),
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Incresment,
        child: const Icon(Icons.add),
      ),

    );
  }
}


// class HomePage extends StatelessWidget {
//
//   int count = 0;
//
//   HomePage({super.key});
//
//   void incresment() {
//     count = count + 1;
//     print(count);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body:  Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('You have push the button times'),
//             Text(count.toString(), style: const TextStyle(color: Colors.black45,fontSize: 20.0),
//             ),
//           ],
//
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: incresment,
//         child: const Icon(Icons.add),
//       ),
//
//     );
//   }
// }
