import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

new_playlist_creating_widget({required context}) {
  TextEditingController textcontroller = TextEditingController();
  final screenwidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  Box<List> playlistBox = get_adding_lists();

  Future<void> createNewplaylist() async {
    List<DBSongs> songList = [];
    final String playlistNameBox = textcontroller.text.trim();
    if (playlistNameBox.isEmpty) {
      return;
    }
    await playlistBox.put(playlistNameBox, songList);
  }

  return showDialog(
    context: context,
    builder: (context) => Dialog(
        backgroundColor: skyblack,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        child: Container(
          height: screenHeight * 0.28,
          width: screenwidth * double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: Text(
                  'Create New Playlist',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500, color: white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textcontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.playlist_add),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintText: '       playlist name...',
                      fillColor: grey,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(pink)),
                  onPressed: () {
                    Navigator.pop(context);
                    createNewplaylist();
                  },
                  child: Text('ok'))
            ],
          ),
        )),
  );
  ;
}
