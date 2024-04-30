import 'package:classbuddy/operations/user_handler.dart';
import 'package:classbuddy/screens/common_components/chat_with_ai.dart';
import 'package:classbuddy/services/firebase_user_control.dart';
import 'package:flutter/material.dart';
import '../services/firebase_course_control.dart';
import '../services/firebase_department_control.dart';
import 'common_components/explo_carosel.dart';
import 'common_components/info_card.dart';
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
    AdminExplore(),
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

class AdminExplore extends StatefulWidget {
  const AdminExplore({super.key});

  @override
  State<AdminExplore> createState() => _AdminExploreState();
}

class _AdminExploreState extends State<AdminExplore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(flexibleSpace: SearchBarApp()),
          body: Column(
            children: [
              Flexible(child: Container(height: 300,
                  child: CustomCarouselFB2())),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InfoCard(title: 'New Course', onMoreTap: () {},),
              ),
            ],
          ),


        )
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              onSubmitted: (value) {
                print(value);
              },
              hintText: 'Search Course',
              backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              trailing: <Widget>[
                Tooltip(
                  message: 'Search Course',
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                )
              ],
            );
          }, suggestionsBuilder:
          (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      }),
    );


  }
}



