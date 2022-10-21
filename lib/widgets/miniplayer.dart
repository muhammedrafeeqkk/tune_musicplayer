import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/home.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/screeens/screenfavorites.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../db/db_functions/db_function.dart';
import '../screeens/nowplaying.dart';

class miniplayer extends StatefulWidget {
  miniplayer({
    Key? key,
  }) : super(key: key);

  @override
  State<miniplayer> createState() => _miniplayerState();
}

class _miniplayerState extends State<miniplayer> {
  Box<DBSongs> getboxsongs = get_allsongsbox();
  List<DBSongs> Songlist = [];
  bool _isnotfavorite = false;
  List<AudioSource> audioSourceList = [];

  _miniplayerState();

  @override
  void initState() {
    Songlist = getboxsongs.values.toList().cast();
    convertSongModelToAudioSource();

    // TODO: implement initState
    super.initState();
    playSongPlaylist();
  }

  playSongPlaylist() async {
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioSourceList,
    );
    await audioPlayer.setAudioSource(
      playlist,
      initialIndex: audioPlayer.currentIndex,
      //initialPosition: Duration.zero,
    );
  }

  convertSongModelToAudioSource() {
    for (var song in Songlist) {
      audioSourceList.add(
        AudioSource.uri(
          Uri.parse(song.uri),
          tag: MediaItem(
            // displayTitle: ,
            id: song.id.toString(),
            // album: "${widget.songModel.album}",
            title: song.title,
            // artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
        valueListenable: onPressedIndex,
        builder: (BuildContext context, int value, Widget? child) {
          int currentIndexValue = value;

          return GestureDetector(
            onTap: () {
              log(Songlist[currentIndexValue].title);
              setState(() async {
                currentIndexValue = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Screennowplaying(
                        item: Songlist,
                        index: currentIndexValue,
                        Uri: Songlist[currentIndexValue].uri,
                        songModel: Songlist[currentIndexValue],
                        musicname: Songlist[currentIndexValue].title,
                      );
                    },
                  ),
                );
              });
            },
            child: Container(
              height: screenHeight * 0.112,
              width: screenwidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: darkblack,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Container(
                      height: screenHeight * 0.07,
                      width: screenwidth * 0.14,
                      child: QueryArtworkWidget(
                        id: int.parse(Songlist[currentIndexValue].id),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Image.network(
                            'https://play-lh.googleusercontent.com/mOkjjo5Rzcpk7BsHrsLWnqVadUK1FlLd2-UlQvYkLL4E9A0LpyODNIQinXPfUMjUrbE'),
                        artworkFit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenwidth * 0.023,
                          vertical: screenHeight * 0.03),
                      child: Container(
                        width: screenwidth * 0.252,
                        child: Column(
                          children: [
                            Text(
                              Songlist[currentIndexValue].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: purewhite,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              Songlist[currentIndexValue].artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: grey,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            favorites.AddingToFavorites(
                                context: context,
                                id: Songlist[
                                        // currentIndexValue
                                        currentIndexValue]
                                    .id);
                            setState(() {
                              favorites.isThisFavourite(
                                  id: Songlist[currentIndexValue].id);
                            });
                          });
                        },
                        icon: Icon(
                          favorites.isThisFavourite(
                              id: Songlist[currentIndexValue].id),
                          size: 24,
                          color: pink,
                        )),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  JustAudio.previousplay();
                                });
                              },
                              icon: Icon(
                                Icons.skip_previous_outlined,
                                color: white,
                              )),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (audioPlayer.playing) {
                                  audioPlayer.pause();
                                } else {
                                  audioPlayer.play();
                                }
                              });
                            },
                            icon: Icon(audioPlayer.playing
                                ? Icons.pause_circle_outline_outlined
                                : Icons.play_circle_outline),
                            color: white,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  // if (audioPlayer.hasNext) {
                                  //   audioPlayer.seekToNext();
                                  // }
                                  JustAudio.nextplay();
                                });
                              },
                              icon: Icon(
                                Icons.skip_next_outlined,
                                color: white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
