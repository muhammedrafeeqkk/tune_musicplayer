import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/applications/playlistGridView/playlists_bloc.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/presentation/inside_library/screen_insideLibrary.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/music.dart';

import 'package:music_player/widgets/new_create_playlist_show_dailouge.dart';

import '../../applications/playlistGridView/playlists_bloc.dart';
import '../../widgets/customgrid.dart';

class ScreenLibrary extends StatelessWidget {
  ScreenLibrary({
    Key? key,
    required this.item,
    required this.audioPlayer,
  }) : super(key: key);

  final List<DBSongs> item;
  final AssetsAudioPlayer audioPlayer;

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistsBloc>(context).add(Getplaylistnames());
    });

    final songId = audioPlayer.id;
    final currentindex = currentsongindex(songId: songId);

    PlayerBuilder.isPlaying(
      player: audioPlayer,
      builder: (context, isPlaying) {
        return newminiplayer(
            context: context,
            item: item,
            index: currentindex,
            audioPlayer: audioPlayer);
      },
    );

    return BlocBuilder<PlaylistsBloc, PlaylistsState>(
      builder: (context, state) {
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
              Expanded(
                flex: 14,
                child: state.playlistkeyname.isEmpty
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
                          itemCount: state.playlistkeyname.length,
                          padding: EdgeInsets.all(screenWidth * 0.042),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: (5 / 4)),
                          itemBuilder: (BuildContext context, int index) {
                            final String playlistkeyname =
                                state.playlistkeyname[index];

                            return Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => screencarlibrary(
                                            audioPlayer: audioPlayer,
                                            index: index,
                                             newkeys: playlistkeyname
                                            ),
                                      ));
                                },
                                child: customgrid(
                                  color: pink,
                                  playlistkeyname: playlistkeyname,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),

              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  currentsongindex({required songId}) {
    final currentIndex = item.indexWhere((element) => element.id == songId);
    return currentIndex;
  }
}
