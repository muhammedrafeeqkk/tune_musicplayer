import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/applications/favorites/favorites/favorites_bloc.dart';

import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/functions/playlist_rename.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/presentation/library/screen%20_liabrary.dart';
import 'package:music_player/presentation/home/screen_home.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../presentation/favorites/screen_favorites.dart';
import '../presentation/mini_player/screen_miniplayer.dart';

class Musics extends StatelessWidget {
  Musics({
    Key? key,
    required this.index,
    required this.item,
    this.conditionalicon,
    required this.iconwant,
    required this.isithomepage,
    required this.playlistname,
    required this.audioPlayer,
  }) : super(key: key);
  final AssetsAudioPlayer audioPlayer;
  final int index;
  final List<DBSongs> item;
  final bool? conditionalicon;
  final bool iconwant;
  final bool isithomepage;
  final String playlistname;

//   @override
//   State<Musics> createState() => _MusicsState();
// }

// class _MusicsState extends State<Musics> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return isithomepage == true
        ? ValueListenableBuilder(
            valueListenable: onPressedIndex,
            builder: (BuildContext context, int value, Widget? child) {
              return ListTile(
                onTap: () {
                  newminiplayer(
                      audioPlayer: audioPlayer,
                      context: context,
                      index: index,
                      item: item);
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                title: Text(
                  item[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: purewhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  item[index].artist == '<unknown>'
                      ? 'unknown'
                      : item[index].artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: grey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //     height: screenHeight * 0.04,
                    //     width: screenWidth * 0.09,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         color: darkblack),
                    //     child:
                    //     Icon(
                    //       Icons.play_arrow,
                    //       color: purewhite,
                    //     )),
                    iconwant == true
                        ? conditionalicon == true
                            ? PopupMenuButton(
                                color: darkblack,
                                icon: Icon(
                                  Icons.more_vert_outlined,
                                  color: white,
                                ),
                                itemBuilder: (context) => [
                                      PopupMenuItem(child: BlocBuilder<
                                          FavoritesBloc, FavoritesState>(
                                        builder: (context, state) {
                                          return TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                favorites.AddingToFavorites(
                                                    context: context,
                                                    id: item[index].id);
                                                BlocProvider.of<FavoritesBloc>(
                                                        context)
                                                    .add(const Favorite());

                                                favorites.isThisFavourite(
                                                    id: item[index].id);
                                              },
                                              icon: Icon(
                                                favorites.isThisFavourite(
                                                    id: item[index].id),
                                                color: pink,
                                              ),
                                              label: Text(
                                                'Favorite',
                                                style: TextStyle(color: grey),
                                              ));
                                        },
                                      )),
                                      PopupMenuItem(
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                PlaylistModelBottomSheet(
                                                    context: context,
                                                    Song: item[index]);
                                              },
                                              icon: Icon(
                                                Icons.playlist_add,
                                                color: grey,
                                              ),
                                              label: Text(
                                                'Add library',
                                                style: TextStyle(color: grey),
                                              )))
                                    ])
                            : IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            title: Text(
                                              'Are  You Sure',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'NO'),
                                                child: const Text(
                                                  'NO',
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Playlists
                                                        .RemovingToPlaylist(
                                                            playlistname:
                                                                playlistname,
                                                            SongId:
                                                                item[index].id,
                                                            context: context);
                                                    log(playlistname);
                                                  },
                                                  child: Text('YES'))
                                            ],
                                          ));
                                },
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: white,
                                ),
                              )
                        : SizedBox(),
                  ],
                ),
              );
            })
        //withoutHomepage
        : ListTile(
            onTap: (() {
              //////////////////////////////
              newIndex.value = index;
              newIndex.notifyListeners();
              ////////////////////////
            }),
            contentPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            title: Text(
              item[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: purewhite, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              item[index].artist == '<unknown>'
                  ? 'unknown'
                  : item[index].artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: grey, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.09,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: darkblack),
                    child: GestureDetector(
                      onTap: () {
                        newminiplayer(
                            context: context,
                            item: item,
                            index: index,
                            audioPlayer: audioPlayer);
                      },
                      child: Icon(
                        Icons.play_arrow,
                        color: purewhite,
                      ),
                    )),
                iconwant == true
                    ? conditionalicon == true
                        ? ValueListenableBuilder(
                            valueListenable: onPressedIndex,
                            builder: ((context, value, child) {
                              return PopupMenuButton(
                                  color: darkblack,
                                  icon: Icon(
                                    Icons.more_vert_outlined,
                                    color: white,
                                  ),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(child: BlocBuilder<
                                            FavoritesBloc, FavoritesState>(
                                          builder: (context, state) {
                                            return TextButton.icon(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  favorites.AddingToFavorites(
                                                      context: context,
                                                      id: item[index].id);
                                                  BlocProvider.of<
                                                              FavoritesBloc>(
                                                          context)
                                                      .add(Favorite());

                                                  favorites.isThisFavourite(
                                                      id: item[index].id);
                                                },
                                                icon: ValueListenableBuilder(
                                                    valueListenable:
                                                        onPressedIndex,
                                                    builder: (context, value,
                                                        child) {
                                                      return Icon(favorites
                                                          .isThisFavourite(
                                                              id: item[index]
                                                                  .id));
                                                    }),
                                                label: Text(
                                                  'Favorite',
                                                  style: TextStyle(color: grey),
                                                ));
                                          },
                                        )),
                                        PopupMenuItem(
                                            child: TextButton.icon(
                                                onPressed: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScreenLibrary(
                                                              audioPlayer:
                                                                  audioPlayer,
                                                              item: item,
                                                            ))),
                                                icon: Icon(
                                                  Icons.playlist_add,
                                                  color: grey,
                                                ),
                                                label: Text(
                                                  'Add library',
                                                  style: TextStyle(color: grey),
                                                )))
                                      ]);
                            }))
                        : IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                          'Are You Sure',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'NO'),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Playlists.RemovingToPlaylist(
                                                    playlistname: playlistname,
                                                    SongId: item[index].id,
                                                    context: context);
                                              },
                                              child: Text('YES'))
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: white,
                            ),
                          )
                    : SizedBox(),
              ],
            ),
          );
  }
}

newminiplayer(
    {required BuildContext context,
    required List<DBSongs> item,
    required int index,
    required AssetsAudioPlayer audioPlayer}) {
  return showBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    context: context,
    builder: (context) {
      return MiniPlayer(
        audioPlayer: audioPlayer,
        songList: item,
        index: index,
      );
    },
  );
}
