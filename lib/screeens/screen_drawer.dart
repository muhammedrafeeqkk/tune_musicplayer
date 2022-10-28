import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screeens/screen_licenses.dart';
import 'package:music_player/screeens/screen_privacy.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/drewbaritems.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Uri aboutourappURL =
        Uri.parse('https://muhammedrafeeqkk.github.io/personal-portfolio/');
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
                  GestureDetector(
                    onTap: () {
                      _launchUrl(url: aboutourappURL);
                    },
                    child: drewbaritems2(context, text3: 'About Us'),
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       _launchUrl(url: aboutourappURL);
                  //     },
                  //     child: drewbaritems2(context, text3: 'About')),
                  sizedspace(context),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => screen_privacy(),
                        )),
                    child: drewbaritems2(
                      context,
                      text3: 'Privacy',
                    ),
                  ),
                  sizedspace(context),
                  GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screen_licenses(),
                            ));
                      }),
                      child: drewbaritems2(context, text3: 'License')),
                  sizedspace(context),
                  GestureDetector(
                      onTap: () async {
                        await Share.share(
                            'heloooooooooooi iam rafeeq kurachuuusudim kayinjaal inte app launch aaavum  wait cheyy');
                      },
                      child: drewbaritems2(context, text3: 'share')),
                  sizedspace(context),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              title: Center(
                                  child: Column(
                                children: [
                                  Text('Tune'),
                                  Image.asset(
                                    'assets/images/tune.png',
                                    width: 100,
                                    height: 80,
                                  )
                                ],
                              )),
                              content: Text(
                                '                            Designed by\n                    Muhammed Rafeeq\n                            version 0.0.1',
                                style: TextStyle(color: grey, fontSize: 12),
                              ),
                            );
                          },
                        );
                      },
                      child: drewbaritems2(context, text3: 'About'))
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

  //
  Future<void> _launchUrl({required url}) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
