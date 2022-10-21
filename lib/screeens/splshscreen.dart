import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/screeens/home.dart';
import 'package:music_player/widgets/homepagewidgets.dart';
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
  List<DBSongs> favsongs = [];

  @override
  void initState() {
    super.initState();

    requestpermission();
    allDevicesong();
    _navigatetohome();
  }

  requestpermission() {
    Permission.storage.request();
  }

  Future allDevicesong() async {
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
  }

  Future Getfavsongs() async {
    if (!adding_lists.keys.contains('favorites')) {
      await adding_lists.put('favorites', favsongs);
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