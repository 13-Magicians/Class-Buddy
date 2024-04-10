import 'package:classbuddy/operations/check_user.dart';
import 'package:classbuddy/operations/error_handler.dart';
import 'package:classbuddy/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../operations/lecturer_course.dart';
import '../services/firebase_course_data.dart';
import '../services/firebase_manage_department.dart';

import 'admin_dash_component/profile_raw_data/profile_data.dart';

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
    AMangeDep(),
    AIChat(),
    AProfile(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      appBar: AppBar(
        title: const Text('Hello Admin'),
        backgroundColor: const Color(0xFFF8CFAE),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        shadowColor: Colors.black,
        centerTitle: true,
        actions: [
          const Icon(Icons.notifications),
          Container(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFF9DEC9),
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        elevation: 0.0,
        indicatorColor: const Color(0xFFF78CA2),
        animationDuration: const Duration(milliseconds: 1000),
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
    );
  }
}

class AMangeDep extends StatefulWidget {
  const AMangeDep({super.key});

  @override
  State<AMangeDep> createState() => _AMangeDepState();
}

class _AMangeDepState extends State<AMangeDep> with TickerProviderStateMixin {
  List<Map<String, dynamic>> depList = [];
  List<Map<String, dynamic>> admList = [];
  List<Map<String, dynamic>> lecList = [];
  List<Map<String, dynamic>> usrList = [];
  List<Map<String, dynamic>> allUsrList = [];
  List<Map<String, dynamic>> acYearList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    depList = await DataOrgManage().departmentList();
    lecList = await CheckUser().retLecUserList();
    admList = await DatabaseMethods().getAdminsOnly();
    usrList = await DatabaseMethods().getStudentsOnly();
    allUsrList = await DatabaseMethods().getAllUsers();
    acYearList = await DbCourseMethods().getAllCourse();

