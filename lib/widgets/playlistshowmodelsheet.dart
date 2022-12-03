import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/new_create_playlist_show_dailouge.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.09,
                    width: screenwidth * 0.2,
                    child: QueryArtworkWidget(
                        artworkWidth: 400,
                        artworkHeight: 400,
                        artworkBorder: BorderRadius.circular(90),
                        id: int.parse(Song.id),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: Container(
                          height: screenHeight * 0.09,
                          width: screenwidth * 0.2,
                          decoration: BoxDecoration(
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(90)),
                          child: Icon(
                            Icons.music_note,
                            size: 25,
                            color: grey,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenwidth * 0.8,
                    child: Center(
                      child: Text(
                        Song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    width: screenwidth * 0.45,
                    child: Center(
                      child: Text(
                        Song.artist == '<unknown>' ? 'unknown' : Song.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color: skyblack,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
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
                keys.removeWhere((item) => item.contains(
                      'favorites',
                    ));

                keys.removeWhere((element) => element.contains('recent'));

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
                              style: TextStyle(fontSize: 11),
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
