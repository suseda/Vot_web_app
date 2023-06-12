import 'package:flutter/cupertino.dart';
import 'friends_menu_widget.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {

  final User selectedFriend;
  const Chat({required this.selectedFriend, Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textEditingController = TextEditingController();
  String _displayText = '';
  final List<String> messages = <String>[];
  late User selectedFriend = widget.selectedFriend;



  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleButtonClick() {
    setState(() {
      _displayText = _textEditingController.text;
      messages.insert(messages.length, _displayText);
      _textEditingController.clear();
    });
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
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(2),
                  color: Colors.cyan.shade100,
                  child: Text('${messages[index]}',
                      style: TextStyle(fontSize: 18),
                    )
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