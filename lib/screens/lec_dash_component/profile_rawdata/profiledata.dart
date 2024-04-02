import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/auth.dart';
import '../../../services/fireDatabase.dart';

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