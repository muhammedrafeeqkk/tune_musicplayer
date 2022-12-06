import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/applications/playlistGridView/playlists_bloc.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/playlist_rename.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

customgrid({
  required color,
  required String playlistkeyname,
}) {
  return Builder(builder: (context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    Box<List> getplaylistBox = get_adding_lists();
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: GridTile(
        child: Column(
          children: [],
        ),
        footer: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            playlistkeyname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        header: Padding(
            padding: EdgeInsets.only(left: 105),
            child: BlocBuilder<PlaylistsBloc, PlaylistsState>(
              builder: (context, state) {
                return PopupMenuButton(
                    // color: darkblack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: Icon(
                      Icons.more_vert,
                      color: white,
                      size: 30,
                    ),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            title:
                                                Text('Do you Want To Delete'),
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
                                                    getplaylistBox.delete(
                                                        playlistkeyname);
                                                    BlocProvider.of<
                                                                PlaylistsBloc>(
                                                            context)
                                                        .add(
                                                            Getplaylistnames());

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
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
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Center(
                                                                  child: Text(
                                                                    'Successfully Deleted',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          grey,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Center(
                                                                  child: Text(
                                                                    playlistkeyname,
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          grey,
                                                                      fontSize:
                                                                          8,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )));
                                                    // Navigator.pop(context);
                                                  },
                                                  child: Text('YES')),
                                            ],
                                          )));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: grey,
                                ),
                                label: Text(
                                  'Delete',
                                  style: TextStyle(color: grey),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  playlist.playlistRename(
                                    context: context,
                                    playlistkeyoldname: playlistkeyname,
                                  );
                                  BlocProvider.of<PlaylistsBloc>(context)
                                      .add(Getplaylistnames());
                                },
                                icon: Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: grey,
                                ),
                                label: Text('Rename',
                                    style: TextStyle(color: grey)),
                              )
                            ],
                          ))
                        ]);
              },
            )),
      ),
    );
  });
}
