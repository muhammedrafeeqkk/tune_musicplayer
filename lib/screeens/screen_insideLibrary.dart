import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/screen_home.dart';

import 'package:music_player/shortcuts/shortcuts.dart';

import 'package:music_player/widgets/music.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';

import '../widgets/homepagewidgets.dart';

class screencarlibrary extends StatefulWidget {
  screencarlibrary({
    Key? key,
    required this.newkeys,
    required this.index, required this.audioPlayer,
  }) : super(key: key);
  final AssetsAudioPlayer audioPlayer;
  final String newkeys;
  final index;
  @override
  State<screencarlibrary> createState() => _screencarlibraryState();
}

class _screencarlibraryState extends State<screencarlibrary> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Box<List> getplaylistBox = get_adding_lists();
  // List<DBSongs> songlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // songlist = getplaylistBox.get(widget.newkeys)!.toList().cast<DBSongs>();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.newkeys),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.17,
                      width: screenwidth * 0.45,
                      decoration: BoxDecoration(
                          color: pink, borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_circle_outline_outlined,
                            color: grey,
                            size: 50,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenwidth * 0.02, right: screenwidth * 0.02),
              child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: liteblack,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ValueListenableBuilder(
                      valueListenable: getplaylistBox.listenable(),
                      builder: (BuildContext context, Box<List> value,
                          Widget? child) {
                        final playlistkeyname = widget.newkeys;
                        final songlist = value
                            .get(playlistkeyname)!
                            .toList()
                            .cast<DBSongs>();
                        return (songlist.isEmpty)
                            ? Center(child: Text('No Songs'))
                            : ListView.builder(
                                itemCount: songlist.length,
                                itemBuilder: (context, index) {
                                  return Musics(audioPlayer:widget.audioPlayer ,
                                    index: index,
                                    item: songlist,
                                    iconwant: true,
                                    isithomepage: true,
                                    conditionalicon: false,
                                    playlistname: playlistkeyname,
                                  );
                                },
                              );
                      })),
            ),
          ),
         
        ],
      ),
    );
  }
}
