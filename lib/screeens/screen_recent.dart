import 'package:flutter/material.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/homepagewidgets.dart';


class ScreenRecent extends StatelessWidget {
  ScreenRecent({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.25),
              child: Text('Recent'),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            title: Text(
                              'Are You Sure',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'NO'),
                                child: const Text('NO'),
                              ),
                              TextButton(onPressed: () {}, child: Text('YES'))
                            ],
                            // titlePadding:
                            //     EdgeInsets.only(top: screenHeight * 0.06),
                          ));
                },
                icon: Icon(
                  Icons.delete_outline,
                  size: 30,
                ),
              )
            ]),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  librarytext(),
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                            child: Text(
                          ' No  Library Found....',
                          style: TextStyle(color: grey),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: Column(
                  children: [
                    songtext(),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.02, right: screenWidth * 0.02),
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: liteblack,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: ListView(
                          children: [
                       
                          ],
                        ),
                      ),
                    ))
                  ],
                )),
          
          ],
        ));
  }
}

Widget librarytext() {
  return ListTile(
    iconColor: grey,
    textColor: grey,
    leading: Icon(
      Icons.playlist_add_check,
      size: 32,
    ),
    title: Text(
      'Library',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

Widget songtext() {
  return ListTile(
    iconColor: grey,
    textColor: grey,
    leading: Icon(
      Icons.music_note,
      size: 30,
    ),
    title: Text(
      'Songs',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
