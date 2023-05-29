import 'package:flutter/material.dart';

class FriendsMenuWidget {
 final String name;
 final String email;
 final String img;

 FriendsMenuWidget(
  {
    required this.img,
    required this.name,
    required this.email,
  }
 );

}


final allusers =[
  FriendsMenuWidget(name: 'Kaloyan',email: 'kaloyan@gmail',img: 'https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png'),
  FriendsMenuWidget(name: 'Brayan',email: 'brayan@gmail',img: 'https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png'),
  FriendsMenuWidget(name: 'Ivan',email: 'ivan@gmail',img: 'https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png'),
  FriendsMenuWidget(name: 'Nikola',email: 'nikola@gmail',img: 'https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png'),
];