import 'package:flutter/material.dart';
import '../../../operations/course_handler.dart';
import '../../../services/firebase_course_control.dart';
import '../../../services/firebase_department_control.dart';
import 'add_academic_years.dart';
import 'add_department.dart';

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

  // var userData = 'User';
  // var items = List<String>.generate(10, (index) => 'Item $index');

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
                                return ChangeAcademicYearDialog(initialSelectedIndex: year); // Pass year directly
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



class ChangeAcademicYearDialog extends StatefulWidget {
  final int initialSelectedIndex; // Pre-select year

  const ChangeAcademicYearDialog({Key? key, required this.initialSelectedIndex})
      : super(key: key);

  @override
  State<ChangeAcademicYearDialog> createState() => _ChangeAcademicYearDialogState();
}

class _ChangeAcademicYearDialogState extends State<ChangeAcademicYearDialog> {
  int _selectedIndex = 0; // State variable for selected year

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex; // Set initial year
  }

  final List<ButtonSegment<int>> segments = List.generate(5,
        (index) => ButtonSegment<int>(
          value: index,
          label: Text(index.toString()),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: const Text('Change Academic Year', style: TextStyle(fontSize: 20)),
      content: SizedBox(
        height: 50,
        child: SegmentedButton<int>(
          segments: segments,
          selected: {_selectedIndex},
          onSelectionChanged: (Set<int> selectedValues) {
            if (selectedValues.isNotEmpty) {
              setState(() {
                _selectedIndex = selectedValues.first;
              });
            }
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle user selection (e.g., print selected year)
            print('Selected year: $_selectedIndex');
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ); // Empty build method (removed AlertDialog)
  }
}
