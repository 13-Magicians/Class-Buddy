import 'package:flutter/material.dart';
import '../../../operations/lecture_course.dart';
import '../../../services/fire_course_data.dart';
import '../../../services/fireManageDep.dart';


class ACYFirst extends StatefulWidget {
  final Function(int) onCardPressed;

  const ACYFirst({Key? key, required this.onCardPressed}) : super(key: key);

  @override
  State<ACYFirst> createState() => _ACYFirstState();
}

class _ACYFirstState extends State<ACYFirst> {
  List<Map<String, dynamic>> acYearList = [];
  List<Map<String, dynamic>> acYCourseListF = [];
  List<Map<String, dynamic>> acYCourseListS = [];

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    acYearList = await AcademicOperation().getAcYears();
    acYearList.removeWhere((item) => item['currentYear'] < 1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Column(
          children: [
            ListTile(title: const Text('First Year First Semester'),tileColor: Colors.lightBlueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
            const Divider(height: 10,indent: 50,endIndent: 50,thickness: 2,),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: ExpansionPanelList.radio(
                animationDuration: const Duration(milliseconds: 800),
                expandedHeaderPadding: const EdgeInsets.all(8.0),
                initialOpenPanelValue: 1,
                children: acYearList.map((item) {
                  return ExpansionPanelRadio(
                    backgroundColor: Colors.cyan.shade400,
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: const EdgeInsets.all(6),
                        child: ListTile(
                          leading: const Icon(Icons.collections_bookmark_outlined),
                          tileColor: Colors.cyanAccent.shade400,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          title: Text(item['documentID']),
                        ),
                      );
                    },
                    body: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: Card(
                              child: InkWell(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                splashColor: Colors.deepOrange,
                                onTap: () {
                                  _makeCourse(context, item, '11');
                                },
                                child: const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.add_task_outlined),
                                    Text('Add Course')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: AcademicOperation()
                                .getMyCourse(item['documentID'],'11'),
                            builder: (context,
                                AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  if (snapshot.data == null ||
                                      snapshot.data!.isEmpty) {
                                    return const ListTile(
                                      title: Text('Nothing found'),
                                    );
                                  } else {
                                    return ListView.builder(
                                      padding: const EdgeInsets.all(4),
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final courseData =
                                        snapshot.data![index];
                                        final courseName =
                                        courseData['id'] as String?;
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                                courseName ?? 'Unknown'),
                                            trailing: PopupMenuButton(
                                              color: Colors.cyan,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25)),
                                              popUpAnimationStyle:
                                              AnimationStyle(
                                                  curve:
                                                  Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds:
                                                      600)),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 30),
                                                    child: const Text('Delete'),
                                                    onTap: () {
                                                      deleteConfirmDialog(
                                                          context,
                                                          item[
                                                          'documentID'],
                                                          courseData['id'],'11');
                                                    },
                                                  ),
                                                ];
                                              },
                                            ),
                                            leading: const Icon(
                                                Icons.cyclone_outlined),
                                            subtitle: Row(
                                              children: [
                                                Text(courseData[
                                                'subjectName']
                                                    .toString()),
                                              ],
                                            ),
                                            onTap: () {
                                              courseInside(
                                                  context,
                                                  item['documentID'],
                                                  courseData, '11');
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
                        ],
                      ),
                    ),
                    value: item['documentID'],
                  );
                }).toList(),
                materialGapSize: 16,
                elevation: 8,
              ),
            ),
            const SizedBox(height: 12,),
            Column(
              children: [
                ListTile(title: const Text('First Year Second Semester'),tileColor: Colors.lightBlueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
                const Divider(height: 10,indent: 50,endIndent: 50,thickness: 2,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: ExpansionPanelList.radio(
                    animationDuration: const Duration(milliseconds: 800),
                    expandedHeaderPadding: const EdgeInsets.all(8.0),
                    initialOpenPanelValue: 1,
                    children: acYearList.map((item) {
                      return ExpansionPanelRadio(
                        backgroundColor: Colors.cyan.shade400,
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            child: ListTile(
                              leading: const Icon(Icons.collections_bookmark_outlined),
                              tileColor: Colors.cyanAccent.shade400,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              title: Text(item['documentID']),
                            ),
                          );
                        },
                        body: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: Card(
                                  child: InkWell(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    splashColor: Colors.deepOrange,
                                    onTap: () {
                                      _makeCourse(context, item, '12');
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.add_task_outlined),
                                        Text('Add Course')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: AcademicOperation()
                                    .getMyCourse(item['documentID'],'12'),
                                builder: (context,
                                    AsyncSnapshot<List<Map<String, dynamic>>>
                                    snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      if (snapshot.data == null ||
                                          snapshot.data!.isEmpty) {
                                        return const ListTile(
                                          title: Text('Nothing found'),
                                        );
                                      } else {
                                        return ListView.builder(
                                          padding: const EdgeInsets.all(4),
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final courseData =
                                            snapshot.data![index];
                                            final courseName =
                                            courseData['id'] as String?;
                                            return Card(
                                              child: ListTile(
                                                title: Text(
                                                    courseName ?? 'Unknown'),
                                                trailing: PopupMenuButton(
                                                  color: Colors.cyan,
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                                  popUpAnimationStyle:
                                                  AnimationStyle(
                                                      curve:
                                                      Curves.easeInOut,
                                                      duration: const Duration(
                                                          milliseconds:
                                                          600)),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 30),
                                                        child: const Text('Delete'),
                                                        onTap: () {
                                                          deleteConfirmDialog(
                                                              context,
                                                              item[
                                                              'documentID'],
                                                              courseData['id'],'12');
                                                        },
                                                      ),
                                                    ];
                                                  },
                                                ),
                                                leading: const Icon(
                                                    Icons.cyclone_outlined),
                                                subtitle: Row(
                                                  children: [
                                                    Text(courseData[
                                                    'subjectName']
                                                        .toString()),
                                                  ],
                                                ),
                                                onTap: () {
                                                  courseInside(
                                                      context,
                                                      item['documentID'],
                                                      courseData, '12');
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
                            ],
                          ),
                        ),
                        value: item['documentID'],
                      );
                    }).toList(),
                    materialGapSize: 16,
                    elevation: 8,
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  widget.onCardPressed(0);
                },
                child: const Text('back'))
          ],
        ),
      ),
    );
  }

  void courseInside(
      BuildContext context, String item, Map<String, dynamic> courseData, String semNo) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent.shade100,
            title: Row(
              children: [
                Text(courseData['id']),
                const Text(' - '),
                Text(courseData['subjectName'])
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Card(
            surfaceTintColor: Colors.deepOrange,
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(item),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text(courseData['department']),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: SelectableText("Pass Code : ${courseData['passCode']}"),
                      ),
                    ],
                  ),
                  const Text('Course content'),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: AcademicOperation().getTopics(item, semNo, courseData['courseCode']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return const Text('Nothing found');
                          } else {
                            return ExpansionPanelList.radio(
                              expandedHeaderPadding: const EdgeInsets.all(0),
                              children: data.map<ExpansionPanelRadio>((item) {
                                return ExpansionPanelRadio(
                                  value: item['topicName'],
                                  headerBuilder: (context, isExpanded) {
                                    return ListTile(
                                      title: Text(item['topicName']),
                                    );
                                  },
                                  body: Card(
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item['topicNote']),
                                          const SizedBox(height: 10),
                                          if (item['videoLink'] != null)
                                            Text('Video Link: ${item['videoLink']}'),
                                          if (item['documentLink'] != null)
                                            Text('Document Link: ${item['documentLink']}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        }
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(18.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrangeAccent.shade100,
              child: const Icon(Icons.display_settings_rounded),
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 400,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            const Text(
                              "Change Course Content",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListTile(

                              leading: const Icon(Icons.add),
                              title: const Text('Add Topics'),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              tileColor: Colors.deepOrangeAccent.shade100,

                              onTap: () {
                                Navigator.pop(context);
                                _showAddLinkDialog(item, courseData, semNo);

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Divider(
                              height: 12,
                            ),
                            ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('Add Assignment'),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              tileColor: Colors.deepOrangeAccent.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const Divider(
                              height: 12,
                            ),
                            ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('Add Video'),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              tileColor: Colors.deepOrangeAccent.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onTap: () {


                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    ));
  }











  Future<void> _showAddLinkDialog(item, courseData, semNo) async {
    List<Map<String, dynamic>> subjectTopic = [];
    String topicName = '';
    String videoLink = '';
    String documentLink = '';
    String topicNote = '';

    bool addLink = true;

    while (addLink) {
      final result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Add Topic'),
          scrollable: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
          content: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Topic Name',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                onChanged: (value) => topicName = value,
              ),
              const SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(labelText: 'Video Link (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                onChanged: (value) => videoLink = value,
              ),
              const SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(labelText: 'Document Link (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                onChanged: (value) => documentLink = value,
              ),
              const SizedBox(height: 8,),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Topic Note (Optional)',border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                onChanged: (value) => topicNote = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false to indicate cancellation
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (topicName.isNotEmpty) {
                  // Set default values "none" for optional fields if empty
                  if (videoLink.isEmpty) {
                    videoLink = 'none';
                  }
                  if (documentLink.isEmpty) {
                    documentLink = 'none';
                  }
                  if (topicNote.isEmpty) {
                    topicNote = 'none';
                  }
                  // Add link to the list and return true to indicate successful addition
                  Map<String, dynamic> subjectTopicData = {
                    'topicName': topicName,
                    'videoLink': videoLink,
                    'documentLink': documentLink,
                    'topicNote': topicNote,
                  };
                  subjectTopic.add(subjectTopicData);


                  AcademicOperation().addTopic(item, courseData, subjectTopicData, semNo);
                  Navigator.of(context).pop(false);
                } else {
                  // Show error message if topic name is empty
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please enter a topic name.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the error dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      );

      if (result == true) {
        // User successfully added a link
        setState(() {
          // Reset fields for next link
          topicName = '';
          videoLink = '';
          documentLink = '';
          topicNote = '';
        });
      } else {
        // If the dialog is canceled or if the last link is empty, exit the loop
        addLink = false;
      }
    }
  }









  Future<void> btnDelete(item, courseData, String semNo) async {
    await DbCourseMethods().deleteCourse(item, courseData, semNo);
    loadData();
  }

  Future deleteConfirmDialog(BuildContext context, item, courseData, String semNo) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrangeAccent.shade100,
          title: const Text('Delete This Course?'),
          content: const Text(
              'This will delete the Course and it can not be recover.'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                btnDelete(item, courseData, semNo);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _makeCourse(BuildContext context, Map<String, dynamic> item, String semNo) {
    final formKey = GlobalKey<FormState>(); // Add a global key for the form
    String?
    selectedDepartment; // Add a variable to store the selected department
    TextEditingController subjectNameController = TextEditingController();
    TextEditingController courseCodeController = TextEditingController();
    TextEditingController passCodeController = TextEditingController();

    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: const Text('Add New Course'),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Card(
              surfaceTintColor: Colors.deepOrange,
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: Form(
                  key: formKey, // Assign the key to the form
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: subjectNameController,
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
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: courseCodeController,
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
                      const SizedBox(height: 16.0),
                      FutureBuilder<List<String>>(
                        future: _getCourseOptions(), // Replace with your API call
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Select Department',
                              ),
                              value: selectedDepartment,
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
                                  selectedDepartment = value;
                                });
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: passCodeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Pass Code',
                          hintText: 'eg: abc123',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 4) {
                            return 'Please enter a valid pass code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent),
                          elevation: MaterialStatePropertyAll(4),
                        ),
                        onPressed: () {
                          // Validate the form before submission
                          if (formKey.currentState!.validate()) {
                            // Handle form submission here
                            AcademicOperation().addCourseACY(
                              item['documentID'],
                              subjectNameController.text,
                              courseCodeController.text,
                              selectedDepartment.toString(),
                              passCodeController.text,
                              semNo,
                            );
                            loadData();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Submit',style: TextStyle(color: Colors.black87),),
                      ),
                    ],
                  ),
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


