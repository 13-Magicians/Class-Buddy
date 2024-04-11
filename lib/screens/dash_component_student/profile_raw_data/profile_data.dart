import 'package:classbuddy/operations/user_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/firebase_authentication_control.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  void initState() {
    super.initState();
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
