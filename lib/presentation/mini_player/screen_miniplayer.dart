import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/applications/favorites/favorites/favorites_bloc.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/functions/recent.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../now_playing/screen_nowplaying.dart';

List<Audio> songAudioList = [];

class MiniPlayer extends StatelessWidget {
  const MiniPlayer(
      {Key? key,
      required this.audioPlayer,
      required this.songList,
      required this.index})
      : super(key: key);

  final AssetsAudioPlayer audioPlayer;
  final List<DBSongs> songList;
  final int index;
//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  convertDbSongToAudio() {
    for (var song in songList) {
      Audio audio = Audio.file(song.uri,
          metas: Metas(title: song.title, artist: song.artist, id: song.id));
      songAudioList.add(audio);
    }
  }

  playAudioSong() {
    audioPlayer.open(
      Playlist(
        audios: songAudioList,
        startIndex: index,
      ),
      showNotification: true,
      autoStart: true,
    );
  }

  void initState() {
    convertDbSongToAudio();
    playAudioSong();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        final myAudio = find(songAudioList, playing.audio.assetAudioPath);
        recent.addingSonginRecent(SongId: myAudio.metas.id!);
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
                  audioPlayer: audioPlayer,
                  index: index,
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
                audioPlayer.getCurrentAudioTitle,
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
                audioPlayer.getCurrentAudioArtist=='<unknown>'?'unknown':audioPlayer.getCurrentAudioArtist,
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
                  BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            favorites.AddingToFavorites(
                                context: context,
                                id: songAudioList[index].metas.id!);

                            favorites.isThisFavourite(
                                id: songAudioList[index].metas.id!);
                             BlocProvider.of<FavoritesBloc>(context).add( const Favorite());
                          },
                          icon: Icon(
                            favorites.isThisFavourite(
                                id: songAudioList[index].metas.id!),
                            size: 24,
                            color: pink,
                          ));
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        assetAudioplayineTools.previousplay(
                            audioPlayer: audioPlayer);
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        color: grey,
                      )),
                  PlayerBuilder.isPlaying(
                      player: audioPlayer,
                      builder: (context, isPlaying) {
                        return IconButton(
                          onPressed: () {
                            assetAudioplayineTools.playbutton(
                                audioPlayer: audioPlayer);
                          },
                          icon: isPlaying
                              ? Icon(Icons.pause_circle_outline_outlined)
                              : Icon(Icons.play_circle_outline),
                          color: white,
                        );
                      }),
                  IconButton(
                      onPressed: () {
                        assetAudioplayineTools.nextplay(
                            audioPlayer: audioPlayer);
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
