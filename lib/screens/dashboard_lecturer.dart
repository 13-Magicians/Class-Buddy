import 'package:classbuddy/screens/common_components/chat_with_ai.dart';
import 'package:classbuddy/screens/dash_component_lecturer/manage_my_course/my_fourth_year.dart';
import 'package:classbuddy/services/firebase_authentication_control.dart';
import 'package:flutter/material.dart';
import 'dash_component_lecturer/all_courses/all_first_year.dart';
import 'dash_component_lecturer/all_courses/all_fourth_year.dart';
import 'dash_component_lecturer/all_courses/all_orientation.dart';
import 'dash_component_lecturer/all_courses/all_second_year.dart';
import 'dash_component_lecturer/all_courses/all_third_year.dart';
import 'dash_component_lecturer/manage_my_course/my_first_year.dart';
import 'dash_component_lecturer/manage_my_course/my_orientation.dart';
import 'dash_component_lecturer/manage_my_course/my_second_year.dart';
import 'dash_component_lecturer/manage_my_course/my_third_year.dart';
import 'dash_component_lecturer/profile_raw_data/profile_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
      appBar: AppBar(
          title: const Text('Hello Lecturer'),
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
                    "Hello Lecturer",
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
                        AuthMethods().userSignOut(context);
                      },
                      child: const Text('Press')),
                  ElevatedButton(
                      onPressed: () {
                        AuthMethods().getCurrentUser();
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
  int currentMCPageIndex = 0;
  int currentACPageIndex = 0;

  List<Widget> _mcWidgetOptions = [];
  List<Widget> _acWidgetOptions = [];

  @override
  void initState() {
    super.initState();
    print('initState called');
    _mcWidgetOptions = [
      MenuCardsMC(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
      ACYFirst(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
      ACYSecond(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
      ACYThird(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
      ACYFourth(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
      ACYPreO(
        onCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentMCPageIndex = index;
            });
          }
        },
      ),
    ];

    _acWidgetOptions = [
      MenuCardsAC(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
      AACYFirst(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
      AACYSecond(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
      AACYThird(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
      AACYFourth(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
      AACYPreO(
        onACCardPressed: (index) {
          if (mounted) {
            setState(() {
              currentACPageIndex = index;
            });
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    print('dispose called');
    super.dispose();
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
              color: Colors.redAccent,
            ),
            child: TabBar(
              controller: mCourController,
              tabs: const [
                Tab(
                  text: 'My Course',
                ),
                Tab(
                  text: 'All Course',
                )
              ],
            ),
          ),
          Flexible(
              child: TabBarView(
            controller: mCourController,
            children: [
              SizedBox(
                child: _mcWidgetOptions.elementAt(currentMCPageIndex),
              ),
              SizedBox(
                child: _acWidgetOptions.elementAt(currentACPageIndex),
    ),
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
            child: _orientationCard('Orientation ', 5),
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


class MenuCardsAC extends StatefulWidget {
  final Function(int) onACCardPressed;

  const MenuCardsAC({Key? key, required this.onACCardPressed}) : super(key: key);

  @override
  State<MenuCardsAC> createState() => _MenuCardsACState();
}

class _MenuCardsACState extends State<MenuCardsAC> {
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
            child: _orientationCard('Orientation ', 5),
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
                widget.onACCardPressed(index); // Call the callback function
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
                  widget.onACCardPressed(index); // Call the callback function
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



