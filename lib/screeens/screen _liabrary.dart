import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/screeens/screen_favorites.dart';

import 'package:music_player/screeens/screen_insideLibrary.dart';
import 'package:music_player/screeens/screen_miniplayer.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/music.dart';

import 'package:music_player/widgets/new_create_playlist_show_dailouge.dart';

import '../widgets/customgrid.dart';

class ScreenLibrary extends StatefulWidget {
  ScreenLibrary({
    Key? key,
    required this.item,
    required this.audioPlayer,
  }) : super(key: key);

  final List<DBSongs> item;
  final AssetsAudioPlayer audioPlayer;

  @override
  State<ScreenLibrary> createState() => _ScreenLibraryState();
}

class _ScreenLibraryState extends State<ScreenLibrary> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
   
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Box<List> getplaylistBox = get_adding_lists();
    ////////////////////////////////////
     final songId = widget.audioPlayer.id;
    final currentindex = currentsongindex(songId: songId);

    PlayerBuilder.isPlaying(
      player: widget.audioPlayer,
      builder: (context, isPlaying) {
        return newminiplayer(
            context: context,
            item: widget.item,
            index: currentindex,
            audioPlayer: widget.audioPlayer);
      },
    );
    //////////////////////////
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Liabrary'),
          actions: [
            IconButton(
                onPressed: () {
                  new_playlist_creating_widget(context: context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: getplaylistBox.listenable(),
              builder: (context, value, child) {
                List<String> keys = getplaylistBox.keys.toList().cast();
                keys.removeWhere((item) => item.contains('favorites'));

                return Expanded(
                  flex: 14,
                  child: keys.isEmpty
                      ? Center(
                          child: Text(
                          'No Playlists',
                          style: TextStyle(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ))
                      : Container(
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: keys.length,
                            padding: EdgeInsets.all(screenWidth * 0.042),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: (5 / 4)),
                            itemBuilder: (BuildContext context, int index) {
                              final playlistkeyname = keys[index];

                              return Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  screencarlibrary(
                                                      audioPlayer:
                                                          widget.audioPlayer,
                                                      index: index,
                                                      newkeys: playlistkeyname),
                                            ));
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            getplaylistBox.listenable(),
                                        builder: (context, value, child) {
                                          return customgrid(
                                            color: pink,
                                            playlistkeyname: playlistkeyname,
                                          );
                                        },
                                      )));
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ));
  }

  currentsongindex({required songId}) {
    final currentIndex =
        widget.item.indexWhere((element) => element.id == songId);
    return currentIndex;
  }
}
