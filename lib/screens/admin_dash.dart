import 'package:classbuddy/services/fireDatabase.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/fireManageDep.dart';
import 'package:intl/intl.dart';



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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
  List<Map<String, dynamic>> depList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    depList = await DataOrgManage().departmentList();
    print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    print(depList);
    setState(() {});
  }

  var userData = 'User';
  var items = List<String>.generate(10, (index) => 'Item $index');

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: 700.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), color: Colors.amberAccent),
          margin: EdgeInsets.all(4.0),
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













              // Container(
              //   height: double.maxFinite,
              //   color: Colors.cyanAccent,
              //   child: ListView(
              //     padding: EdgeInsets.all(10.0),
              //     children: ListTile.divideTiles(
              //         context: context,
              //         color: Colors.white,
              //         tiles: [
              //           ExpansionTile(
              //             leading: Icon(Icons.add_card),
              //             title: Text('Manage Department'),
              //             trailing: Icon(Icons.arrow_drop_down),
              //             backgroundColor: Color(0xFFFF8766),
              //             collapsedBackgroundColor: Color(0xFFF9DEC9),
              //             collapsedShape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(15.0)),
              //             children: [
              //               // Text('Make Your department changes'),
              //               // ButtonBar(
              //               //   children: [
              //               //     ElevatedButton(
              //               //         onPressed: () {
              //               //           // DataOrgManage().departmentList();
              //               //         },
              //               //         child: Icon(Icons.construction_sharp)),
              //               //     ElevatedButton(
              //               //         onPressed: () {
              //               //           print("xxxxxxxxxx");
              //               //           showDialog(
              //               //               context: context,
              //               //               builder: (context) {
              //               //                 return AddDepartmentDialog();
              //               //               });
              //               //           // DepAddOpenDialog();
              //               //         },
              //               //         child: Icon(Icons.add)),
              //               //     ElevatedButton(
              //               //         onPressed: () {}, child: Icon(Icons.remove)),
              //               //   ],
              //               // ),
              //             //   Text('data'),
              //             //   ListView.separated(
              //             //     itemBuilder: (context, index) {
              //             //       return ListTile(
              //             //         title: Text(depList[index].keys.first),
              //             //         subtitle: Text(depList[index].values.first),
              //             //       );
              //             //     },
              //             //     separatorBuilder: (context, index) {
              //             //       return Divider(
              //             //         height: 20.0,
              //             //         thickness: 1,
              //             //       );
              //             //     },
              //             //     itemCount: depList.length,
              //             //   ),
              //             // ],
              //             // shape: RoundedRectangleBorder(
              //             //     borderRadius: BorderRadius.circular(15.0)),
              //           ),
              //           // ExpansionTile(
              //           //   leading: Icon(Icons.add_card),
              //           //   title: Text('Manage Lectures'),
              //           //   trailing: Icon(Icons.arrow_drop_down),
              //           //   children: [
              //           //     Text("Make Your Lecturer's changes"),
              //           //     ButtonBar(children: [
              //           //       ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
              //           //       ElevatedButton(onPressed: () {}, child:Icon(Icons.add)),
              //           //       ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
              //           //     ],)
              //           //   ],
              //           //   shape: RoundedRectangleBorder(
              //           //       borderRadius: BorderRadius.circular(15.0)),
              //           //
              //           // ),
              //           // ExpansionTile(
              //           //   leading: Icon(Icons.add_card),
              //           //   title: Text('Manage Student'),
              //           //   trailing: Icon(Icons.arrow_drop_down),
              //           //   children: [
              //           //     Text("Make Your Student's changes"),
              //           //     ButtonBar(children: [
              //           //       ElevatedButton(onPressed: () {}, child:Icon(Icons.construction_sharp)),
              //           //       ElevatedButton(onPressed: () {
              //           //
              //           //       }, child:Icon(Icons.add)),
              //           //       ElevatedButton(onPressed: () {}, child:Icon(Icons.remove)),
              //           //     ],)
              //           //   ],
              //           //   shape: RoundedRectangleBorder(
              //           //       borderRadius: BorderRadius.circular(15.0)),
              //           // ),
              //         ]).toList(),
              //   ),
              // ),
              // ListView.builder(
              //   itemCount: depList.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(depList[index].keys.first),
              //       subtitle: Text(depList[index].values.first),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddDepartmentDialog extends StatefulWidget {
  @override
  _AddDepartmentDialogState createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {
  final TextEditingController fcCode = TextEditingController();
  final TextEditingController fcName = TextEditingController();

  Future<void> btnOk() async {
    if (fcCode.text.isNotEmpty && fcName.text.isNotEmpty) {
      await DataOrgManage().createDepartment(fcName.text, fcCode.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Department added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid department code and name'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              btnOk();
              Navigator.pop(context);
            },
            child: Text('OK'))
      ],
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class aProfile extends StatefulWidget {
  const aProfile({super.key});

  @override
  State<aProfile> createState() => _aProfileState();
}

class _aProfileState extends State<aProfile> {
  List<Map<String, dynamic>> userData = [];


  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    final userId = await authMethods().getCurrentUser();
    userData = await DatabaseMethods().getCurrentUserData(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = userData.isNotEmpty ? userData.first : {};
    final name = user['name'] ?? '';
    final email = user['email'] ?? '';
    print(user['lastLog'] ?? '');
    final lastLog = user['lastLog'] != null
        ? DateFormat(' EEE d MMM y \n hh:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(user['lastLog'] as int),
    )
        : '';
    // final String lastLog = DateFormat(' EEE d MMM y \n hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((user['lastLog'] ?? '')));
    // print(lastLog);
    final role = user['role'] ?? '';
    final imgUrl = user['imgUrl'] ?? 'http://www.gravatar.com/avatar/?d=mp';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
            height: double.maxFinite,
            width: double.maxFinite,
          decoration:BoxDecoration(
            color: Color(0xB69D0000),
              borderRadius: BorderRadius.circular(20.0)) ,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(imgUrl),
                ),
                Chip(
                  label: Text(role,style: TextStyle(fontWeight: FontWeight.bold)),
                  backgroundColor: Color(0xFFFFDCDC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                SizedBox(height: 16),
                Text(name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 32),
                Text('Last Login:'+ lastLog,style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: () {
                    authMethods().userSignOut(context);
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

