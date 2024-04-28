import 'package:classbuddy/operations/user_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../operations/course_handler.dart';
import '../../../services/firebase_authentication_control.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  List<Map<String, dynamic>> acYearList = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    acYearList = await AcademicOperation().getAcYears();
    print(acYearList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: FutureBuilder(
          future: CheckUser().getCurrentUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text('Error --------: ${snapshot.error}');
              } else {
                final data = snapshot.data;
                if (data == null || data.isEmpty) {
                  return const Text('Nothing found');
                } else {
                  final user = data.isNotEmpty ? data.first : {};
                  final name = user['name'] ?? '';
                  final email = user['email'] ?? '';
                  final lastLog = user['lastLog'] != null
                      ? DateFormat('\nhh:mm a  EEE d MMM y').format(
                    DateTime.fromMillisecondsSinceEpoch(user['lastLog'] as int),) : '';
                  final role = user['role'] ?? '';
                  final acyear = user['academicYear'] ?? '';
                  final imgUrl = user['imgUrl'] ?? 'http://www.gravatar.com/avatar/?d=mp';
                  return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          color: Colors.redAccent,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Chip(
                                  padding: const EdgeInsets.all(4),
                                  side: BorderSide.none,
                                  label: Text(role,
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold)),
                                  backgroundColor: const Color(0xFFFFDCDC),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                                ),
                                const SizedBox(height: 26),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  email,
                                  style:
                                  const TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(height: 42),
                                Card(
                                  color: Colors.amber,
                                  child: Container(
                                    width: 300,
                                    padding: EdgeInsets.all(8.0),
                                    child: DocumentSelector(
                                      currentYear: acyear,
                                      documents: acYearList,
                                      onChanged: (selectedDocumentId) {
                                        // Handle selection here
                                        print('Selected Document ID: $selectedDocumentId');
                                        CheckUser().userACYUpdate(selectedDocumentId);
                                      },
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.deepOrange.shade100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Last Login: $lastLog',
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.w400)),
                                  ),
                                ),
                                const SizedBox(height: 42),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrangeAccent.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    AuthMethods().userSignOut(context);
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.black87),
                                  ),
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
                      ]);
                }
              }
            }
          },
        ),
      ),
    );
  }
}

class DocumentSelector extends StatefulWidget {
  final String currentYear;
  final List<Map<String, dynamic>> documents;
  final void Function(String) onChanged;

  const DocumentSelector({
    Key? key,
    required this.currentYear,
    required this.documents,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DocumentSelectorState createState() => _DocumentSelectorState();
}

class _DocumentSelectorState extends State<DocumentSelector> {
  String? _selectedDocumentId;



  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedDocumentId,
      onChanged: (newValue) {
        setState(() {
          _selectedDocumentId = newValue;
          widget.onChanged(newValue!);
        });
      },
      items: widget.documents.map<DropdownMenuItem<String>>((document) {
        return DropdownMenuItem<String>(
          value: document['documentID'],
          child: Text(document['documentID']),
        );
      }).toList(),
      decoration: InputDecoration(hintText: 'Select Academic Year',
        contentPadding: EdgeInsets.all(8),
        labelText: widget.currentYear,
        border: OutlineInputBorder(),
      ),
    );
  }
}
