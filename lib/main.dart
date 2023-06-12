import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'search_friends_menu.dart';
import 'profile_page.dart';
import 'chat.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(  
      apiKey: "AIzaSyDojL1S9Irgrzci5rI_yLbRw6UgSohWkRE",
      projectId: "chatweb-1a6a5",
      messagingSenderId: "943193419080",
      appId: "1:943193419080:web:4fabcd03636a51b36fd77d"
      )
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
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
    ChatList(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.cyan,
        destinations: [
          NavigationDestination(icon: Icon(Icons.chat_sharp), label: 'Chats'),
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