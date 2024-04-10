import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../services/authentication.dart';
import '../services/firebase_database.dart';
import 'package:intl/intl.dart';


class StuDash extends StatefulWidget {
  const StuDash({super.key});

  @override
  State<StuDash> createState() => _StuDashState();
}

class _StuDashState extends State<StuDash> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  static const List<Widget> _widgetOptions = <Widget>[
    stuExplore(),
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    AIChat(),
    SProfile(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Hello Student'),
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
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex)
      ),
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
              label: 'Courses',
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

class stuExplore extends StatefulWidget {
  const stuExplore({super.key});

  @override
  State<stuExplore> createState() => _stuExploreState();
}

class _stuExploreState extends State<stuExplore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(flexibleSpace: SearchBarApp()),


        )
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {

  @override
  Widget build(BuildContext context) {


    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  onSubmitted: (value) {
                    print(value);
                  },
                  hintText: 'Search Course',
                  backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Search Course',
                      child: IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                );
              }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
        );


  }
}



class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();
  final apiKey = 'AIzaSyCA8yMLvIrsmQDJSJiffuO-MpQr0UZhkas';

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Container(child: Text('Chat Powered by Generative AI')),
      ),
      body: Card(
        elevation: 6,
        color: Colors.orangeAccent.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _chatSession.history.length,
                    itemBuilder: (context, index) {
                      final Content content =
                      _chatSession.history.toList()[index];
                      final text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageSet(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        focusNode: _textFieldFocus,
                        decoration: textFieldDecoration(),
                        controller: _textController,
                        onSubmitted: _sendChatMessage,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      onPressed: _loading
                          ? null
                          : () => _sendChatMessage(_textController.text),
                      icon: _loading
                          ? CircularProgressIndicator()
                          : Icon(Icons.send),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.all(15),
      hintText: 'Say Something...!',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No response from AI...!');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 750), curve: Curves.easeOutCirc));
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Something went wrong...!'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}

class MessageSet extends StatelessWidget {
  const MessageSet({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: EdgeInsets.only(bottom: 8),
            constraints: BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Colors.deepOrangeAccent.shade200
                  : Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                MarkdownBody(
                  data: text,
                  selectable: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}





class SProfile extends StatefulWidget {
  const SProfile({super.key});

  @override
  State<SProfile> createState() => _SProfileState();
}

class _SProfileState extends State<SProfile> {

  List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    final userId = await AuthMethods().getCurrentUser();
    userData = await DatabaseMethods().getCurrentUserData(userId);
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    final user = userData.isNotEmpty ? userData.first : {};
    final name = user['name'] ?? '';
    final email = user['email'] ?? '';
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight:Radius.circular(100) )),
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
                          label:
                          Text(role, style: TextStyle(fontWeight: FontWeight.bold)),
                          backgroundColor: Color(0xFFFFDCDC),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        ),
                        SizedBox(height: 26),
                        Text(
                          name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          email,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 42),
                        Text('Last Login:' + lastLog, style: TextStyle(fontSize: 14)),
                        SizedBox(height: 42),
                        ElevatedButton(
                          onPressed: () {
                            AuthMethods().userSignOut(context);
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




