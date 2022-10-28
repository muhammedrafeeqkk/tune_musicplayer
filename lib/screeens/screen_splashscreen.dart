import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/screeens/screen_home.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  List<SongModel> deviceAllSongs = [];
  Box<DBSongs> allsongbox = get_allsongsbox();
  Box<List> adding_lists = get_adding_lists();

  @override
  void initState() {
    super.initState();

    allDevicesong();
  }

  Future allDevicesong() async {
    await Permission.storage.request();
    deviceAllSongs = await _onAudioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
    );

    for (var audio in deviceAllSongs) {
      final song = DBSongs(
        id: audio.id.toString(),
        artist: audio.artist!,
        title: audio.displayNameWOExt,
        uri: audio.uri!,
      );

      await allsongbox.put(song.id, song);
    }
    Getfavsongs();
    GetRecentSongs();
    _navigatetohome();
  }

  Future Getfavsongs() async {
    if (!adding_lists.keys.contains('favorites')) {
      await adding_lists.put('favorites', []);
    }
  }

  GetRecentSongs() async {
    if (!adding_lists.keys.contains('recent')) {
      await adding_lists.put('recent', []);
    }
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 4));
    () {};
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const myhome()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Image(
        image: AssetImage(
          'assets/images/LOGO2.png',
        ),
      )),
      backgroundColor: Colors.black,
    );
  }
}
