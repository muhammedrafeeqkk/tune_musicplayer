import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/new_create_playlist_show_dailouge.dart';

import '../db/db_functions/db_models/data_model.dart';

PlaylistModelBottomSheet({required context, required DBSongs Song}) {
  final screenwidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  Box<List> getplaylistBox = get_adding_lists();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 900,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: screenwidth * 0.35,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: grey),
                child: Center(
                  child: Text(
                    'Add Playlist',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: skyblack),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  new_playlist_creating_widget(context: context);
                },
                icon: Icon(Icons.add)),
            ValueListenableBuilder(
              valueListenable: getplaylistBox.listenable(),
              builder: (context, value, child) {
                List<String> keys = getplaylistBox.keys.toList().cast();
                keys.removeWhere((item) => item.contains('favorites'));

                return Expanded(
                    child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: keys.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    final String playlistKey = keys[index];
                    final List<DBSongs> playlistValues = getplaylistBox
                        .get(playlistKey)!
                        .toList()
                        .cast<DBSongs>();
                    final songlist = playlistValues.toList().cast<DBSongs>();

                    return Container(
                        decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                            onLongPress: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        title: Text('Do you Want To Delete'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                            ),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                getplaylistBox
                                                    .delete(playlistKey);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                'Successfully Deleted',
                                                                style:
                                                                    TextStyle(
                                                                  color: grey,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                playlistKey,
                                                                style:
                                                                    TextStyle(
                                                                  color: grey,
                                                                  fontSize: 8,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )));
                                              },
                                              child: Text('YES')),
                                        ],
                                      )));
                            },
                            onTap: (() {
                              Navigator.pop(context);
                              Playlists.AddingToPlaylist(
                                  playlistname: playlistKey,
                                  SongId: Song.id,
                                  context: context);
                            }),
                            leading: Icon(
                              Icons.playlist_add_check,
                              size: 35,
                            ),
                            title: Text(playlistKey),
                            subtitle: Text(
                              '${songlist.length} song',
                            )));
                  },
                ));
              },
            )
          ],
        ),
      );
    },
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  );
}
