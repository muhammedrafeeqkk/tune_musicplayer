import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/drewbaritems.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
    required this.screenwidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenwidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(190),
        ),
      ),
      backgroundColor: grey,
      width: screenwidth * 0.61,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.65,
              child: Column(
                children: [
                  drewbaritems1(
                      text: 'NOTIFICATION',
                      message: 'NOTIFICATION STATUS UPDATED',
                      notibackclr: darkblack),
                  sizedspace(context),
                  drewbaritems1(
                      text: "DARK MODE",
                      message: 'THEME CHANGED',
                      notibackclr: darkblack),
                  sizedspace(context),
                  drewbaritems2(context, text3: 'About'),
                  sizedspace(context),
                  drewbaritems2(context, text3: 'Privacy'),
                  sizedspace(context),
                  drewbaritems2(context, text3: 'License'),
                  sizedspace(context),
                  drewbaritems2(context, text3: 'share'),
                ],
              ),
            ),
          ),
          Text(
            'VERSION\n    0.0.1',
            style: TextStyle(color: liteblack, fontSize: 10),
          )
        ],
      ),
    );
  }
}
