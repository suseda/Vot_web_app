import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('John Doe'),
          subtitle: Text('Hello, how are you?'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Jane Smith'),
          subtitle: Text('Im doing great, thanks!'),
        ),
        // Add more ListTile widgets for additional chat conversations
      ],
    );
  }
}