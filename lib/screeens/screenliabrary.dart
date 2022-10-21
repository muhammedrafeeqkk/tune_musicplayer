import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

import 'package:music_player/screeens/carlibrary.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/miniplayer.dart';
import 'package:music_player/widgets/new_create_playlist_show_dailouge.dart';

import '../widgets/customgrid.dart';

class ScreenLibrary extends StatefulWidget {
  ScreenLibrary({
    Key? key,
    required this.item,
  }) : super(key: key);

  final List<DBSongs> item;

  @override
  State<ScreenLibrary> createState() => _ScreenLibraryState();
}

class _ScreenLibraryState extends State<ScreenLibrary> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Box<List> getplaylistBox = get_adding_lists();
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
            ValueListenableBuilder(
              valueListenable: getplaylistBox.listenable(),
              builder: (context, value, child) {
                List<String> keys = getplaylistBox.keys.toList().cast();
                keys.removeWhere((item) => item.contains('favorites'));

                return Expanded(
                  flex: 14,
                  child: keys.isEmpty
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
                            itemCount: keys.length,
                            padding: EdgeInsets.all(screenWidth * 0.042),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: (5 / 4)),
                            itemBuilder: (BuildContext context, int index) {
                              final playlistkeyname = keys[index];

                              return Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  screencarlibrary(
                                                      index: index,
                                                      newkeys: playlistkeyname),
                                            ));
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            getplaylistBox.listenable(),
                                        builder: (context, value, child) {
                                          return customgrid(
                                            
                                            color: pink,
                                            playlistkeyname: playlistkeyname,
                                          );
                                        },
                                      )));
                            },
                          ),
                        ),
                );
              },
            ),
            Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    child: miniplayer(),
                  ),
                ))
          ],
        ));
  }
}
