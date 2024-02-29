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

    Text('Explore Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    aMangeDep(),
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      appBar: AppBar(
        title: Text('Explore Page'),
        backgroundColor: Color(0xFFF9DEC9),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
        shadowColor: Colors.black,
        centerTitle: true,

      ),
      bottomNavigationBar: Container(
        child: NavigationBar(
          backgroundColor: Color(0xFFF9DEC9),
          labelBehavior: labelBehavior,
          selectedIndex: currentPageIndex,
          elevation: 0.0,
          indicatorColor: Color(0xFFF78CA2),
          animationDuration: Duration(milliseconds: 1000),
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.explore_outlined),
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.corporate_fare_outlined),
              icon: Icon(Icons.corporate_fare),
              label: 'Manage',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle_outlined),
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}


class aMangeDep extends StatefulWidget {
  const aMangeDep({super.key});


  @override
  State<aMangeDep> createState() => _aMangeDepState();
}

class _aMangeDepState extends State<aMangeDep> {

  late TextEditingController fcName;
  late TextEditingController fcCode;

  void initState() {
    super.initState();

    fcName = TextEditingController();
    fcCode = TextEditingController();

  }

  void dispose() {
    fcName.dispose();
    fcCode.dispose();

    super.dispose();
  }


  var userData = 'User';
  var items = List<String>.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70.0,
              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFA56757),
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
              height: 400.0,
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: ListTile.divideTiles(
                    context: context,
                    color: Colors.white,
                    tiles: [
                      ExpansionTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Department'),
                        trailing: Icon(Icons.arrow_drop_down),
                        backgroundColor:Color(0xFFFF8766),
                        collapsedBackgroundColor: Color(0xFFF9DEC9),

                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        children: [
                          Text('Make Your department changes'),
                          ButtonBar(children: [
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
                            ElevatedButton(onPressed: () {
                              print("xxxxxxxxxx");
                              DepAddOpenDialog();
                            }, child:Icon(Icons.add)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
                          ],)
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      ExpansionTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Lectures'),
                        trailing: Icon(Icons.arrow_drop_down),
                        children: [
                          Text("Make Your Lecturer's changes"),
                          ButtonBar(children: [
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.add)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
                          ],)
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),

                      ),
                      ExpansionTile(
                        leading: Icon(Icons.add_card),
                        title: Text('Manage Student'),
                        trailing: Icon(Icons.arrow_drop_down),
                        children: [
                          Text("Make Your Student's changes"),
                          ButtonBar(children: [
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
                            ElevatedButton(onPressed: () {

                            }, child:Icon(Icons.add)),
                            ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
                          ],)
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ]).toList(),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Future<String?> DepAddOpenDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Department'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fcCode,
              autofocus: true,
              decoration: InputDecoration(hintText: 'Dep code (eg:ICT,EET,BPT)'),
            ),
            TextField(
              controller: fcName,
              decoration: InputDecoration(hintText: 'Department name'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            btnClose();
          }, child: Text('Cancel')),
          TextButton(onPressed: () {
            btnOk();
          }, child: Text('OK'))
        ],
        backgroundColor: Colors.lightGreenAccent,

      )
  );

  Future DepRemOpenDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(


  ));

  void btnOk() {
    print(fcName.text);
    print(fcCode.text);
    fcCode.clear();
    fcName.clear();
    Navigator.of(context).pop();
  }

  void btnClose() {
    fcCode.clear();
    fcName.clear();
    Navigator.of(context).pop();
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
      resizeToAvoidBottomInset: false,
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
              height: 400.0,
              padding: EdgeInsets.fromLTRB(50.0, 150.0, 50.0, 50.0),
              child: ListView(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        authMethods().userSignOut(context);
                      },
                      child: Text('Sign Out')),
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



