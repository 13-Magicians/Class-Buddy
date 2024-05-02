import 'package:flutter/material.dart';
import '../../../operations/course_handler.dart';

class AACYFirst extends StatefulWidget {
  final Function(int) onACCardPressed;
  const AACYFirst({Key? key, required this.onACCardPressed}) : super(key: key);

  @override
  State<AACYFirst> createState() => _AACYFirstState();
}

class _AACYFirstState extends State<AACYFirst> with WidgetsBindingObserver {
  List<Map<String, dynamic>> acYearList = [];
  List<Map<String, dynamic>> acYCourseListF = [];
  List<Map<String, dynamic>> acYCourseListS = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    loadData();
  }

  loadData() async {
    acYearList = await AcademicOperation().getAcYears();
    acYearList.removeWhere((item) => item['currentYear'] < 1);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            Card(
              margin: const EdgeInsets.all(0),
              child: ListTile(
                title: const Text('First Year First Semester'),
                tileColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const Divider(
              height: 10,
              indent: 50,
              endIndent: 50,
              thickness: 2,
            ),
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
                          leading:
                              const Icon(Icons.collections_bookmark_outlined),
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
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: AcademicOperation()
                                .getMyCourse(item['documentID'], '11'),
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
                                            title:
                                                Text(courseName ?? 'Unknown'),
                                            leading: const Icon(
                                                Icons.cyclone_outlined),
                                            subtitle: Row(
                                              children: [
                                                Text(courseData['subjectName']
                                                    .toString()),
                                              ],
                                            ),
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
            const SizedBox(
              height: 12,
            ),
            Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(0),
                  child: ListTile(
                    title: const Text('First Year Second Semester'),
                    tileColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Divider(
                  height: 10,
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                ),
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
                              leading: const Icon(
                                  Icons.collections_bookmark_outlined),
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
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: AcademicOperation()
                                    .getMyCourse(item['documentID'], '12'),
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
                                                leading: const Icon(
                                                    Icons.cyclone_outlined),
                                                subtitle: Row(
                                                  children: [
                                                    Text(courseData[
                                                            'subjectName']
                                                        .toString()),
                                                  ],
                                                ),
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
                  widget.onACCardPressed(0);
                },
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.orange),
                    minimumSize: const MaterialStatePropertyAll(Size(80, 40))),
                child: const Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

}
