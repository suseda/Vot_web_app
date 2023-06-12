import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'friends_menu_widget.dart' as app;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final app.User selectedFriend;

  const Chat({required this.selectedFriend, Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textEditingController = TextEditingController();
  String _displayText = '';
  final List<String> messages = <String>[];
  late app.User selectedFriend;
  late app.User currentUser;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
    selectedFriend = widget.selectedFriend;
  }

  void fetchCurrentUser() async {
    auth.User? user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      Map<String, dynamic> currentUserData =
          currentUserDoc.data() as Map<String, dynamic>;
      setState(() {
        currentUser = app.User.fromJson(currentUserData);
      });
    }
  }

  void _handleButtonClick() async {
    if (currentUser == null) {
      return;
    }
    setState(() {
      _displayText = _textEditingController.text;
      messages.insert(messages.length, _displayText);
      _textEditingController.clear();
    });

    selectedFriend.messages.putIfAbsent(currentUser.name, () => []);
    selectedFriend.messages[currentUser.name]!.add(_displayText);

    currentUser.messages.putIfAbsent(selectedFriend.name, () => []);
    currentUser.messages[selectedFriend.name]!.add(_displayText);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedFriend.id)
        .update({'messages': selectedFriend.messages});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id)
        .update({'messages': currentUser.messages});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(selectedFriend.name),
        actions: [
          IconButton(
            onPressed: () {
              print("Phone ring ...");
            },
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {
              print("Video call ...");
            },
            icon: Icon(Icons.video_call),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.cyan.shade100,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      selectedFriend.messages[currentUser.name]?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final message =
                        selectedFriend.messages[currentUser.name]![index];
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      color: Colors.cyan.shade100,
                      child: Text(
                        '${currentUser.name} : $message',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Enter something ...',
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _handleButtonClick,
                      icon: Icon(Icons.send),
                      color: Colors.blue,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
