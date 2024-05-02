import 'package:flutter/material.dart';
import '../../../operations/course_handler.dart';
import '../../../services/firebase_course_control.dart';
import '../../../services/firebase_department_control.dart';
import 'add_academic_years.dart';
import 'add_department.dart';
import 'change_academic_year.dart';

class AcademicSection extends StatefulWidget {
  const AcademicSection({super.key});

  @override
  State<AcademicSection> createState() => _AcademicSectionState();
}

class _AcademicSectionState extends State<AcademicSection>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> depList = [];
  List<Map<String, dynamic>> acYearList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    depList = await DataOrgManage().departmentList();
    acYearList = await AcademicOperation().getAcYears();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TabController mAcidController =
        TabController(length: 2, vsync: this);
    return Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0)),
        margin: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            TabBar(
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
              ],
            ),
            Divider(color: Colors.black26, height: 10, thickness: 2),
            Expanded(
              child: TabBarView(
                controller: mAcidController,
                children: [
                  // Department Section
                  departmentTab(),
                  // AC Years Section
                  batchYearTab(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget departmentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
          elevation: 10,
          child: ListTile(
            leading: Icon(Icons.add_home_work_outlined),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: Text(
              'Add New Department',
            ),
            tileColor: Colors.deepOrangeAccent,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddDepartmentDialog();
                },
              ).then((value) {
                loadData();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              addAutomaticKeepAlives: true,
              itemCount: depList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.home_max_outlined),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    minLeadingWidth: 40,
                    title: Text(depList[index]['id']),
                    subtitle: Text(depList[index]['name']),
                    selectedTileColor: Colors.cyanAccent,
                    hoverColor: Colors.lightGreen,
                    focusColor: Colors.redAccent,
                    tileColor: Colors.teal,
                    onTap: () {},
                    trailing: PopupMenuButton(
                      color: Colors.deepOrange,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: const Text("Delete"),
                            onTap: () {
                              DataOrgManage()
                                  .deleteDepartment(depList[index]['id']);
                              loadData();
                            },
                          ),
                        ];
                      },
                    ),
                    horizontalTitleGap: 2.0,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget batchYearTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
          elevation: 10,
          child: ListTile(
            leading: Icon(Icons.data_saver_on_outlined),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            tileColor: Colors.deepOrangeAccent,
            title: Text('Add New Batch'),
            visualDensity: VisualDensity.comfortable,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddAcademicYear();
                },
              ).then((value) {
                loadData();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: acYearList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: const Icon(Icons.data_exploration_outlined),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    minLeadingWidth: 50,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(acYearList[index]['documentID']),
                        InkWell(
                          child: Chip(
                            surfaceTintColor: Colors.greenAccent,
                            elevation: 4,
                            side: BorderSide(style: BorderStyle.none),
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            label: Text(
                                'Now in ${acYearList[index]['currentYear'].toString()} year'),
                          ),
                          onTap: () {
                            // ChangeAcademicYearDialog(initialSelectedIndex: 1,)..showAlertDialog(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                int year = acYearList[index]['currentYear'];
                                return ChangeAcademicYearDialog(currentACYear: acYearList[index]['documentID'], initialSelectedIndex: year); // Pass year directly
                              },
                            ).then((value) {
                              loadData();
                            });
                          },
                        ),
                      ],
                    ),
                    // subtitle: SegmentButton(),
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
                                DbCourseMethods().deleteAcademicYear(
                                    acYearList[index]['documentId']);
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
              }),
        ),
      ],
    );
  }

}

