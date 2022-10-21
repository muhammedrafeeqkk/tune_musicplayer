import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/functions/playlists.dart';

import 'package:music_player/screeens/home.dart';
import 'package:music_player/screeens/miniplayerbottomsheet.dart';
import 'package:music_player/screeens/screenfavorites.dart';
import 'package:music_player/screeens/screenliabrary.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Musics extends StatefulWidget {
  Musics({
    Key? key,
    required this.index,
    required this.item,
    this.conditionalicon,
    required this.iconwant,
    required this.isithomepage,
    // required this.audioPlayer,
    required this.playlistname,
  }) : super(key: key);

  final int index;
  final List<DBSongs> item;
  final bool? conditionalicon;
  final bool iconwant;
  final bool isithomepage;
  final String playlistname;

  @override
  State<Musics> createState() => _MusicsState();
}

class _MusicsState extends State<Musics> {
  Playsong(String uri) {
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return widget.isithomepage == true
        ? ValueListenableBuilder(
            valueListenable: onPressedIndex,
            builder: (BuildContext context, int value, Widget? child) {
              return ListTile(
                onTap: () {
                  Playsong(widget.item[widget.index].uri);
                  log('koi');
                  // miniplayer_showmodelsheet(context: context);

                  setState(() {
                    onPressedIndex.value = widget.index;
                    onPressedIndex.notifyListeners();

                    //   log(onPressedIndex.value.toString());
                  });
                },
                // onTap: Playsong(item[index].uri!),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                title: Text(
                  widget.item[widget.index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: purewhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  widget.item[widget.index].artist == '<unknown>'
                      ? 'unknown'
                      : widget.item[widget.index].artist,
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
                        child: Icon(
                          Icons.play_arrow,
                          color: purewhite,
                        )),
                    widget.iconwant == true
                        ? widget.conditionalicon == true
                            ? PopupMenuButton(
                                color: darkblack,
                                icon: Icon(
                                  Icons.more_vert_outlined,
                                  color: white,
                                ),
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                favorites.AddingToFavorites(
                                                    context: context,
                                                    id: widget
                                                        .item[widget.index].id);
                                                setState(() {
                                                  favorites.isThisFavourite(
                                                      id: widget
                                                          .item[widget.index]
                                                          .id);
                                                });
                                              },
                                              icon: Icon(
                                                favorites.isThisFavourite(
                                                    id: widget
                                                        .item[widget.index].id),
                                                color: pink,
                                              ),
                                              label: Text(
                                                'Favorite',
                                                style: TextStyle(color: grey),
                                              ))),
                                      PopupMenuItem(
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                PlaylistModelBottomSheet(
                                                    context: context,
                                                    Song: widget
                                                        .item[widget.index]);
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
                                                            playlistname: widget
                                                                .playlistname,
                                                            SongId: widget
                                                                .item[widget
                                                                    .index]
                                                                .id,
                                                            context: context);
                                                    log(widget.playlistname);
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
              setState(() {
                newIndex.value = widget.index;
                newIndex.notifyListeners();
              });
            }),
            contentPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            title: Text(
              widget.item[widget.index].title,
              style: TextStyle(
                  color: purewhite, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              widget.item[widget.index].artist,
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
                    child: Icon(
                      Icons.play_arrow,
                      color: purewhite,
                    )),
                widget.iconwant == true
                    ? widget.conditionalicon == true
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
                                        PopupMenuItem(
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  favorites.AddingToFavorites(
                                                      context: context,
                                                      id: widget
                                                          .item[widget.index]
                                                          .id);
                                                  setState(() {
                                                    favorites.isThisFavourite(
                                                        id: widget
                                                            .item[widget.index]
                                                            .id);
                                                  });
                                                },
                                                icon: ValueListenableBuilder(
                                                    valueListenable:
                                                        onPressedIndex,
                                                    builder: (context, value,
                                                        child) {
                                                      return Icon(favorites
                                                          .isThisFavourite(
                                                              id: widget
                                                                  .item[widget
                                                                      .index]
                                                                  .id));
                                                    }),
                                                label: Text(
                                                  'Favorite',
                                                  style: TextStyle(color: grey),
                                                ))),
                                        PopupMenuItem(
                                            child: TextButton.icon(
                                                onPressed: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScreenLibrary(
                                                              item: widget.item,
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
                                                    playlistname:
                                                        widget.playlistname,
                                                    SongId: widget
                                                        .item[widget.index].id,
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
