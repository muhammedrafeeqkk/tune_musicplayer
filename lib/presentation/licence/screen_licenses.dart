import 'package:flutter/material.dart';

class screen_licenses extends StatelessWidget {
  const screen_licenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    
     Container(
      
        child: LicensePage(
      applicationName: 'Tune',
      applicationIcon: Image.asset(
        'assets/images/tune.png',
        width: 120,
        height: 100,
      ),
      applicationVersion: ' version 0.0.1',
      applicationLegalese: 'muhammed Rafeeq kk',
    ));
  }
}
