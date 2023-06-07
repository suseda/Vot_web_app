import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'friends_menu_widget.dart';

class FriendsMenu extends StatefulWidget {
  const FriendsMenu({Key? key}) : super(key: key);

  @override
  State<FriendsMenu> createState() => _FriendsMenuState();
}

class _FriendsMenuState extends State<FriendsMenu> {
  List<FriendsMenuWidget> friends = allusers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Search people',
                filled: true,
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];

                return Slidable(
                    startActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete_forever_rounded,
                        label: 'Delete',
                        onPressed: (context) => _onDismissed(index),
                      )
                    ]),
                    child: buildFriendListTile(friend));
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onDismissed(int index) {
    setState(() => friends.removeAt(index));
  }

  Widget buildFriendListTile(FriendsMenuWidget friend) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(friend.name),
      subtitle: Text(friend.email),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(friend.img),
      ),
      onTap: () => Navigator.push( context,
              MaterialPageRoute(builder: (context) => ChatApp())),
    );
  }
}
