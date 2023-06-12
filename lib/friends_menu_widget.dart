import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String img;
  final String password;
  final Map<String, List<String>> messages;
  final String id;

  User({
    required this.img,
    required this.name,
    required this.email,
    required this.password,
    required this.messages,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
        'email': email,
        'img': img,
        'messages': messages,
        'id': id,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    final messagesJson = json['messages'];

    Map<String, List<String>> messages = {};
    if (messagesJson is Map<String, dynamic>) {
      messagesJson.forEach((key, value) {
        if (value is List<dynamic>) {
          messages[key] = value.cast<String>();
        }
      });
    }

    return User(
      name: json['name'],
      email: json['email'],
      img: json['img'],
      password: json['password'],
      messages: messages,
      id: json['id'],
    );
  }
}


