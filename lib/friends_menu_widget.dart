import 'package:flutter/material.dart';

class User {
 final String name;
 final String email;
 final String img;
 final String password;
 final List<List<String>> messages;

 User(
  {
    required this.img,
    required this.name,
    required this.email,
    required this.password,
    required this.messages
  }
 );

  Map<String,dynamic> toJson() => {
    'name': name,
    'password' : password,
    'email' : email,
    'img' : img,
    'messages' : messages
  };

  factory User.fromJson(Map<String, dynamic> json) {
  final messagesJson = json['messages'];

  List<List<String>> messages = [];
  if (messagesJson is List<dynamic>) {
    messages = messagesJson.map<List<String>>(
      (dynamic message) => List<String>.from(message),
    ).toList();
  }

  return User(
    name: json['name'],
    email: json['email'],
    img: json['img'],
    password: json['password'],
    messages: messages,
  );
}
}

