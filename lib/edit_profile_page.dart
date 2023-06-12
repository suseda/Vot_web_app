import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';

import '../main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
bool flag = true;
final controllerName = TextEditingController();
final controllerEmail = TextEditingController();
final controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_left_sharp),
        ),
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/e/e9/Felis_silvestris_silvestris_small_gradual_decrease_of_quality.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.cyan.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.camera_alt_outlined,
                          size: 20, color: Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                child: Column(children: [
                  TextFormField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                      label: Text("Full name"),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: controllerPassword,
                    obscureText: flag,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            flag = !flag;
                          });
                        }, 
                        icon: flag? Icon(Icons.visibility_off): Icon(Icons.visibility)),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        final docUser = FirebaseFirestore.instance
                        .collection('users').doc('DHbAbJcnjHrXU6gjOvLW');

                        docUser.update(
                          {
                            'name' : controllerName,
                            'email': controllerEmail,
                            'password': controllerPassword
                          }
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}