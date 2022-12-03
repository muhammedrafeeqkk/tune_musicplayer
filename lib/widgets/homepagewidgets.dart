import 'package:flutter/material.dart';

import 'package:music_player/shortcuts/shortcuts.dart';

// ignore: camel_case_types
class shortcutwidgets extends StatelessWidget {
   shortcutwidgets({
    Key? key,
    required this.imageurl,
    required this.text,
  }) : super(key: key);

  final String imageurl;
  final String text;

//   @override
//   State<shortcutwidgets> createState() => _shortcutwidgetsState();
// }

// class _shortcutwidgetsState extends State<shortcutwidgets> {
  bool _isnotfavorite = true;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(





              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage( imageurl), fit: BoxFit.cover)),
          height: screenHeight * 0.40,
          width: screenWidth * 0.33,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Text(
             text,
            style: TextStyle(
                color: grey, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}

Widget allsongs(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.all(screenHeight * 0.02),
    child: Text(
      'All Songs',
      style: TextStyle(color: white, fontSize: 17, fontWeight: FontWeight.w500),
    ),
  );
}
