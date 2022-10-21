import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/functions/just_audioplayer.dart';

import 'package:music_player/screeens/screenliabrary.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/just_audioplayer.dart';

class Screennowplaying extends StatefulWidget {
  const Screennowplaying({
    Key? key,
    required this.item,
    required this.Uri,
    required this.index,
    required this.musicname,
    required this.songModel,
  }) : super(key: key);
  final DBSongs songModel;
  final List<DBSongs> item;
  final String Uri;
  final int index;
  final String musicname;

  @override
  State<Screennowplaying> createState() => _ScreennowplayingState();
}

class _ScreennowplayingState extends State<Screennowplaying> {
  // final AudioPlayer justaudioplayer = AudioPlayer.withId('0');
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isshuffled = true;

  bool _isnotfavorite = true;
  List<AudioSource> audioSourceList = [];

  @override
  void initState() {
    convertSongModelToAudioSource();

    super.initState();
    playSongPlaylist();

    //Playsong(widget.Uri);
  }

  playSongPlaylist() async {
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audioSourceList,
    );
    await audioPlayer.setAudioSource(
      playlist,
      initialIndex: widget.index,
      //initialPosition: Duration.zero,
    );

    await audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    await audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

//forConverting SongModel to AudioSource
  convertSongModelToAudioSource() {
    for (var song in widget.item) {
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

  // Playsong(String uri) {
  //   try {
  //     widget.audioPlayer.setAudioSource(AudioSource.uri(
  //       Uri.parse(uri),
  //       tag: MediaItem(
  //         // displayTitle: ,
  //         id: '${widget.songModel.id}',
  //         // album: "${widget.songModel.album}",
  //         title: widget.songModel.displayNameWOExt,
  //         artUri: Uri.parse('https://example.com/albumart.jpg'),
  //       ),
  //     ));
  //     widget.audioPlayer.play();
  //     _isplaying = true;
  //   } on Exception {
  //     log('no parse songes');
  //   }
  //   widget.audioPlayer.durationStream.listen((d) {
  //     setState(() {
  //       _duration = d!;
  //     });
  //   });
  //   widget.audioPlayer.positionStream.listen((p) {
  //     setState(() {
  //       _position = p;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // final   AudioPlayer  justAudio =AudioPlayer.withId('0');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            // log(audioPlayer.sequenceState.currentIndex);
            // Navigator.pop(context, audioPlayer.currentIndex);
          },
        ),
        centerTitle: true,
        title: Text('Now Playing'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.02, left: screenwidth * 0.1),
                child: Container(
                  height: screenHeight * 0.2,
                  width: screenwidth * 0.53,
                  child: QueryArtworkWidget(
                    id: int.parse(widget.item[audioPlayer.currentIndex!].id),
                    artworkFit: BoxFit.fill,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.network(
                      'https://play-lh.googleusercontent.com/mOkjjo5Rzcpk7BsHrsLWnqVadUK1FlLd2-UlQvYkLL4E9A0LpyODNIQinXPfUMjUrbE',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () => PlaylistModelBottomSheet(
                          Song: widget.item[widget.index], context: context),
                      icon: Icon(
                        Icons.playlist_add_outlined,
                        size: 40,
                        color: grey,
                      )),
                  IconButton(
                      onPressed: (() {
                        favorites.AddingToFavorites(
                            context: context,
                            id: widget.item[audioPlayer.currentIndex!].id);
                        setState(() {
                          favorites.isThisFavourite(
                              id: widget.item[audioPlayer.currentIndex!].id);
                          // _isnotfavorite = !_isnotfavorite;
                        });
                      }),
                      icon: Icon(
                        favorites.isThisFavourite(
                            id: widget.item[audioPlayer.currentIndex!].id),
                        size: 30,
                        color: pink,
                      )),
                  IconButton(
                      onPressed: (() {
                        setState(() {
                          _isshuffled = !_isshuffled;
                        });
                      }),
                      icon: _isshuffled
                          ? Icon(Icons.shuffle, size: 30, color: grey
                              // color: pink,
                              )
                          : Icon(
                              Icons.shuffle,
                              size: 30,
                              color: pink,
                            )),
                ],
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Center(
                child: Text(
                  //  convertSongModelToAudioSource().index.,
                  widget.item[audioPlayer.currentIndex!].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  // widget.audioPlayer.sequenceState!.currentSource!.tag
                  //     as String,
                  style: TextStyle(
                      color: purewhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Center(
                child: Text(
                  widget.item[audioPlayer.currentIndex!].artist,

                  // widget.songModel.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: grey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.09,
          ),
          Container(
            width: screenwidth * 0.99,
            child: Slider(
              min: Duration(microseconds: 0).inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble(),
              onChanged: ((value) {
                setState(() {
                  changeToSeconds(value.toInt());
                  value = value;
                });
              }),
              activeColor: pink,
              inactiveColor: grey,
              thumbColor: pink,
            ),
          ),
          Container(
            width: screenwidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split('.')[0],
                  style: TextStyle(color: grey),
                ),
                // "${_position.inHours}:${_position.inMinutes.remainder(60)}:${(_position.inSeconds.remainder(60))}"),
                // '${_position.toString().split("0")[0]}'),
                Text(
                  _duration.toString().split('.')[0],
                  // "${_duration.inMinutes.remainder(60)}:${(_duration.inSeconds.remainder(60))}",
                  // '${_duration.toString().split("0")[0]}',
                  style: TextStyle(color: grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Column(
            children: [
              Container(
                width: screenwidth * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: darkblack,
                      child: IconButton(
                          onPressed: () {
                            JustAudio.previousplay();
                            // if (audioPlayer.hasPrevious) {
                            //   audioPlayer.seekToPrevious();
                            // }
                          },
                          icon: Icon(
                            Icons.skip_previous,
                            color: pink,
                            size: 35,
                          )),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: pink,
                      child: Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (audioPlayer.playing) {
                                  audioPlayer.pause();
                                } else {
                                  audioPlayer.play();
                                }
                              });
                            },
                            icon: Icon(
                              audioPlayer.playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: darkblack,
                      child: IconButton(
                          onPressed: () {
                            JustAudio.nextplay();
                            // if (audioPlayer.hasNext) {
                            //   audioPlayer.seekToNext();
                            // }
                          },
                          icon: Icon(
                            Icons.skip_next,
                            color: pink,
                            size: 35,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.10,
          ),
          Text(
            'NEXT',
            style: TextStyle(
                color: purewhite, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(
            _isshuffled
                ? widget.item[audioPlayer.nextIndex!].title
                : 'Shuffled',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: purewhite, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              _isshuffled ? widget.item[audioPlayer.nextIndex!].artist : '  ',
              style: TextStyle(
                  color: grey, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    // Widget.audioPlayer.seek(Duration())
    audioPlayer.seek(duration);
  }
}
