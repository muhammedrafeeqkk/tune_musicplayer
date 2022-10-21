import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

class favorites {
  static final Box<List> PlaylistBox = get_adding_lists();
  static final Box<DBSongs> songBox = get_allsongsbox();

  static AddingToFavorites(
      {required BuildContext context, required String id}) async {
    List<DBSongs> allsong = songBox.values.toList().cast();

    final List<DBSongs> favoriteSongList =
        PlaylistBox.get('favorites')!.toList().cast<DBSongs>();
    final DBSongs favsong = allsong.firstWhere((song) => song.id.contains(id));
    if (favoriteSongList.where((song) => song.id == favsong.id).isEmpty) {
      favoriteSongList.add(favsong);
      showFavouritesSnackBar(
          context: context, songName: favsong.title, message: ' Song Added ');
      await PlaylistBox.put('favorites', favoriteSongList);
    } else {
      favoriteSongList.removeWhere((song) => song.id == favsong.id);
      await PlaylistBox.put('favorites', favoriteSongList);

      showFavouritesSnackBar(
          context: context, songName: favsong.title, message: 'Song Removed ');
    }
  }

  static IconData isThisFavourite({required String id}) {
    final List<DBSongs> allsong = songBox.values.toList().cast();
    List<DBSongs> favoriteSongList =
        PlaylistBox.get('favorites')!.toList().cast<DBSongs>();
    DBSongs favsongs = allsong.firstWhere((song) => song.id.contains(id));
    return favoriteSongList.where((song) => song.id == favsongs.id).isEmpty
        ? Icons.favorite_border_outlined
        : Icons.favorite;
  }
}

showFavouritesSnackBar(
    {required BuildContext context,
    required String songName,
    required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: grey,
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
