import 'package:classbuddy/operations/checkUser.dart';
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
    Text('Chat'),
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
        title: Text('Hello Admin'),
        backgroundColor: Color(0xFFF9DEC9),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        shadowColor: Colors.black,
        centerTitle: true,
        actions: [
          Icon(Icons.notifications),
          Container(
            width: 20,
          )
        ],
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
                selectedIcon: Icon(Icons.chat_outlined),
                icon: Icon(Icons.chat_rounded),
                label: 'Chat'),
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

class _aMangeDepState extends State<aMangeDep> with TickerProviderStateMixin {
  List<Map<String, dynamic>> depList = [];
  List<Map<String, dynamic>> admList = [];
  List<Map<String, dynamic>> lecList = [];
  List<Map<String, dynamic>> usrList = [];
  List<Map<String, dynamic>> allUsrList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    depList = await DataOrgManage().departmentList();
    lecList = await checkUser().retLecUserList();
    admList = await DatabaseMethods().getAdminsOnly();
    usrList = await DatabaseMethods().getStudentsOnly();
    allUsrList = await DatabaseMethods().getAllUsers();
    setState(() {});
  }

  var userData = 'User';
  var items = List<String>.generate(10, (index) => 'Item $index');

  // @override
  Widget build(BuildContext context) {
    TabController _mainPageDivController = TabController(length: 2, vsync: this);
    TabController _mOrgController = TabController(length: 4, vsync: this);
    TabController _mAcadController = TabController(length: 3, vsync: this);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TabBar(controller: _mainPageDivController, tabs: [
        Tab(
          text: 'Users',
        ),
        Tab(
          text: 'Academic',
        )
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _mainPageDivController,
        children: [
          Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
            margin: EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.symmetric(
                      vertical: 8, horizontal: 4),
                  height: 60,
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    indicatorPadding: EdgeInsets.all(2.0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.deepOrange,
                    // automaticIndicatorColorAdjustment: true,
                    controller: _mOrgController,
                    // enableFeedback: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    dividerHeight: 0.0,
                    tabs: [
                      Tab(
                        text: 'All Users',
                        // child: Text('Department',style: TextStyle(fontSize: 12),),
                        // icon: Icon(Icons.home_work_outlined,
                        icon: Badge(
                          label: Text(allUsrList.length.toString()),
                          child: Icon(Icons.groups_rounded),
                        ),
                        iconMargin: EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Lectures',
                        // icon: Icon(Icons.people_alt_outlined),
                        icon: Badge(
                          label: Text(lecList.length.toString()),
                          child: Icon(Icons.people_alt_outlined),
                        ),
                        iconMargin: EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Students',
                        // icon: Icon(Icons.groups_outlined),
                        icon: Badge(
                          label: Text(usrList.length.toString()),
                          child: Icon(Icons.school_outlined),
                        ),
                        iconMargin: EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Admins',
                        // icon: Icon(Icons.admin_panel_settings_outlined),
                        icon: Badge(
                          label: Text(admList.length.toString()),
                          child: Icon(Icons.admin_panel_settings_outlined),
                        ),
                        iconMargin: EdgeInsets.all(6.0),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    controller: _mOrgController,
                    children: [
                      // All User List Section
                      SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: allUsrList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 18),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          allUsrList[index]['imgUrl']),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    minLeadingWidth: 50,
                                    title: Text(allUsrList[index]['name']),
                                    subtitle: Text(allUsrList[index]['email']),
                                    selectedTileColor: Colors.cyanAccent,
                                    hoverColor: Colors.lightGreen,
                                    focusColor: Colors.redAccent,
                                    tileColor: Colors.teal,
                                    trailing: Chip(
                                      label: Text(
                                          allUsrList[index]['role'].toString()),
                                      padding: EdgeInsets.all(0),
                                      side: BorderSide.none,
                                    ),
                                    onTap: () {
                                      print('tap');
                                      print(allUsrList.length);
                                    },
                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              })),
                      // Lecture Section
                      SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: lecList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          lecList[index]['imgUrl']),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    minLeadingWidth: 50,
                                    title: Text(lecList[index]['name']),
                                    subtitle: Text(lecList[index]['email']),
                                    selectedTileColor: Colors.cyanAccent,
                                    hoverColor: Colors.lightGreen,
                                    focusColor: Colors.redAccent,
                                    tileColor: Colors.teal,
                                    trailing: PopupMenuButton(
                                      icon: Chip(
                                        label: Text(
                                            lecList[index]['role'].toString()),
                                        padding: EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text("Admin"),
                                            onTap: () {
                                              if (lecList.length > 1) {
                                                print(lecList[index]['id']);
                                                checkUser().changeRole(
                                                    lecList[index]['id'],
                                                    "Admin");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Text("Student"),
                                            onTap: () {
                                              if (lecList.length > 1) {
                                                checkUser().changeRole(
                                                    lecList[index]['id'],
                                                    "Student");
                                                loadData();
                                              }
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                    onTap: () {
                                      print('tap');
                                      print(lecList.length);
                                    },
                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              })),
                      // User Section
                      SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: usrList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          usrList[index]['imgUrl']),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    minLeadingWidth: 40,
                                    title: Text(usrList[index]['name']),
                                    subtitle: Text(usrList[index]['email']),
                                    selectedTileColor: Colors.cyanAccent,
                                    hoverColor: Colors.lightGreen,
                                    focusColor: Colors.redAccent,
                                    tileColor: Colors.teal,
                                    trailing: PopupMenuButton(
                                      icon: Chip(
                                        label: Text(
                                            usrList[index]['role'].toString()),
                                        padding: EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text("Lecture"),
                                            onTap: () {
                                              if (usrList.length > 1) {
                                                checkUser().changeRole(
                                                    usrList[index]['id'],
                                                    "Lecture");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Text("Admin"),
                                            onTap: () {
                                              if (usrList.length > 1) {
                                                checkUser().changeRole(
                                                    usrList[index]['id'],
                                                    "Admin");
                                                loadData();
                                              }
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                    onTap: () {
                                      print('tap');
                                    },
                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              })),
                      // Admin Section
                      SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: admList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          admList[index]['imgUrl']),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    minLeadingWidth: 40,
                                    title: Text(admList[index]['name']),
                                    subtitle: Text(admList[index]['email']),
                                    selectedTileColor: Colors.cyanAccent,
                                    hoverColor: Colors.lightGreen,
                                    focusColor: Colors.redAccent,
                                    tileColor: Colors.teal,
                                    trailing: PopupMenuButton(
                                      icon: Chip(
                                        label: Text(
                                            admList[index]['role'].toString()),
                                        padding: EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text("Lecture"),
                                            onTap: () {
                                              if (admList.length > 1) {
                                                checkUser().changeRole(
                                                    admList[index]['id'],
                                                    "Lecture");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Text("Student"),
                                            onTap: () {
                                              if (admList.length > 1) {
                                                checkUser().changeRole(
                                                    admList[index]['id'],
                                                    "Student");
                                                loadData();
                                              }
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                    onTap: () {
                                      print('tap');
                                    },
                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              })),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(2.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
              margin: EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(
                        vertical: 8, horizontal: 4),
                    height: 60,
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      indicatorPadding: EdgeInsets.all(2.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.deepOrange,
                      // automaticIndicatorColorAdjustment: true,
                      controller:  _mAcadController,
                      // enableFeedback: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      dividerHeight: 0.0,
                      tabs: [
                        Tab(
                          text: 'Department',
                          // child: Text('Department',style: TextStyle(fontSize: 12),),
                          // icon: Icon(Icons.home_work_outlined,
                          icon: Badge(
                            label: Text(depList.length.toString()),
                            child: Icon(Icons.home_work_outlined),
                          ),
                          iconMargin: EdgeInsets.all(6.0),
                        ),
                        Tab(
                          text: 'AC Year',
                          // icon: Icon(Icons.people_alt_outlined),
                          icon: Badge(
                            label: Text(lecList.length.toString()),
                            child: Icon(Icons.people_alt_outlined),
                          ),
                          iconMargin: EdgeInsets.all(6.0),
                        ),
                        Tab(
                          text: 'Students',
                          // icon: Icon(Icons.groups_outlined),
                          icon: Badge(
                            label: Text(usrList.length.toString()),
                            child: Icon(Icons.school_outlined),
                          ),
                          iconMargin: EdgeInsets.all(6.0),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TabBarView(
                      controller:  _mAcadController,
                      children: [
                        // Department Section
                        SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              addAutomaticKeepAlives: true,
                              itemCount: depList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: Icon(Icons.home_max_outlined),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    minLeadingWidth: 40,
                                    title: Text(depList[index]['id']),
                                    subtitle: Text(depList[index]['name']),
                                    selectedTileColor: Colors.cyanAccent,
                                    hoverColor: Colors.lightGreen,
                                    focusColor: Colors.redAccent,
                                    tileColor: Colors.teal,
                                    onTap: () {
                                      print('tap');
                                    },
                                    trailing: PopupMenuButton(
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Text("Delete"),
                                            onTap: () {
                                              print(depList[index]['id']);
                                              DataOrgManage().deleteDepartment(
                                                  depList[index]['id']);
                                              loadData();
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.more_vert),
                                    //   onPressed: () {  },
                                    //   style: ButtonStyle(),
                                    // ),

                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              }),
                        ),
                        // AC Years Section
                        SizedBox(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: lecList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            lecList[index]['imgUrl']),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      minLeadingWidth: 50,
                                      title: Text(lecList[index]['name']),
                                      subtitle: Text(lecList[index]['email']),
                                      selectedTileColor: Colors.cyanAccent,
                                      hoverColor: Colors.lightGreen,
                                      focusColor: Colors.redAccent,
                                      tileColor: Colors.teal,
                                      trailing: PopupMenuButton(
                                        icon: Chip(
                                          label: Text(
                                              lecList[index]['role'].toString()),
                                          padding: EdgeInsets.all(0),
                                          side: BorderSide.none,
                                        ),
                                        color: Colors.deepOrange,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: Text("Admin"),
                                              onTap: () {
                                                if (lecList.length > 1) {
                                                  print(lecList[index]['id']);
                                                  checkUser().changeRole(
                                                      lecList[index]['id'],
                                                      "Admin");
                                                  loadData();
                                                }
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: Text("Student"),
                                              onTap: () {
                                                if (lecList.length > 1) {
                                                  checkUser().changeRole(
                                                      lecList[index]['id'],
                                                      "Student");
                                                  loadData();
                                                }
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                                      onTap: () {
                                        print('tap');
                                        print(lecList.length);
                                      },
                                      horizontalTitleGap: 2.0,
                                    ),
                                  );
                                })),
                        // User Section
                        SizedBox(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: usrList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            usrList[index]['imgUrl']),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      minLeadingWidth: 40,
                                      title: Text(usrList[index]['name']),
                                      subtitle: Text(usrList[index]['email']),
                                      selectedTileColor: Colors.cyanAccent,
                                      hoverColor: Colors.lightGreen,
                                      focusColor: Colors.redAccent,
                                      tileColor: Colors.teal,
                                      trailing: PopupMenuButton(
                                        icon: Chip(
                                          label: Text(
                                              usrList[index]['role'].toString()),
                                          padding: EdgeInsets.all(0),
                                          side: BorderSide.none,
                                        ),
                                        color: Colors.deepOrange,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: Text("Lecture"),
                                              onTap: () {
                                                if (usrList.length > 1) {
                                                  checkUser().changeRole(
                                                      usrList[index]['id'],
                                                      "Lecture");
                                                  loadData();
                                                }
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: Text("Admin"),
                                              onTap: () {
                                                if (usrList.length > 1) {
                                                  checkUser().changeRole(
                                                      usrList[index]['id'],
                                                      "Admin");
                                                  loadData();
                                                }
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                                      onTap: () {
                                        print('tap');
                                      },
                                      horizontalTitleGap: 2.0,
                                    ),
                                  );
                                })),

                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: TabBarView(
                      controller: _mAcadController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent)),
                              onPressed: () {
                                print("xxxxxxxxxx");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddDepartmentDialog();
                                  },
                                ).then((value) {
                                  // This function will be called when the dialog is dismissed
                                  print("Dialog closed");
                                  // Call your function here
                                  loadData();
                                });
                              },
                              child: Icon(Icons.add_home_work_outlined),
                            ),
                            // ElevatedButton(
                            //     onPressed: () {}, child: Icon(Icons.highlight_remove_outlined)),
                          ],
                        ),
                        Text('Second'),
                        Text('Third'),
                      ],
                    ),
                  )
                ],
              )),
        ],
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

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Department added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print(e);
      }
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter valid department code and name'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        print(e);
      }
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
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Card(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100))),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 50.0,
                        //   backgroundImage: NetworkImage(imgUrl),
                        // ),
                        Chip(
                          padding: EdgeInsets.all(4),
                          side: BorderSide.none,
                          label: Text(role,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          backgroundColor: Color(0xFFFFDCDC),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                        ),
                        SizedBox(height: 26),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          email,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 42),
                        Text('Last Login:' + lastLog,
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 42),
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
                Positioned(
                  top: -55,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(imgUrl),
                      backgroundColor: Colors.transparent,
                      // child: ClipOval(child: Image.network(imgUrl)),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
