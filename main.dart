import 'package:flutter/material.dart';
import 'search_friends_menu.dart';
import 'profile_page.dart';
import 'chat_list.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int currentPageIndex = 0;
  final screens = [
    ChatListScreen(),
    FriendsMenu(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      appBar: AppBar(
        title: Text('Chat App'),
        foregroundColor: Colors.black,
        actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              print('Phone ring...');
            },
            child: Icon(
              Icons.phone_in_talk_sharp,
              size: 26.0,
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              print('Video chat...');
            },
            child: Icon(
                Icons.video_camera_front
            ),
          )
        ),
  ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.amber,
        destinations: [
          NavigationDestination(icon: Icon(Icons.chat_sharp), label: 'Chats'),
          NavigationDestination(icon: Icon(Icons.people_alt_rounded), label: 'Friends'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) => {
          setState((){
              currentPageIndex = index;
          })
        } ,
      ),
    );
  }
}
