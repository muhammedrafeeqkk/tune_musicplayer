import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/screen__nowplaying.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:on_audio_query/on_audio_query.dart';
List<Audio> songAudioList = [];
class MiniPlayer extends StatefulWidget {
  const MiniPlayer(
      {Key? key,
      required this.audioPlayer,
      required this.songList,
      required this.index})
      : super(key: key);

  final AssetsAudioPlayer audioPlayer;
  final List<DBSongs> songList;
  final int index;
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  convertDbSongToAudio() {
    for (var song in widget.songList) {
      Audio audio = Audio.file(song.uri,
          metas: Metas(title: song.title, artist: song.artist, id: song.id));
      songAudioList.add(audio);
    }
  }

  playAudioSong() {
    widget.audioPlayer.open(
      Playlist(
        audios: songAudioList,
        startIndex: widget.index,
      ),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void initState() {
    convertDbSongToAudio();
    playAudioSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return widget.audioPlayer.builderCurrent(
      builder: (context, playing) {
        final myAudio = find(songAudioList, playing.audio.assetAudioPath);
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: skyblack),
          height: screenHeight * 0.105,
          width: screenWidth,
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Screennowplaying(
                  item: songAudioList,
                  audioPlayer: widget.audioPlayer,
                  index: widget.index,
                );
              }));
            },
            leading: Container(
              width: screenWidth * 0.125,
              height: screenHeight * 0.1,
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                id: int.parse(myAudio.metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Container(
                  width: screenWidth * 0.125,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.music_note,
                    size: 25,
                    color: grey,
                  ),
                ),
              ),
            ),
            title: Container(
              child: Text(
                widget.audioPlayer.getCurrentAudioTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: purewhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            subtitle: Container(
              child: Text(
                widget.audioPlayer.getCurrentAudioArtist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: grey, fontSize: 9, fontWeight: FontWeight.w400),
              ),
            ),
            trailing: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          favorites.AddingToFavorites(
                              context: context,
                              id: songAudioList[widget.index].metas.id!);
                          setState(() {
                            favorites.isThisFavourite(
                                id: songAudioList[widget.index].metas.id!);
                          });
                        });
                      },
                      icon: Icon(
                        favorites.isThisFavourite(
                            id: songAudioList[widget.index].metas.id!),
                        size: 24,
                        color: pink,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          assetAudioplayineTools.previousplay(
                              audioPlayer: widget.audioPlayer);
                        });
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        color: grey,
                      )),
                  PlayerBuilder.isPlaying(
                      player: widget.audioPlayer,
                      builder: (context, isPlaying) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              assetAudioplayineTools.playbutton(
                                  audioPlayer: widget.audioPlayer);
                            });
                          },
                          icon: isPlaying
                              ? Icon(Icons.pause_circle_outline_outlined)
                              : Icon(Icons.play_circle_outline),
                          color: white,
                        );
                      }),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          assetAudioplayineTools.nextplay(
                              audioPlayer: widget.audioPlayer);
                        });
                      },
                      icon: Icon(
                        Icons.skip_next,
                        color: grey,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
