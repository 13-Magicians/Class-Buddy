import 'package:flutter/material.dart';

class CBHomeScr extends StatelessWidget {
  const CBHomeScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Buddy'),
        backgroundColor: Colors.redAccent,
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.notifications)),
          IconButton(onPressed: null, icon: Icon(Icons.account_circle))
        ],
        elevation: 4.0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Text', style: TextStyle(
              fontSize: 20.0,
            ),),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/duo');
                },
                child: Text('Next Page'))

          ],

        ),
      ),
    );
  }
}