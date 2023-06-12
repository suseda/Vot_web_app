import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'friends_menu_widget.dart';
import 'chat.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<User> friends = [];

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final List<User> fetchedFriends = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return User.fromJson(data);
    }).toList();

    setState(() {
      friends = fetchedFriends;
    });
  }

  void navigateToChat(User selectedFriend) {
    print('Selected friend: ${selectedFriend.name}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chat(selectedFriend: selectedFriend)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Search friends'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(
                  friends: friends,
                  onItemSelected: (User selectedFriend) {
                    navigateToChat(selectedFriend);
                  },
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<User> users = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return User.fromJson(data);
            }).toList();

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return buildUser(users[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildUser(User user) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.img)),
      title: Text(user.name),
      onTap: () {
        navigateToChat(user);
      },
    );
  }
}

class CustomSearch extends SearchDelegate<User> {
  final List<User> friends;
  final Function(User) onItemSelected;

  CustomSearch({required this.friends, required this.onItemSelected});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        //close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> matchQuery = [];

    for (var friend in friends) {
      if (friend.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friend);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].name;
        return ListTile(
          title: Text(result),
          onTap: () {
            onItemSelected(matchQuery[index]);
            //close(context, null);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<User> matchQuery = [];

    for (var friend in friends) {
      if (friend.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(friend);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].name;
        return ListTile(
          title: Text(result),
          onTap: () {
            onItemSelected(matchQuery[index]);
            //close(context, null);
          },
        );
      },
    );
  }
}
