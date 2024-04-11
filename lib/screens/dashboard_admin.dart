import 'package:classbuddy/operations/user_handler.dart';
import 'package:classbuddy/screens/common_components/chat_with_ai.dart';
import 'package:classbuddy/services/firebase_user_control.dart';
import 'package:flutter/material.dart';
import '../services/firebase_course_control.dart';
import '../services/firebase_department_control.dart';
import 'dash_component_admin/manage_academic/section_academic.dart';
import 'dash_component_admin/manage_users/section_users.dart';
import 'dash_component_admin/profile_raw_data/profile_data.dart';



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
    AdminProfile(),
  ];



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
        TabController(length: 2, vsync: this);

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
        children: const [
          //Users Section
          UsersSection(),
          //Academic Section
          AcademicSection(),
        ],
      ),
    );
  }
}
