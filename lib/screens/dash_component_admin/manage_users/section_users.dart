import 'package:flutter/material.dart';
import '../../../operations/user_handler.dart';
import '../../../services/firebase_user_control.dart';

class UsersSection extends StatefulWidget {
  const UsersSection({super.key});

  @override
  State<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends State<UsersSection>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> admList = [];
  List<Map<String, dynamic>> lecList = [];
  List<Map<String, dynamic>> stuList = [];
  List<Map<String, dynamic>> allUsrList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    lecList = await CheckUser().userListByRoles('Lecturer');
    admList = await CheckUser().userListByRoles('Admin');
    stuList = await CheckUser().userListByRoles('Student');
    allUsrList = await DatabaseMethods().getAllUsers();
    setState(() {});
  }

  @override
  Future<void> dispose() async => super.dispose();

  @override
  Widget build(BuildContext context) {
    TabController mOrgController = TabController(length: 4, vsync: this);
    return Container(
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
              controller: mOrgController,
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
                    label: Text(stuList.length.toString()),
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
                                backgroundImage:
                                    NetworkImage(allUsrList[index]['imgUrl']),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              minLeadingWidth: 50,
                              title: Text(allUsrList[index]['name']),
                              subtitle: Text(allUsrList[index]['email']),
                              selectedTileColor: Colors.cyanAccent,
                              hoverColor: Colors.lightGreen,
                              focusColor: Colors.redAccent,
                              tileColor: Colors.teal,
                              trailing: Chip(
                                label:
                                    Text(allUsrList[index]['role'].toString()),
                                padding: const EdgeInsets.all(0),
                                side: BorderSide.none,
                              ),
                              onTap: () {},
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
                                backgroundImage:
                                    NetworkImage(lecList[index]['imgUrl']),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              minLeadingWidth: 50,
                              title: Text(lecList[index]['name']),
                              subtitle: Text(lecList[index]['email']),
                              selectedTileColor: Colors.cyanAccent,
                              hoverColor: Colors.lightGreen,
                              focusColor: Colors.redAccent,
                              tileColor: Colors.teal,
                              trailing: PopupMenuButton(
                                icon: Chip(
                                  label:
                                      Text(lecList[index]['role'].toString()),
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
                                              lecList[index]['id'], "Admin");
                                          loadData();
                                        }
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Student"),
                                      onTap: () {
                                        if (lecList.length > 1) {
                                          CheckUser().changeRole(
                                              lecList[index]['id'], "Student");
                                          loadData();
                                        }
                                      },
                                    ),
                                  ];
                                },
                              ),
                              onTap: () {},
                              horizontalTitleGap: 2.0,
                            ),
                          );
                        })),
                // User Section
                SizedBox(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: stuList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(stuList[index]['imgUrl']),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              minLeadingWidth: 50,
                              title: Text(stuList[index]['name']),
                              subtitle: Text(stuList[index]['email']),
                              selectedTileColor: Colors.cyanAccent,
                              hoverColor: Colors.lightGreen,
                              focusColor: Colors.redAccent,
                              tileColor: Colors.teal,
                              trailing: PopupMenuButton(
                                icon: Chip(
                                  label:
                                      Text(stuList[index]['role'].toString()),
                                  padding: const EdgeInsets.all(0),
                                  side: BorderSide.none,
                                ),
                                color: Colors.deepOrange,
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: const Text("Lecturer"),
                                      onTap: () {
                                        if (stuList.length > 1) {
                                          CheckUser().changeRole(
                                              stuList[index]['id'], "Lecturer");
                                          loadData();
                                        }
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Admin"),
                                      onTap: () {
                                        if (stuList.length > 1) {
                                          CheckUser().changeRole(
                                              stuList[index]['id'], "Admin");
                                          loadData();
                                        }
                                      },
                                    ),
                                  ];
                                },
                              ),
                              onTap: () {},
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(admList[index]['imgUrl']),
                              ),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              minLeadingWidth: 50,
                              title: Text(admList[index]['name']),
                              subtitle: Text(admList[index]['email']),
                              selectedTileColor: Colors.cyanAccent,
                              hoverColor: Colors.lightGreen,
                              focusColor: Colors.redAccent,
                              tileColor: Colors.teal,
                              trailing: PopupMenuButton(
                                icon: Chip(
                                  label:
                                      Text(admList[index]['role'].toString()),
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
                                              admList[index]['id'], "Lecturer");
                                          loadData();
                                        }
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: const Text("Student"),
                                      onTap: () {
                                        if (admList.length > 1) {
                                          CheckUser().changeRole(
                                              admList[index]['id'], "Student");
                                          loadData();
                                        }
                                      },
                                    ),
                                  ];
                                },
                              ),
                              onTap: () {},
                              horizontalTitleGap: 2.0,
                            ),
                          );
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
