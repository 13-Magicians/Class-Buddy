import 'package:flutter/material.dart';
import '../services/auth.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({super.key});

  @override
  State<AdminDash> createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  static const List<Widget> _widgetOptions = <Widget>[
    eExplore_LD(),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    aProfile(),
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


class eExplore_LD extends StatefulWidget {
  const eExplore_LD({super.key});


  @override
  State<eExplore_LD> createState() => _eExplore_LDState();
}

class _eExplore_LDState extends State<eExplore_LD> {
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
                    "Hello Admin",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.notifications_active))
                ],
              ),
            ),
            Container(
              height: 200.0,
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: ListTile.divideTiles(
                    context: context,
                    color: Colors.white,
                    tiles: [
                      ExpansionTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Department'),
                        trailing: Icon(Icons.arrow_right_rounded),
                        children: [
                          Text('Make Your department changes'),
                          ButtonBar(children: [
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.add)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
                          ],)
                        ],
                        // onTap: () {
                        //   print('Manage Department');
                        // },
                        // tileColor: Colors.red[100],
                        // horizontalTitleGap: 20,
                        // contentPadding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        // focusColor: Colors.amberAccent,
                        // hoverColor: Colors.blue,
                        // selectedTileColor: Colors.brown,
                      ),
                      ListTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Lectures'),
                        trailing: Icon(Icons.arrow_right_rounded),
                        onTap: () {
                          print('Manage Lectures');
                        },
                        tileColor: Colors.red[100],
                        horizontalTitleGap: 20,
                        contentPadding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        focusColor: Colors.amberAccent,
                        hoverColor: Colors.blue,
                        selectedTileColor: Colors.brown,
                      ),
                      ListTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Student'),
                        trailing: Icon(Icons.arrow_right_rounded),
                        onTap: () {
                          print('Manage Student');
                        },
                        tileColor: Colors.red[100],
                        horizontalTitleGap: 20,
                        contentPadding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        focusColor: Colors.amberAccent,
                        hoverColor: Colors.blue,
                        selectedTileColor: Colors.brown,
                      )
                    ]).toList(),
                // ListTile(
                //   leading: Icon(Icons.add_card),
                //   title: Text('Manage Department'),
                //   trailing: Icon(Icons.arrow_right_rounded),
                //   onTap: () {
                //     print('Manage Department');
                //   },
                //   tileColor: Colors.teal,
                //   horizontalTitleGap: 20,
                //   contentPadding: EdgeInsets.all(5.0),
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                //   focusColor: Colors.amberAccent,
                //   hoverColor: Colors.blue,
                //   selectedTileColor: Colors.brown,
                // ),
                // ListTile(
                //   leading: Icon(Icons.add_card),
                //   title: Text('Manage Lectures'),
                //   trailing: Icon(Icons.arrow_right_rounded),
                //   onTap: () {
                //     print('Manage Lectures');
                //   },
                //   tileColor: Colors.teal,
                //   horizontalTitleGap: 20,
                //   contentPadding: EdgeInsets.all(5.0),
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                //   focusColor: Colors.amberAccent,
                //   hoverColor: Colors.blue,
                //   selectedTileColor: Colors.brown,
                // )
                // ],
              ),
            ),


            // Container(
            //   height: 200.0,
            //   child: Column(mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Card(clipBehavior: Clip.hardEdge,
            //     child: InkWell(
            //       splashColor: Colors.blue,
            //       onTap: () {print('--------cardTap--------');},
            //       child: SizedBox(
            //         width: 300.0,
            //         height: 100.0,
            //         child: Text("Set Card Text"),
            //       ),
            //     ),)
            //   ]),
            // ),
            // Container(
            //   height: 200.0,
            //   child: ListView(
            //     children: [
            //       ElevatedButton(
            //           onPressed: () {
            //             authMethods().userSignOut(context);
            //           },
            //           child: Text('Press')),
            //       ElevatedButton(
            //           onPressed: () {
            //             authMethods().getCurrentUser();
            //           },
            //           child: Text('Get'))
            //     ],
            //   ),
            //
            // ),
          ],
        ),
      ),
    );
  }
}

class aProfile extends StatefulWidget {
  const aProfile({super.key});

  @override
  State<aProfile> createState() => _aProfileState();
}

class _aProfileState extends State<aProfile> {
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
                    "Hello Lecture",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.notifications_active))
                ],
              ),
            ),
            Container(
              height: 200.0,
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

