import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

import 'package:music_player/screeens/splshscreen.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

Future<void> main() async {
  //hive registering
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DBSongsAdapter().typeId)) {
    Hive.registerAdapter(DBSongsAdapter());
  }
  //backgroung notification
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  //all songs hive box opening
  await Hive.openBox<DBSongs>('Allsongs');
  //adding_list hive box opening
  await Hive.openBox<List>('Adding_lists');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: darkblack,
        ),
        scaffoldBackgroundColor: skyblack,
      ),
      home: const splashscreen(),
    );
  }
}
