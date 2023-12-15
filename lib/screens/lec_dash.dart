import 'package:flutter/material.dart';

import '../operations/opfirestore.dart';

class LecDash extends StatefulWidget {
  const LecDash({super.key});

  @override
  State<LecDash> createState() => _LecDashState();
}

class _LecDashState extends State<LecDash> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  static const List<Widget> _widgetOptions = <Widget>[
    Explore_LD(),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('Label behavior: ${labelBehavior.name}'),
      //       const SizedBox(height: 10),
      //       OverflowBar(
      //         spacing: 10.0,
      //         children: <Widget>[
      //           ElevatedButton(
      //             onPressed: () {
      //               setState(() {
      //                 labelBehavior =
      //                     NavigationDestinationLabelBehavior.alwaysShow;
      //               });
      //             },
      //             child: const Text('alwaysShow'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               setState(() {
      //                 labelBehavior =
      //                     NavigationDestinationLabelBehavior.onlyShowSelected;
      //               });
      //             },
      //             child: const Text('onlyShowSelected'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               setState(() {
      //                 labelBehavior =
      //                     NavigationDestinationLabelBehavior.alwaysHide;
      //               });
      //             },
      //             child: const Text('alwaysHide'),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFFF9DEC9),
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        elevation: 0.2,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.corporate_fare),
            label: 'Classes',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle_outlined),
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Explore_LD extends StatefulWidget {
  const Explore_LD({super.key});

  @override
  State<Explore_LD> createState() => _Explore_LDState();
}

class _Explore_LDState extends State<Explore_LD> {
  var userData = 'User';
  var items = List<String>.generate(10, (index) => 'Item $index');

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
                    "Hello $userData",
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
                  ElevatedButton(onPressed: getStarted_readData, child: Text('Press'))
                ],
              )

            ),


          ],
        ),
      ),
    );
  }
}