    setState(() {});
  }

  var userData = 'User';
  var items = List<String>.generate(10, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    TabController mainPageDivController =
        TabController(length: 2, vsync: this,);
    TabController mOrgController = TabController(length: 4, vsync: this);
    TabController mAcidController =
        TabController(length: 3, vsync: this,);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TabBar(controller: mainPageDivController, tabs: const [
        Tab(
          text: 'Users',
        ),
        Tab(
          text: 'Academic',
        )
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: mainPageDivController,
        children: [
          //Users Section
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
            margin: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(
                      vertical: 8, horizontal: 4),
                  height: 60,
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    indicatorPadding: const EdgeInsets.all(2.0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.deepOrange,
                    // automaticIndicatorColorAdjustment: true,
                    controller: mOrgController,
                    // enableFeedback: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    dividerHeight: 0.0,
                    tabs: [
                      Tab(
                        text: 'All Users',
                        // child: Text('Department',style: TextStyle(fontSize: 12),),
                        // icon: Icon(Icons.home_work_outlined,
                        icon: Badge(
                          label: Text(allUsrList.length.toString()),
                          child: const Icon(Icons.groups_rounded),
                        ),
                        iconMargin: const EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Lecturers',
                        // icon: Icon(Icons.people_alt_outlined),
                        icon: Badge(
                          label: Text(lecList.length.toString()),
                          child: const Icon(Icons.people_alt_outlined),
                        ),
                        iconMargin: const EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Students',
                        // icon: Icon(Icons.groups_outlined),
                        icon: Badge(
                          label: Text(usrList.length.toString()),
                          child: const Icon(Icons.school_outlined),
                        ),
                        iconMargin: const EdgeInsets.all(6.0),
                      ),
                      Tab(
                        text: 'Admins',
                        // icon: Icon(Icons.admin_panel_settings_outlined),
                        icon: Badge(
                          label: Text(admList.length.toString()),
                          child: const Icon(Icons.admin_panel_settings_outlined),
                        ),
                        iconMargin: const EdgeInsets.all(6.0),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: TabBarView(
                    controller: mOrgController,
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
                                        const EdgeInsets.symmetric(horizontal: 18),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          allUsrList[index]['imgUrl']),
                                    ),
                                    shape: const RoundedRectangleBorder(
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
                                      padding: const EdgeInsets.all(0),
                                      side: BorderSide.none,
                                    ),
                                    onTap: () {
                                    },
                                    horizontalTitleGap: 2.0,
                                  ),
                                );
                              })),
                      // Lecturer Section
                      SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: lecList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 8),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          lecList[index]['imgUrl']),
                                    ),
                                    shape: const RoundedRectangleBorder(
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
                                        padding: const EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Admin"),
                                            onTap: () {
                                              if (lecList.length > 1) {
                                                CheckUser().changeRole(
                                                    lecList[index]['id'],
                                                    "Admin");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: const Text("Student"),
                                            onTap: () {
                                              if (lecList.length > 1) {
                                                CheckUser().changeRole(
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
                                    shape: const RoundedRectangleBorder(
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
                                        padding: const EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Lecturer"),
                                            onTap: () {
                                              if (usrList.length > 1) {
                                                CheckUser().changeRole(
                                                    usrList[index]['id'],
                                                    "Lecturer");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: const Text("Admin"),
                                            onTap: () {
                                              if (usrList.length > 1) {
                                                CheckUser().changeRole(
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
                                    shape: const RoundedRectangleBorder(
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
                                        padding: const EdgeInsets.all(0),
                                        side: BorderSide.none,
                                      ),
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Lecturer"),
                                            onTap: () {
                                              if (admList.length > 1) {
                                                CheckUser().changeRole(
                                                    admList[index]['id'],
                                                    "Lecturer");
                                                loadData();
                                              }
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: const Text("Student"),
                                            onTap: () {
                                              if (admList.length > 1) {
                                                CheckUser().changeRole(
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
          //Academic Section
          Container(
              padding: const EdgeInsets.all(2.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
              margin: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.symmetric(
                        vertical: 8, horizontal: 4),
                    height: 60,
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      indicatorPadding: const EdgeInsets.all(2.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.deepOrange,
                      // automaticIndicatorColorAdjustment: true,
                      controller: mAcidController,
                      // enableFeedback: true,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      dividerHeight: 0.0,
                      tabs: [
                        Tab(
                          text: 'Department',
                          // child: Text('Department',style: TextStyle(fontSize: 12),),
                          // icon: Icon(Icons.home_work_outlined,
                          icon: Badge(
                            label: Text(depList.length.toString()),
                            child: const Icon(Icons.home_work_outlined),
                          ),
                          iconMargin: const EdgeInsets.all(6.0),
                        ),
                        Tab(
                          text: 'Batch Year',
                          // icon: Icon(Icons.people_alt_outlined),
                          icon: Badge(
                            label: Text(acYearList.length.toString()),
                            child: const Icon(Icons.data_thresholding_outlined),
                          ),
                          iconMargin: const EdgeInsets.all(6.0),
                        ),
                        Tab(
                          text: 'Students',
                          // icon: Icon(Icons.groups_outlined),
                          icon: Badge(
                            label: Text(usrList.length.toString()),
                            child: const Icon(Icons.school_outlined),
                          ),
                          iconMargin: const EdgeInsets.all(6.0),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TabBarView(
                      controller: mAcidController,
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
                                    leading: const Icon(Icons.home_max_outlined),
                                    shape: const RoundedRectangleBorder(
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
                                    },
                                    trailing: PopupMenuButton(
                                      color: Colors.deepOrange,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: const Text("Delete"),
                                            onTap: () {
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
                                itemCount: acYearList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 8),
                                      leading:
                                          const Icon(Icons.data_exploration_outlined),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      minLeadingWidth: 50,
                                      title:
                                          Text(acYearList[index]['documentId']),
                                      // subtitle: Text(lecList[index]['email']),
                                      selectedTileColor: Colors.cyanAccent,
                                      hoverColor: Colors.lightGreen,
                                      focusColor: Colors.redAccent,
                                      tileColor: Colors.teal,
                                      trailing: PopupMenuButton(
                                        color: Colors.deepOrange,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: const Text("Delete"),
                                              onTap: () {
                                                if (acYearList.length > 1) {
                                                  DbCourseMethods()
                                                      .deleteAcademicYear(
                                                          acYearList[index]
                                                              ['documentId']);
                                                  loadData();
                                                } else {}
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                                      onTap: () {
                                        AcademicOperation().getAcYears();
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
                                      shape: const RoundedRectangleBorder(
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
                                          label: Text(usrList[index]['role']
                                              .toString()),
                                          padding: const EdgeInsets.all(0),
                                          side: BorderSide.none,
                                        ),
                                        color: Colors.deepOrange,
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: const Text("Lecturer"),
                                              onTap: () {
                                                if (usrList.length > 1) {
                                                  CheckUser().changeRole(
                                                      usrList[index]['id'],
                                                      "Lecturer");
                                                  loadData();
                                                }
                                              },
                                            ),
                                            PopupMenuItem(
                                              child: const Text("Admin"),
                                              onTap: () {
                                                if (usrList.length > 1) {
                                                  CheckUser().changeRole(
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
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: TabBarView(
                      controller: mAcidController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddDepartmentDialog();
                                  },
                                ).then((value) {
                                  // This function will be called when the dialog is dismissed
                                  loadData();
                                });
                              },
                              child: const Icon(Icons.add_home_work_outlined),
                            ),
                            // ElevatedButton(
                            //     onPressed: () {}, child: Icon(Icons.highlight_remove_outlined)),
                          ],
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.greenAccent)
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddAcademicYear();
                                  },
                                ).then((value) {
                                  loadData();
                                });
                              },
                              child: const Icon(Icons.data_saver_on_outlined),
                            ),
                            // ElevatedButton(
                            //     onPressed: () {}, child: Icon(Icons.highlight_remove_outlined)),
                          ],
                        ),
                        const Text('Third'),
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
  const AddDepartmentDialog({super.key});

  @override
  State<AddDepartmentDialog> createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {
  final TextEditingController fcCode = TextEditingController();
  final TextEditingController fcName = TextEditingController();

  Future<void> btnOk(context) async {
    if (fcCode.text.isNotEmpty && fcName.text.isNotEmpty) {
      await DataOrgManage().createDepartment(fcName.text, fcCode.text);

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Department added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid department code and name'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Department'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: fcCode,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Dep code (eg:ICT,EET,BPT)'),
          ),
          TextField(
            controller: fcName,
            decoration: const InputDecoration(hintText: 'Department name'),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              btnOk(context);
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class AddAcademicYear extends StatefulWidget {
  const AddAcademicYear({super.key});

  @override
  State<AddAcademicYear> createState() => _AddAcademicYearState();
}

class _AddAcademicYearState extends State<AddAcademicYear> {
  final TextEditingController acYearName = TextEditingController();
  int? _selectedValue;

  Future<void> ayBtnOk(context) async {
    if (acYearName.text.isNotEmpty || _selectedValue != null) {
      await DbCourseMethods().createAcademicYear(acYearName.text, _selectedValue!);

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Academic Year added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid Academic Year name and no'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Batch'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: acYearName,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Batch Name Ex: 18-19-Batch'),
          ),
          const SizedBox(height: 30,),
          const Text(
            'Select Academic Year:',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Radio<int>(
                value: 0,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              const Text('Pre'),
            ],
          ),
          Row(
            children: [
              for (int i = 1; i <= 4; i++)
                Row(
                  children: [
                    Radio<int>(
                      value: i,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                    Text(i.toString()),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              ayBtnOk(context);
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();
  final apiKey = 'AIzaSyCA8yMLvIrsmQDJSJiffuO-MpQr0UZhkas';

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Chat :Powered by Generative AI'),
      ),
      body: Card(
        elevation: 6,
        color: Colors.orangeAccent.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _chatSession.history.length,
                    itemBuilder: (context, index) {
                      final Content content =
                          _chatSession.history.toList()[index];
                      final text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageSet(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        focusNode: _textFieldFocus,
                        decoration: textFieldDecoration(),
                        controller: _textController,
                        onSubmitted: _sendChatMessage,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      onPressed: _loading
                          ? null
                          : () => _sendChatMessage(_textController.text),
                      icon: _loading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.send),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Say Something...!',
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No response from AI...!');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 750), curve: Curves.easeOutCirc));
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Something went wrong...!'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}

class MessageSet extends StatelessWidget {
  const MessageSet({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: const EdgeInsets.only(bottom: 8),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Colors.deepOrangeAccent.shade200
                  : Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                MarkdownBody(
                  data: text,
                  selectable: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}



