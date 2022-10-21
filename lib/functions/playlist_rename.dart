import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:searchfield/searchfield.dart';

class playlist {
  static final Box<List> GettingPlaylist = get_adding_lists();
  static final Box<DBSongs> allsong = get_allsongsbox();

  static playlistRename({
    required context,
    required dynamic playlistkeyname,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    final TextEditingController textcontroller =
        TextEditingController(text: playlistkeyname);
    showDialog(
        context: context,
        builder: (context) {
          final formkey = GlobalKey<FormState>();
          return Builder(builder: (context) {
            return ValueListenableBuilder(
              valueListenable: GettingPlaylist.listenable(),
              builder: (context, value, child) {
                return Dialog(
                    backgroundColor: skyblack,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    child: Container(
                      height: screenheight * 0.29,
                      width: screenWidth * double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: screenheight * 0.02),
                            child: Text(
                              'Rename',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: white),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formkey,
                                child: SearchField(
                                  suggestions: [],

                                  validator: (value) {
                                    final KEys = GettingPlaylist.keys.toList();
                                    if (value == null || value.isEmpty) {
                                      return 'field is empty';
                                    }
                                    if (KEys.contains(value)) {
                                      return '$value  alredy existed';
                                    }
                                    {
                                      return null;
                                    }
                                  },

                                  hint: playlistkeyname,
                                  controller: textcontroller,
                                  //  InputDecoration(
                                  //     prefixIcon:
                                  //         Icon(Icons.drive_file_rename_outline_outlined),
                                  //     contentPadding: EdgeInsets.symmetric(vertical: 15),
                                  //     hintText: playlistkeyname,
                                  //     fillColor: grey,
                                  //     filled: true,
                                  //     border: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.circular(25))),
                                ),
                              )),
                          ValueListenableBuilder(
                            valueListenable: GettingPlaylist.listenable(),
                            builder: (context, value, child) {
                              return ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(pink)),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      final List<DBSongs> playlistValues =
                                          GettingPlaylist.get(playlistkeyname)!
                                              .toList()
                                              .cast<DBSongs>();

                                      final newplaylistKeyName =
                                          textcontroller.text.trim();
                                      await GettingPlaylist.put(
                                        newplaylistKeyName,
                                        playlistValues,
                                      );

                                      GettingPlaylist.delete(playlistkeyname);
                                      
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('okk'));
                            },
                          ),
                        ],
                      ),
                    ));
              },
            );
          });
        });
  }
}
