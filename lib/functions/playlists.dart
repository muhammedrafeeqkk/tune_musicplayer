import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

import '../db/db_functions/db_function.dart';
import '../db/db_functions/db_models/data_model.dart';

class Playlists {
  static final Box<List> PlaylistBox = get_adding_lists();
  static final Box<DBSongs> songBox = get_allsongsbox();
  static AddingToPlaylist(
      {required String playlistname,
      required String SongId,
      required context}) async {
    List<DBSongs> PlayListSongs =
        get_adding_lists().get(playlistname)!.toList().cast<DBSongs>();
    List<DBSongs> allsong = songBox.values.toList().cast<DBSongs>();
    DBSongs songs =
        allsong.firstWhere((element) => element.id.contains(SongId));
    if (PlayListSongs.contains(songs)) {
      showPlaylistSnackbar(
          context: context,
          songName: songs.title,
          message: 'Already Exist in the playlist');
    } else {
      (PlayListSongs.add(songs));
      PlaylistBox.put(playlistname, PlayListSongs);
      showPlaylistSnackbar(
          context: context,
          songName: songs.title,
          message: 'Added in Playlist');
    }
  }

  static RemovingToPlaylist({
    required String playlistname,
    required String SongId,
    required context,
  }) async {
    List<DBSongs> PlayListSongs =
        get_adding_lists().get(playlistname)!.toList().cast<DBSongs>();
    List<DBSongs> allsong = songBox.values.toList().cast<DBSongs>();
    DBSongs songs =
        allsong.firstWhere((element) => element.id.contains(SongId));
    PlayListSongs.removeWhere((element) => element.id == SongId);
    await PlaylistBox.put(playlistname, PlayListSongs);
    showPlaylistSnackbar(
        context: context,
        songName: songs.title,
        message: 'Deleted from playlist');
  }

  static void showPlaylistSnackbar({
    required BuildContext context,
    required String songName,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: skyblack,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: Text(
                songName,
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
