// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../shortcuts/shortcuts.dart';

class userscreen extends StatefulWidget {
  userscreen({Key? key}) : super(key: key);

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  TextEditingController textcontroller = TextEditingController();

  String? profileusername;

  savetostorage() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();

    final String username = sharedpref.getString('user_key').toString();
    setState(() {
      profileusername = username;
      final oldnamestored = sharedpref.getString('user_key').toString();
    });
    if (profileusername == null) {
      profileusername = 'HEY';
    } else {
      setState(() {
        profileusername = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.11, left: screenwidth * 0.08),
              child: Text(
                profileusername ?? 'hey',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w700,
                  color: grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.12),
              child: Text(
                'welcome',
                style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.w500, color: grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenwidth * 0.08),
              child: Text(
                'TO',
                style: TextStyle(
                    fontSize: 55,
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
                usernameedit();
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

  usernameedit() async {
    TextEditingController textcontroller = TextEditingController();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String oldnamestored = preferences.getString('user_key').toString();
  }
}
