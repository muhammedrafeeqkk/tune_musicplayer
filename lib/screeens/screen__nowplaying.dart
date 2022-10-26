import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/db_functions/db_function.dart';

import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Screennowplaying extends StatefulWidget {
  const Screennowplaying({
    Key? key,
    required this.item,
    required this.audioPlayer,
    required this.index,
  }) : super(key: key);
  final List<Audio> item;
  final AssetsAudioPlayer audioPlayer;
  final int index;

  @override
  State<Screennowplaying> createState() => _ScreennowplayingState();
}

class _ScreennowplayingState extends State<Screennowplaying> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  List<DBSongs> songList = [];
  bool _isshuffled = true;

  bool _isnotfavorite = true;

  @override
  void initState() {
    super.initState();
    songList = get_allsongsbox().values.toList().cast<DBSongs>();
    //Playsong(widget.Uri);
  }

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
            Navigator.pop(context);
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
          widget.audioPlayer.builderCurrent(builder: (context, playing) {
            final myAudio = find(widget.item, playing.audio.assetAudioPath);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01,
                      left: screenwidth * 0.1,
                      bottom: screenHeight * 0.02),
                  child: Container(
                    width: screenwidth * 0.53,
                    height: screenHeight * 0.17,
                    child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(25),
                        id: int.parse(myAudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          width: screenwidth * 0.53,
                          height: screenHeight * 0.17,
                          decoration: BoxDecoration(
                              border: Border.all(color: darkblack),
                              borderRadius: BorderRadius.circular(25)),
                          child: Icon(
                            Icons.music_note,
                            size: 55,
                          ),
                        )),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () => PlaylistModelBottomSheet(
                            Song: songList[widget.index], context: context),
                        icon: Icon(
                          Icons.playlist_add_outlined,
                          size: 40,
                          color: grey,
                        )),
                    IconButton(
                        onPressed: (() {
                          favorites.AddingToFavorites(
                              context: context, id: myAudio.metas.id!);
                          setState(() {
                            favorites.isThisFavourite(id: myAudio.metas.id!);
                            // _isnotfavorite = !_isnotfavorite;
                          });
                        }),
                        icon: Icon(
                          favorites.isThisFavourite(id: myAudio.metas.id!),
                          size: 30,
                          color: pink,
                        )),
                    IconButton(
                        onPressed: (() {
                          setState(() {
                            assetAudioplayineTools.shufflesong(
                                audioPlayer: widget.audioPlayer);
                          });
                        }),
                        icon: widget.audioPlayer.shuffle
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
            );
          }),
          widget.audioPlayer.builderCurrent(builder: (context, Playing) {
            final myAudio = find(widget.item, Playing.audio.assetAudioPath);

            return Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  width: screenwidth * 0.8,
                  child: Center(
                    child: Text(
                      myAudio.metas.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: purewhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  width: screenwidth * 0.45,
                  child: Center(
                    child: Text(
                      myAudio.metas.artist == '<unknown>'
                          ? 'unknown'
                          : myAudio.metas.artist!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            );
          }),
          SizedBox(
            height: screenHeight * 0.09,
          ),
          widget.audioPlayer.builderRealtimePlayingInfos(
              builder: (context, realTimeInfos) {
            final current = realTimeInfos.currentPosition;
            final duration = realTimeInfos.duration;
            return Column(
              children: [
                Container(
                  width: screenwidth * 0.99,
                  child: Slider(
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    value: current.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
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
                        current.toString().split('.')[0],
                        style: TextStyle(color: grey),
                      ),
                      // "${_position.inHours}:${_position.inMinutes.remainder(60)}:${(_position.inSeconds.remainder(60))}"),
                      // '${_position.toString().split("0")[0]}'),
                      Text(
                        duration.toString().split('.')[0],
                        // "${_duration.inMinutes.remainder(60)}:${(_duration.inSeconds.remainder(60))}",
                        // '${_duration.toString().split("0")[0]}',
                        style: TextStyle(color: grey),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
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
                            setState(() {
                              assetAudioplayineTools.previousplay(
                                  audioPlayer: widget.audioPlayer);
                            });
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
                          child: PlayerBuilder.isPlaying(
                              player: widget.audioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  onPressed: () {
                                    setState(() {
                                      assetAudioplayineTools.playbutton(
                                          audioPlayer: widget.audioPlayer);
                                    });
                                  },
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 35,
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: darkblack,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              assetAudioplayineTools.nextplay(
                                  audioPlayer: widget.audioPlayer);
                            });
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
          widget.audioPlayer.builderCurrent(builder: (context, Playing) {
            final myAudio = find(widget.item, Playing.audio.assetAudioPath);
            int currentSongIndex = upcommingsongindex(songId: myAudio.metas.id);

            return Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.10,
                ),
                Text(
                  'NEXT',
                  style: TextStyle(
                      color: purewhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  width: screenwidth * 0.8,
                  child: Center(
                    child: Text(
                      widget.item[currentSongIndex + 1].metas.title!,
                      // _isshuffled
                      //     ? widget.item[currentSongIndex+1].metas.title!
                      //     : 'Shuffled',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: purewhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    width: screenwidth * 0.45,
                    child: Center(
                      child: Text(
                        widget.item[currentSongIndex + 1].metas.artist ==
                                '<unknown>'
                            ? 'unknown'
                            : widget.item[currentSongIndex + 1].metas.artist!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    // Widget.audioPlayer.seek(Duration())
    widget.audioPlayer.seek(duration);
  }

  upcommingsongindex({required songId}) {
    final songcurrentindex =
        songList.indexWhere((element) => element.id == songId);
    return songcurrentindex;
  }
}
