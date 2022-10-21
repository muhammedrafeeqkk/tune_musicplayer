import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

class drewbaritems1 extends StatelessWidget {
  const drewbaritems1({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(
    BuildContext context,
  ) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.08,
          width: screenwidth * 0.40,
          decoration: BoxDecoration(
              color: skyblack, borderRadius: BorderRadius.circular(10)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenHeight * 0.030, top: screenHeight * 0.011),
          child: Text(text,
              style: TextStyle(
                  fontSize: 15, color: grey, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenHeight * 0.06, top: screenHeight * 0.02),
          child: Switch(value: true, onChanged: ((value) {})),
        )
      ],
    );
  }
}

Widget sizedspace(BuildContext context) {
  final screenwidth = MediaQuery.of(context).size.width;
  return SizedBox(
    height: screenwidth * 0.035,
  );
}

Widget drewbaritems2(BuildContext context, {required text3}) {
  final screenwidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    width: screenwidth * 0.40,
    height: screenHeight * 0.06,
    decoration:
        BoxDecoration(color: skyblack, borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: Text(
        text3,
        style:
            TextStyle(fontSize: 15, color: grey, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
