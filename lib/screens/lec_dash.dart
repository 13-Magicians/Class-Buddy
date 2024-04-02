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
    mangeCourse(),
    Explore_LD(),
    AIChat(),
    lProfile(),
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
          title: Text('Hello Lecture'),
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
      bottomNavigationBar: Container(
        child: NavigationBar(
          backgroundColor: Color(0xFFF9DEC9),
          labelBehavior: labelBehavior,
          selectedIndex: currentPageIndex,
          elevation: 0.0,
          indicatorColor: Color(0xFFFF7575),
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

class Explore_LD extends StatefulWidget {
  const Explore_LD({super.key});

  @override
  State<Explore_LD> createState() => _Explore_LDState();
}

class _Explore_LDState extends State<Explore_LD> {
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
                    "Hello Lecture",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.notifications_active))
                ],
              ),
            ),
            Container(
              height: 200.0,
              child: ListView(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        authMethods().userSignOut(context);
                      },
                      child: Text('Press')),
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

///////////////////////////////////// Manage Section ///////////////////////////

class mangeCourse extends StatefulWidget {
  const mangeCourse({super.key});

  @override
  State<mangeCourse> createState() => _mangeCourseState();
}

class _mangeCourseState extends State<mangeCourse>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> acYearList = [];
  int currentPageIndex = 0;

  List<Widget> _mcwidgetOptions = [];

  @override
  void initState() {
    super.initState();
    _mcwidgetOptions = [
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
      Text('11Chat'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    TabController _mCourController = TabController(
      length: 2,
      vsync: this,
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.lightGreen,
            ),
            child: TabBar(
              controller: _mCourController,
              tabs: [
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
            controller: _mCourController,
            children: [
              SizedBox(
                child: _mcwidgetOptions.elementAt(currentPageIndex),
              ),
              SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      Text('division'),
                      ElevatedButton(
                          onPressed: () {
                            // AcademicOperation().getMyCourse();
                          },
                          child: Text('press'))
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
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        _buildCard('First Year', 1),
        _buildCard('Second Year', 2),
        _buildCard('Third Year', 3),
        _buildCard('Fourth Year', 4),
      ],
    );
  }

  Widget _buildCard(String year, int index) {
    return Container(
      child: Card(
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  widget.onCardPressed(index); // Call the callback function
                  print(index);
                },
                borderRadius: BorderRadius.circular(25),
                child: Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 60,
                  color: Colors.greenAccent,
                ),
              ),
            ),
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

/////////////////////////////  My Course Sub Parts  //////////////////////////



// class ACYFirst extends StatefulWidget {
//   final Function(int) onCardPressed;
//
//   const ACYFirst({Key? key, required this.onCardPressed}) : super(key: key);
//
//   @override
//   State<ACYFirst> createState() => _ACYFirstState();
// }
//
// class _ACYFirstState extends State<ACYFirst> {
//   List<Map<String, dynamic>> acYearList = [];
//   List<Map<String, dynamic>> acYCourseListF = [];
//   List<Map<String, dynamic>> acYCourseListS = [];
//
//   List<TextEditingController> controllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   loadData() async {
//     acYearList = await AcademicOperation().getAcYears();
//     acYearList.removeWhere((item) => item['currentYear'] < 1);
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(
//           decelerationRate: ScrollDecelerationRate.normal),
//       child: Container(
//         margin: EdgeInsets.all(2),
//         padding: EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(6)),
//         ),
//         child: Column(
//           children: [
//             ListTile(title: Text('First Year First Semester'),tileColor: Colors.lightBlueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
//             Divider(height: 10,indent: 50,endIndent: 50,thickness: 2,),
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               child: ExpansionPanelList.radio(
//                 animationDuration: Duration(milliseconds: 800),
//                 expandedHeaderPadding: EdgeInsets.all(8.0),
//                 initialOpenPanelValue: 1,
//                 children: acYearList.map((item) {
//                   return ExpansionPanelRadio(
//                     backgroundColor: Colors.cyan.shade400,
//                     canTapOnHeader: true,
//                     headerBuilder: (BuildContext context, bool isExpanded) {
//                       return Container(
//                         padding: EdgeInsets.all(6),
//                         child: ListTile(
//                           leading: Icon(Icons.collections_bookmark_outlined),
//                           tileColor: Colors.cyanAccent.shade400,
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                           title: Text(item['documentID']),
//                         ),
//                       );
//                     },
//                     body: Container(
//                       child: SizedBox(
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 300,
//                               height: 50,
//                               child: Card(
//                                 child: InkWell(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Icon(Icons.add_task_outlined),
//                                       Text('Add Course')
//                                     ],
//                                   ),
//                                   splashColor: Colors.deepOrange,
//                                   onTap: () {
//                                     print(item);
//                                     _makeCourse(context, item, '11');
//                                   },
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: FutureBuilder<List<Map<String, dynamic>>>(
//                                 future: AcademicOperation()
//                                     .getMyCourse(item['documentID'],'11'),
//                                 builder: (context,
//                                     AsyncSnapshot<List<Map<String, dynamic>>>
//                                         snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return CircularProgressIndicator();
//                                   } else {
//                                     if (snapshot.hasError) {
//                                       return Text('Error: ${snapshot.error}');
//                                     } else {
//                                       if (snapshot.data == null ||
//                                           snapshot.data!.isEmpty) {
//                                         return ListTile(
//                                           title: Text('Nothing found'),
//                                         );
//                                       } else {
//                                         return ListView.builder(
//                                           padding: EdgeInsets.all(4),
//                                           physics:
//                                               NeverScrollableScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: snapshot.data!.length,
//                                           itemBuilder: (context, index) {
//                                             final courseData =
//                                                 snapshot.data![index];
//                                             final courseName =
//                                                 courseData['id'] as String?;
//                                             return Card(
//                                               child: ListTile(
//                                                 title: Text(
//                                                     courseName ?? 'Unknown'),
//                                                 trailing: PopupMenuButton(
//                                                   color: Colors.cyan,
//                                                   elevation: 10,
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               25)),
//                                                   popUpAnimationStyle:
//                                                       AnimationStyle(
//                                                           curve:
//                                                               Curves.easeInOut,
//                                                           duration: Duration(
//                                                               milliseconds:
//                                                                   600)),
//                                                   itemBuilder: (context) {
//                                                     return [
//                                                       PopupMenuItem(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 30),
//                                                         child: Text('Delete'),
//                                                         onTap: () {
//                                                           deleteConfirmDialog(
//                                                               context,
//                                                               item[
//                                                                   'documentID'],
//                                                               courseData['id'],'11');
//                                                           print('ssss');
//                                                         },
//                                                       ),
//                                                     ];
//                                                   },
//                                                 ),
//                                                 leading: Icon(
//                                                     Icons.cyclone_outlined),
//                                                 subtitle: Row(
//                                                   children: [
//                                                     Text(courseData[
//                                                             'subjectName']
//                                                         .toString()),
//                                                   ],
//                                                 ),
//                                                 onTap: () {
//                                                   print('tap  $courseName');
//                                                   courseInside(
//                                                       context,
//                                                       item['documentID'],
//                                                       courseData);
//                                                 },
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }
//                                   }
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     value: item['documentID'],
//                   );
//                 }).toList(),
//                 materialGapSize: 16,
//                 elevation: 8,
//               ),
//             ),
//             SizedBox(height: 12,),
//             Column(
//               children: [
//                 ListTile(title: Text('First Year Second Semester'),tileColor: Colors.lightBlueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
//                 Divider(height: 10,indent: 50,endIndent: 50,thickness: 2,),
//                 ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   child: ExpansionPanelList.radio(
//                     animationDuration: Duration(milliseconds: 800),
//                     expandedHeaderPadding: EdgeInsets.all(8.0),
//                     initialOpenPanelValue: 1,
//                     children: acYearList.map((item) {
//                       return ExpansionPanelRadio(
//                         backgroundColor: Colors.cyan.shade400,
//                         canTapOnHeader: true,
//                         headerBuilder: (BuildContext context, bool isExpanded) {
//                           return Container(
//                             padding: EdgeInsets.all(6),
//                             child: ListTile(
//                               leading: Icon(Icons.collections_bookmark_outlined),
//                               tileColor: Colors.cyanAccent.shade400,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                               title: Text(item['documentID']),
//                             ),
//                           );
//                         },
//                         body: Container(
//                           child: SizedBox(
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 300,
//                                   height: 50,
//                                   child: Card(
//                                     child: InkWell(
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Icon(Icons.add_task_outlined),
//                                           Text('Add Course')
//                                         ],
//                                       ),
//                                       splashColor: Colors.deepOrange,
//                                       onTap: () {
//                                         print(item);
//                                         _makeCourse(context, item, '12');
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: FutureBuilder<List<Map<String, dynamic>>>(
//                                     future: AcademicOperation()
//                                         .getMyCourse(item['documentID'],'12'),
//                                     builder: (context,
//                                         AsyncSnapshot<List<Map<String, dynamic>>>
//                                         snapshot) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         return CircularProgressIndicator();
//                                       } else {
//                                         if (snapshot.hasError) {
//                                           return Text('Error: ${snapshot.error}');
//                                         } else {
//                                           if (snapshot.data == null ||
//                                               snapshot.data!.isEmpty) {
//                                             return ListTile(
//                                               title: Text('Nothing found'),
//                                             );
//                                           } else {
//                                             return ListView.builder(
//                                               padding: EdgeInsets.all(4),
//                                               physics:
//                                               NeverScrollableScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: snapshot.data!.length,
//                                               itemBuilder: (context, index) {
//                                                 final courseData =
//                                                 snapshot.data![index];
//                                                 final courseName =
//                                                 courseData['id'] as String?;
//                                                 return Card(
//                                                   child: ListTile(
//                                                     title: Text(
//                                                         courseName ?? 'Unknown'),
//                                                     trailing: PopupMenuButton(
//                                                       color: Colors.cyan,
//                                                       elevation: 10,
//                                                       shape: RoundedRectangleBorder(
//                                                           borderRadius:
//                                                           BorderRadius.circular(
//                                                               25)),
//                                                       popUpAnimationStyle:
//                                                       AnimationStyle(
//                                                           curve:
//                                                           Curves.easeInOut,
//                                                           duration: Duration(
//                                                               milliseconds:
//                                                               600)),
//                                                       itemBuilder: (context) {
//                                                         return [
//                                                           PopupMenuItem(
//                                                             padding:
//                                                             EdgeInsets.only(
//                                                                 left: 30),
//                                                             child: Text('Delete'),
//                                                             onTap: () {
//                                                               deleteConfirmDialog(
//                                                                   context,
//                                                                   item[
//                                                                   'documentID'],
//                                                                   courseData['id'],'12');
//                                                               print('ssss');
//                                                             },
//                                                           ),
//                                                         ];
//                                                       },
//                                                     ),
//                                                     leading: Icon(
//                                                         Icons.cyclone_outlined),
//                                                     subtitle: Row(
//                                                       children: [
//                                                         Text(courseData[
//                                                         'subjectName']
//                                                             .toString()),
//                                                       ],
//                                                     ),
//                                                     onTap: () {
//                                                       print('tap  $courseName');
//                                                       courseInside(
//                                                           context,
//                                                           item['documentID'],
//                                                           courseData);
//                                                     },
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         value: item['documentID'],
//                       );
//                     }).toList(),
//                     materialGapSize: 16,
//                     elevation: 8,
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   widget.onCardPressed(0);
//                 },
//                 child: Text('back'))
//           ],
//         ),
//       ),
//     );
//   }
//
//   void courseInside(
//       BuildContext context, String item, Map<String, dynamic> courseData) {
//     print(item);
//     Navigator.of(context).push(MaterialPageRoute<void>(
//       fullscreenDialog: true,
//       builder: (BuildContext context) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.deepOrangeAccent.shade100,
//             title: Row(
//               children: [
//                 Text(courseData['id']),
//                 Text(' - '),
//                 Text(courseData['subjectName'])
//               ],
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_rounded),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//           body: Card(
//             surfaceTintColor: Colors.deepOrange,
//             margin: const EdgeInsets.all(10),
//             elevation: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Chip(
//                         label: Text(item),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Chip(
//                         label: Text(courseData['department']),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Chip(
//                         label: SelectableText("Pass Code : ${courseData['passCode']}"),
//                       ),
//                     ],
//                   ),
//                   Text('Course content'),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: FloatingActionButton(
//               backgroundColor: Colors.deepOrangeAccent.shade100,
//               child: Icon(Icons.display_settings_rounded),
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (context) {
//                     return Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Container(
//                         height: 400,
//                         width: double.maxFinite,
//                         child: Column(
//                           children: [
//                             Text(
//                               "Change Course Content",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.add),
//                               title: Text('Add Topics'),
//                               contentPadding:
//                                   EdgeInsets.symmetric(horizontal: 20),
//                               tileColor: Colors.deepOrangeAccent.shade100,
//                               onTap: () {
//                                 _showAddLinkDialog(item, courseData);
//                               },
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                             Divider(
//                               height: 12,
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.add),
//                               title: Text('Add Assignment'),
//                               contentPadding:
//                                   EdgeInsets.symmetric(horizontal: 20),
//                               tileColor: Colors.deepOrangeAccent.shade100,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     ));
//   }
//
//   Future<void> _showAddLinkDialog(item, courseData) async {
//     List<Map<String, dynamic>> subjectTopic = [];
//     String topicName = '';
//     String videoLink = '';
//     String documentLink = '';
//     String topicNote = '';
//
//     bool addLink = true;
//
//     while (addLink) {
//       final result = await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           title: Text('Add Topic'),
//           scrollable: true,
//           contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
//           content: Column(
//             // mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Topic Name',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
//                 onChanged: (value) => topicName = value,
//               ),
//               SizedBox(height: 8,),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Video Link (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
//                 onChanged: (value) => videoLink = value,
//               ),
//               SizedBox(height: 8,),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Document Link (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
//                 onChanged: (value) => documentLink = value,
//               ),
//               SizedBox(height: 8,),
//               TextField(
//                 maxLines: 3,
//                 decoration: InputDecoration(labelText: 'Topic Note (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
//                 onChanged: (value) => topicNote = value,
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // Return false to indicate cancellation
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (topicName.isNotEmpty) {
//                   // Set default values "none" for optional fields if empty
//                   if (videoLink.isEmpty) {
//                     videoLink = 'none';
//                   }
//                   if (documentLink.isEmpty) {
//                     documentLink = 'none';
//                   }
//                   if (topicNote.isEmpty) {
//                     topicNote = 'none';
//                   }
//                   // Add link to the list and return true to indicate successful addition
//                   Map<String, dynamic> subjectTopicData = {
//                     'topicName': topicName,
//                     'videoLink': videoLink,
//                     'documentLink': documentLink,
//                     'topicNote': topicNote,
//                   };
//                   subjectTopic.add(subjectTopicData);
//
//
//                   AcademicOperation().addTopic(item, courseData, subjectTopic);
//                   Navigator.of(context).pop(false);
//                 } else {
//                   // Show error message if topic name is empty
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Error'),
//                       content: Text('Please enter a topic name.'),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the error dialog
//                           },
//                           child: Text('OK'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         ),
//       );
//
//       if (result == true) {
//         // User successfully added a link
//         setState(() {
//           // Reset fields for next link
//           topicName = '';
//           videoLink = '';
//           documentLink = '';
//           topicNote = '';
//         });
//       } else {
//         // If the dialog is canceled or if the last link is empty, exit the loop
//         addLink = false;
//       }
//     }
//   }
//
//
//
//
//
//
//
//
//
//   Future<void> btnDelete(item, courseData, String semNo) async {
//     await DbCourseMethods().deleteCourse(item, courseData, semNo);
//     loadData();
//   }
//
//   Future deleteConfirmDialog(BuildContext context, item, courseData, String semNo) async {
//     return showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button for close dialog!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.deepOrangeAccent.shade100,
//           title: Text('Delete This Course?'),
//           content: const Text(
//               'This will delete the Course and it can not be recover.'),
//           actions: [
//             ElevatedButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 btnDelete(item, courseData, semNo);
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   void _makeCourse(BuildContext context, Map<String, dynamic> item, String semNo) {
//     final _formKey = GlobalKey<FormState>(); // Add a global key for the form
//     String?
//         _selectedDepartment; // Add a variable to store the selected department
//     TextEditingController _subjectNameController = TextEditingController();
//     TextEditingController _courseCodeController = TextEditingController();
//     TextEditingController _passCodeController = TextEditingController();
//
//     Navigator.of(context).push(MaterialPageRoute<void>(
//       fullscreenDialog: true,
//       builder: (BuildContext context) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.deepOrangeAccent,
//             title: const Text('Add New Course'),
//             leading: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Card(
//               surfaceTintColor: Colors.deepOrange,
//               margin: const EdgeInsets.all(10),
//               elevation: 10,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
//                 child: Form(
//                   key: _formKey, // Assign the key to the form
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextFormField(
//                         controller: _subjectNameController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           labelText: 'Subject Name',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a subject name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         controller: _courseCodeController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           labelText: 'Course Code',
//                           hintText: 'eg: ICT-1305',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a course code';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       FutureBuilder<List<String>>(
//                         future: _getCourseOptions(), // Replace with your API call
//                         builder: (BuildContext context,
//                             AsyncSnapshot<List<String>> snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const CircularProgressIndicator();
//                           } else if (snapshot.hasError) {
//                             return Text('Error: ${snapshot.error}');
//                           } else {
//                             return DropdownButtonFormField(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 labelText: 'Select Department',
//                               ),
//                               value: _selectedDepartment,
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please select a department';
//                                 }
//                                 return null;
//                               },
//                               items: snapshot.data!.map((String option) {
//                                 return DropdownMenuItem(
//                                   value: option,
//                                   child: Text(option),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   _selectedDepartment = value;
//                                 });
//                               },
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       TextFormField(
//                         controller: _passCodeController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           labelText: 'Pass Code',
//                           hintText: 'eg: abc123',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty || value.length < 4) {
//                             return 'Please enter a valid pass code';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       ElevatedButton(
//                         style: const ButtonStyle(
//                           shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
//                           backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent),
//                           elevation: MaterialStatePropertyAll(4),
//                         ),
//                         onPressed: () {
//                           // Validate the form before submission
//                           if (_formKey.currentState!.validate()) {
//                             // Handle form submission here
//                             AcademicOperation().addCourseACY(
//                                 item['documentID'],
//                                 _subjectNameController.text,
//                                 _courseCodeController.text,
//                                 _selectedDepartment.toString(),
//                                 _passCodeController.text,
//                                 semNo,
//                             );
//                             loadData();
//                             Navigator.of(context).pop();
//                           }
//                         },
//                         child: const Text('Submit',style: TextStyle(color: Colors.black87),),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }
//
// Future<List<String>> _getCourseOptions() async {
//   List<Map<String, dynamic>> departmentList =
//       await DataOrgManage().departmentList();
//   List<String> courseOptions =
//       departmentList.map((department) => department['id'].toString()).toList();
//   return courseOptions;
// }

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
