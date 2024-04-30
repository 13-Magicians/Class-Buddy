import 'package:classbuddy/screens/common_components/chat_with_ai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'common_components/explo_carosel.dart';
import 'common_components/info_card.dart';
import 'dash_component_student/courses/course_section.dart';
import 'dash_component_student/profile_raw_data/profile_data.dart';


class StuDash extends StatefulWidget {
  const StuDash({super.key});

  @override
  State<StuDash> createState() => _StuDashState();
}

class _StuDashState extends State<StuDash> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  static const List<Widget> _widgetOptions = <Widget>[
    stuExplore(),
    CourseSection(),
    // Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    AIChat(),
    StudentProfile(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Hello Student'),
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
          ]),
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex)
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
              label: 'Courses',
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

class stuExplore extends StatefulWidget {
  const stuExplore({super.key});

  @override
  State<stuExplore> createState() => _stuExploreState();
}

class _stuExploreState extends State<stuExplore> {
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


