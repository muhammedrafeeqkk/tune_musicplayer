// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../shortcuts/shortcuts.dart';

class userscreen extends StatefulWidget {
  userscreen({Key? key}) : super(key: key);

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  getNamefromStorage() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final name = sharedprefs.getString('user_key');
    if (name!.isEmpty || name == null) {
      setState(() {
        profileusername = 'Hey';
        return;
      });
    }
    setState(() {
      profileusername = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNamefromStorage();
  }

  TextEditingController textcontroller = TextEditingController();

  String? profileusername;

  saveNameToStorage() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();

    var username = textcontroller.text.trim();
    if (username == null || username.isEmpty) {
      setState(() {
        username = 'Hey';
        return;
      });
    }
    await sharedpref.setString('user_key', username);
    setState(() {
      profileusername = username;
    });
    log(username);
  }

  @override
  Widget build(BuildContext context) {
    getNamefromStorage();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.11, left: screenwidth * 0.1),
              child: Text(
                profileusername ??= 'Hay',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.11),
              child: Text(
                'welcome',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.1),
              child: Text(
                'TO',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenwidth * 0.35, top: screenHeight * 0.05),
              child: Image(image: AssetImage('assets/images/LOGO2.png')),
            ),
            SizedBox(
              height: screenHeight * 0.11,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    prefixIcon: Icon(Icons.person),
                    hintText: '        your name...',
                    fillColor: grey,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                saveNameToStorage();
                log(profileusername!);
              },
              child: Text('submit'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(pink),
              ),
            ))
          ],
        ),
      ),
    );
  }

  // usernameedit() async {
  //   TextEditingController textcontroller = TextEditingController();
  //   final preferences = await SharedPreferences.getInstance();

  //   preferences.setString('user_key', textcontroller.text);
  // }
}
