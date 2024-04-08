import 'package:classbuddy/services/auth.dart';
import 'package:flutter/material.dart';
import '../operations/lecture_course.dart';
import 'lec_dash_component/chat_ai/chatwithai.dart';
import 'lec_dash_component/manage_mycourse/firstyear.dart';
import 'lec_dash_component/profile_rawdata/profiledata.dart';

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
    MangeCourse(),
    ExploreLD(),
    AIChat(),
    LecturerProfile(),
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
          title: const Text('Hello Lecture'),
          backgroundColor: const Color(0xFFF9DEC9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          shadowColor: Colors.black,
          centerTitle: true,
          actions: [
            const Icon(Icons.notifications),
            Container(
              width: 20,
            )
          ]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFF9DEC9),
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        elevation: 0.0,
        indicatorColor: const Color(0xFFFF7575),
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

class ExploreLD extends StatefulWidget {
  const ExploreLD({super.key});

  @override
  State<ExploreLD> createState() => _ExploreLDState();
}

class _ExploreLDState extends State<ExploreLD> {
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
              margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFF9DEC9),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hello Lecture",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.notifications_active))
                ],
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        authMethods().userSignOut(context);
                      },
                      child: const Text('Press')),
                  ElevatedButton(
                      onPressed: () {
                        authMethods().getCurrentUser();
                      },
                      child: const Text('Get'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////// Manage Section ///////////////////////////

class MangeCourse extends StatefulWidget {
  const MangeCourse({super.key});

  @override
  State<MangeCourse> createState() => _MangeCourseState();
}

class _MangeCourseState extends State<MangeCourse>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> acYearList = [];
  int currentPageIndex = 0;

  List<Widget> _mcWidgetOptions = [];

  @override
  void initState() {
    super.initState();
    _mcWidgetOptions = [
      MenuCardsMC(
        onCardPressed: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      ACYFirst(
        onCardPressed: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      ACYSecond(
        onCardPressed: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      const Text('11Chat'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    TabController mCourController = TabController(
      length: 2,
      vsync: this,
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.lightGreen,
            ),
            child: TabBar(
              controller: mCourController,
              tabs: const [
                Tab(
                  text: 'My Course',
                ),
                Tab(
                  text: 'Division',
                )
              ],
            ),
          ),
          Flexible(
              child: TabBarView(
            controller: mCourController,
            children: [
              SizedBox(
                child: _mcWidgetOptions.elementAt(currentPageIndex),
              ),
              SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      const Text('division'),
                      ElevatedButton(
                          onPressed: () {
                            // AcademicOperation().getMyCourse();
                          },
                          child: const Text('press'))
                    ],
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class MenuCardsMC extends StatefulWidget {
  final Function(int) onCardPressed;

  const MenuCardsMC({Key? key, required this.onCardPressed}) : super(key: key);

  @override
  State<MenuCardsMC> createState() => _MenuCardsMCState();
}

class _MenuCardsMCState extends State<MenuCardsMC> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2, // Set the max width of a card to half the screen width
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1/1, // Adjust the aspect ratio of the cards as needed
            ),
            delegate: SliverChildListDelegate(
              [
                _buildCard('First Year', 1),
                _buildCard('Second Year', 2),
                _buildCard('Third Year', 3),
                _buildCard('Fourth Year', 4),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _orientationCard('Orientation ', 0),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String year, int index) {
    return Card(
      elevation: 10,
      surfaceTintColor: Colors.pink,
      clipBehavior: Clip.hardEdge,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: Center(
              child: Text(
                year,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                widget.onCardPressed(index); // Call the callback function
              },
              borderRadius: BorderRadius.circular(25),
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 60,
                color: Colors.greenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _orientationCard(String year, int index,) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 10,
        surfaceTintColor: Colors.pink,
        clipBehavior: Clip.hardEdge,
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  year,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  widget.onCardPressed(index); // Call the callback function
                },
                borderRadius: BorderRadius.circular(25),
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 60,
                  color: Colors.greenAccent,
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

}

///////////////////////////////////// End of Manage Section ////////////////////


////////////////////////////////// Sub parts ///////////////////////////////////

class ListMyCourse extends StatefulWidget {
  const ListMyCourse({super.key});

  @override
  State<ListMyCourse> createState() => _ListMyCourseState();
}

class _ListMyCourseState extends State<ListMyCourse> {
  // List<Map<String, dynamic>> acYearList = [];

  // void initState() {
  //   super.initState();
  //   loadData();
  // }
  //
  // loadData() async {
  //   // acYearList = await DataOrgManage().departmentList();
  //
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ACYSecond extends StatefulWidget {
  final Function(int) onCardPressed;

  const ACYSecond({Key? key, required this.onCardPressed}) : super(key: key);

  @override
  State<ACYSecond> createState() => _ACYSecondState();
}

class _ACYSecondState extends State<ACYSecond> {
  List<Map<String, dynamic>> acYearList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    acYearList = await AcademicOperation().getAcYears();
    acYearList.removeWhere((item) => item['currentYear'] < 2);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.black12),
      child: Column(
        children: [
          ExpansionPanelList.radio(
            animationDuration: const Duration(milliseconds: 800),
            expandedHeaderPadding: const EdgeInsets.all(10.0),
            initialOpenPanelValue: 1,
            children: acYearList.map((item) {
              return ExpansionPanelRadio(
                backgroundColor: Colors.lightBlue,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item['documentID']),
                  );
                },
                body: Container(
                  color: Colors.lightBlueAccent,
                  child: const Card(
                    child: Text('afsassas'),
                  ),
                  // Add any additional content you want to show when the panel is expanded
                  // This can be any widget or UI you want to display
                ),
                value: item['documentID'],
              );
            }).toList(),
            materialGapSize: 16,
          ),
          ElevatedButton(
              onPressed: () {
                widget.onCardPressed(0);
              },
              child: const Text('back'))
        ],
      ),
    );
  }
}
