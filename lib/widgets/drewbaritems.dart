import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

class drewbaritems1 extends StatefulWidget {
  const drewbaritems1(
      {Key? key,
      required this.text,
      required this.message,
      required this.notibackclr})
      : super(key: key);
  final String text;
  final String message;
  final Color notibackclr;

  @override
  State<drewbaritems1> createState() => _drewbaritems1State();
}

class _drewbaritems1State extends State<drewbaritems1> {
  bool mySwitch = true;
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
          child: Text(widget.text,
              style: TextStyle(
                  fontSize: 15, color: grey, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: screenHeight * 0.06, top: screenHeight * 0.02),
          child: Switch(
              activeColor: purewhite,
              value: mySwitch,
              onChanged: ((bool value) {
                setState(() {
                  mySwitch = value;
                });
                notisnackbar(
                    message: widget.message, notibackclr: widget.notibackclr);
                Navigator.pop(context);
              })),
        )
      ],
    );
  }

  notisnackbar({required String message, required Color notibackclr}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: notibackclr,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              message,
              style: TextStyle(
                color: purewhite,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ));
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
