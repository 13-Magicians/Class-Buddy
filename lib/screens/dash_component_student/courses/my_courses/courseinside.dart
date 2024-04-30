import 'package:classbuddy/operations/student_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import '../../../common_components/com_url_launcher.dart';
import '../../../common_components/com_web_view.dart';

class MyCourseInside extends StatefulWidget {
  final String courseCode; // Define courseCode variable
  final String semNo;
  final String courseName;

  const MyCourseInside(this.courseCode, this.courseName, this.semNo, {Key? key}) : super(key: key); // Update constructor

  @override
  State<MyCourseInside> createState() => _MyCourseInsideState();
}

class _MyCourseInsideState extends State<MyCourseInside> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.courseCode}-${widget.courseName}'),),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: FutureBuilder<Map<String, dynamic>>(
              future: StudentOperations().getMyCourseData(widget.semNo, widget.courseCode),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Placeholder while data is loading
                } else if (snapshot.hasError) {
                  return ListTile(
                    title: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final courseData = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      enableFeedback: false,
                      tileColor: Colors.deepOrange.shade50,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(courseData['imgUrl']), // Display image
                      ),
                      title: Text(courseData['Name']), // Display student name
                      subtitle: Text(courseData['email']), // Display department
                      trailing: Chip(label: Text(courseData['department']+' Lecturer'),padding: EdgeInsets.all(0),),
                    ),
                  );
                }
              },
            ),
          ),

          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: StudentOperations().getMyCourseTopic(widget.semNo,widget.courseCode),
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
                              materialGapSize: 4,
                              expandedHeaderPadding: const EdgeInsets.all(0),
                              children: data.map<ExpansionPanelRadio>((item) {
                                return ExpansionPanelRadio(
                                  backgroundColor: Colors.deepOrange.shade100,
                                  canTapOnHeader: true,
                                  value: item['topicName'],
                                  headerBuilder: (context, isExpanded) {
                                    return ListTile(
                                      title: Text(item['topicName']),
                                    );
                                  },
                                  body: Card(
                                    surfaceTintColor: Colors.deepOrange,
                                    margin: const EdgeInsets.all(10),
                                    elevation: 4,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(item['topicNote']),
                                              const SizedBox(height: 10),
                                              if (item['videoLink'] != null && item['videoLink'] != 'none')
                                                Row(children: [
                                                  const Text('Video Link: '),
                                                  SelectableLinkify(
                                                    style: const TextStyle(color: Colors.blue),
                                                    text: "Click Here to Open",
                                                    onTap: () {
                                                      externalLink(context, item['topicName'], item['videoLink']);
                                                    },
                                                  ),
                                                ],),

                                              if (item['documentLink'] != null && item['videoLink'] != 'none')
                                                Row(children: [
                                                  const Text('Document Link: '),
                                                  SelectableLinkify(
                                                    style: const TextStyle(color: Colors.blue),
                                                    text: "Click Here to Open",
                                                    onTap: () {
                                                      ExtraUrlLunch().elaunchUrl(item['documentLink']);
                                                    },
                                                  ),
                                                ],),
                                            ],
                                          ),
                                        ),
                                      ],
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
                ),
              ),
            ),
          ),

        ],
      ),
    ); // Access courseCode from widget
  }
}
