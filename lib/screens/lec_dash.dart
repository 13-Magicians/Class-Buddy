import 'package:classbuddy/services/auth.dart';
import 'package:classbuddy/services/fireCourseData.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../operations/lectureCourse.dart';
import '../services/fireDatabase.dart';
import '../services/fireManageDep.dart';

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
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
    // loadData();
  }

  // loadData() async {
  //   acYearList = await AcademicOperation().getAcYears();
  //   print(acYearList);
  //
  //   setState(() {});
  // }

  // int _expandedPanelIndex = -1;

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

class lProfile extends StatefulWidget {
  const lProfile({super.key});

  @override
  State<lProfile> createState() => _lProfileState();
}

class _lProfileState extends State<lProfile> {
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

////////////////////////////////// Sub parts ////////////////////////////////////

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

/////////////////////////////  My Course Sub sections  //////////////////////////

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

class ACYFirst extends StatefulWidget {
  final Function(int) onCardPressed;

  const ACYFirst({Key? key, required this.onCardPressed}) : super(key: key);

  @override
  State<ACYFirst> createState() => _ACYFirstState();
}

class _ACYFirstState extends State<ACYFirst> {
  List<Map<String, dynamic>> acYearList = [];
  List<Map<String, dynamic>> acYCourseList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    acYearList = await AcademicOperation().getAcYears();
    print(acYearList);
    acYearList.removeWhere((item) => item['currentYear'] < 1);
    // acYCourseList = await AcademicOperation().getMyCourse();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),),
        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: ExpansionPanelList.radio(
        animationDuration: Duration(milliseconds: 800),
        expandedHeaderPadding: EdgeInsets.all(8.0),
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
              child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: Card(
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.add_task_outlined),
                              Text('Add Course')
                            ],
                          ),
                          splashColor: Colors.deepOrange,
                          onTap: () {
                            print(item);
                            _makeCourse(context, item);
                          },
                        ),
                      ),
                    ),
                    Container(
                      child:FutureBuilder<List<Map<String, dynamic>>>(
                        future: AcademicOperation().getMyCourse(item['documentID']),
                        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              if (snapshot.data == null || snapshot.data!.isEmpty) {
                                return ListTile(
                                  title: Text('Nothing found'),
                                );
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.all(4),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final courseData = snapshot.data![index];
                                    final courseName = courseData['id'] as String?;
                                    return Card(
                                      child: ListTile(
                                        title: Text(courseName ?? 'Unknown'),
                                        trailing: PopupMenuButton(
                                          color: Colors.cyan,
                                          elevation: 10,
                                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                          popUpAnimationStyle: AnimationStyle(
                                              curve: Curves.easeInOut,
                                              duration: Duration(milliseconds: 600)),
                                          itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              padding: EdgeInsets.only(left: 30),
                                              child: Text('Delete'),
                                              onTap:() {
                                                DbCourseMethods().deleteCourse(item['documentID'],courseData['id']);
                                                loadData();
                                                print('ssss');
                                                },
                                            ),
                                          ];
                                        },),
                                        leading: Icon(Icons.cyclone_outlined),
                                        subtitle: Row(
                                          children: [
                                            Text(courseData['subjectName'].toString()),
                                          ],
                                        ),
                                        onTap: () {
                                          print('tap  $courseName');
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),

                    ),
                  ],
                ),
              ),
            ),
            value: item['documentID'],
          );
        }).toList(),
        materialGapSize: 16,
        elevation: 8,
      ),),



        // ExpansionPanelList.radio(
            //   animationDuration: Duration(milliseconds: 800),
            //   expandedHeaderPadding: EdgeInsets.all(10.0),
            //   initialOpenPanelValue: 1,
            //   children: acYearList.map((item) {
            //     return ExpansionPanelRadio(
            //       backgroundColor: Colors.lightBlue,
            //       canTapOnHeader: true,
            //       headerBuilder: (BuildContext context, bool isExpanded) {
            //         return ListTile(
            //           title: Text(item['documentID']),
            //         );
            //       },
            //       body: Container(
            //         child: SizedBox(
            //           child: Column(
            //             children: [
            //               Container(
            //                 width: 300,
            //                 height: 50,
            //                 child: Card(
            //                   child: InkWell(
            //                     borderRadius: BorderRadius.all(Radius.circular(10)),
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Icon(Icons.add_task_outlined),
            //                         Text('Add Course')
            //                       ],
            //                     ),
            //                     splashColor: Colors.deepOrange,
            //                     onTap: () {
            //                       print(item);
            //                       _makeCourse(context, item);
            //                       },
            //                   ),
            //                 ),
            //               ),
            //               Container(child: FutureBuilder(
            //                 future: AcademicOperation().getMyCourse(item['documentID']), // Call a function to fetch data based on documentID
            //                 builder: (context, snapshot) {
            //                   if (snapshot.connectionState == ConnectionState.waiting) {
            //                     return CircularProgressIndicator(); // Show a loading indicator while fetching data
            //                   } else {
            //                     if (snapshot.data == null || snapshot.data.isEmpty) {
            //                       print(snapshot.data);
            //                       return ListTile(
            //                         title: Text('Nothing found'),
            //                       );
            //                     } else {
            //                       print(snapshot.data);
            //                       return Card(child:ListTile(title: Text(item.length.toString()),)); // Pass the fetched data to your ListView widget
            //                     }
            //
            //                   }
            //                 },
            //               ),),
            //             ],
            //           ),
            //         ),
            //       ),
            //       value: item['documentID'],
            //     );
            //   }).toList(),
            //   materialGapSize: 16,
            //   elevation: 8,
            // ),
            ElevatedButton(
                onPressed: () {
                  widget.onCardPressed(0);
                },
                child: Text('back'))
          ],
        ),
      ),
    );
  }

  void _makeCourse(BuildContext context, Map<String, dynamic> item) {
    final _formKey = GlobalKey<FormState>(); // Add a global key for the form
    String?
        _selectedDepartment; // Add a variable to store the selected department
    TextEditingController _subjectNameController = TextEditingController();
    TextEditingController _courseCodeController = TextEditingController();

    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: Text('Add New Course'),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Card(
            surfaceTintColor: Colors.deepOrange,
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey, // Assign the key to the form
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _subjectNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Subject Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a subject name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _courseCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Course Code',
                        hintText: 'eg: ICT-1305',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a course code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<String>>(
                      future: _getCourseOptions(), // Replace with your API call
                      builder: (BuildContext context,
                          AsyncSnapshot<List<String>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: 'Select Department',
                            ),
                            value: _selectedDepartment,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a department';
                              }
                              return null;
                            },
                            items: snapshot.data!.map((String option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedDepartment = value;
                              });
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStatePropertyAll(10),
                      ),
                      onPressed: () {
                        // Validate the form before submission
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission here
                          AcademicOperation().addCourseACY(
                              item['documentID'],
                              _subjectNameController.text,
                              _courseCodeController.text,
                              _selectedDepartment.toString());
                          loadData();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}

Future<List<String>> _getCourseOptions() async {
  List<Map<String, dynamic>> departmentList =
      await DataOrgManage().departmentList();
  List<String> courseOptions =
      departmentList.map((department) => department['id'].toString()).toList();
  return courseOptions;
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
    print(acYearList);
    acYearList.removeWhere((item) => item['currentYear'] < 2);
    print(acYearList);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.black12),
      child: Column(
        children: [
          ExpansionPanelList.radio(
            animationDuration: Duration(milliseconds: 800),
            expandedHeaderPadding: EdgeInsets.all(10.0),
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
                  child: Card(
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
              child: Text('back'))
        ],
      ),
    );
  }
}
