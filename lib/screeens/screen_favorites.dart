import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/screeens/screen_home.dart';

import 'package:music_player/screeens/screen%20_liabrary.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

import 'package:music_player/widgets/music.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/homepagewidgets.dart';

ValueNotifier<int> newIndex = ValueNotifier(0);

class ScreenFavorites extends StatefulWidget {
  ScreenFavorites({Key? key, required this.audioPlayer}) : super(key: key);
  final AssetsAudioPlayer audioPlayer;

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<DBSongs> Songlist = [];

  final Box<List> getlistsongs = get_adding_lists();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Songlist = getlistsongs.get('favorites')!.toList().cast<DBSongs>();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorite'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          ValueListenableBuilder(
              valueListenable: newIndex,
              builder: (BuildContext context, int favValue, Widget? _) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            favorites.AddingToFavorites(
                                context: context, id: Songlist[favValue].id);
                            setState(() {
                              favorites.isThisFavourite(
                                  id: Songlist[favValue].id);
                            });
                          },
                          icon: Songlist.isEmpty
                              ? Center(
                                  child: Icon(Icons.hourglass_empty_rounded,
                                      color: grey, size: 30),
                                )
                              : Center(
                                  child: Icon(
                                      favorites.isThisFavourite(
                                          id: Songlist[favValue].id),
                                      color: pink,
                                      size: 30),
                                ),
                        ),
                        Songlist.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.01,
                                    left: screenWidth * 0.03,
                                    right: screenWidth * 0.03,
                                    bottom: screenHeight * 0.02),
                                child: SizedBox(
                                  width: screenWidth * .43,
                                  height: screenHeight * .18,
                                  child: Container(
                                    width: screenWidth * 0.53,
                                    height: screenHeight * 0.17,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: darkblack),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Icon(
                                      Icons.music_note,
                                      size: 55,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: screenHeight * 0.01,
                                    left: screenWidth * 0.03,
                                    right: screenWidth * 0.03,
                                    bottom: screenHeight * 0.02),
                                child: Container(
                                  width: screenWidth * 0.53,
                                  height: screenHeight * 0.17,
                                  child: QueryArtworkWidget(
                                      artworkBorder: BorderRadius.circular(25),
                                      id: int.parse(Songlist[favValue].id),
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Container(
                                        width: screenWidth * 0.53,
                                        height: screenHeight * 0.17,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: darkblack),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Icon(
                                          Icons.music_note,
                                          size: 55,
                                        ),
                                      )),
                                ),
                              ),
                        containerinicon2(context, Songlist, favValue)
                      ],
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      child: Center(
                        child: Text(
                          Songlist.isEmpty
                              ? 'No favorites'
                              : Songlist[favValue].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: purewhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.45,
                      child: Center(
                        child: Text(
                          Songlist.isEmpty
                              ? '-----'
                              : Songlist[favValue].artist == '<unknown>'
                                  ? 'unknown'
                                  : Songlist[favValue].artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                );
              }),
          allsongs(context),
          Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenWidth * 0.01),
                child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: liteblack,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ValueListenableBuilder(
                        valueListenable: getlistsongs.listenable(),
                        builder: (BuildContext context, Box<List> value,
                            Widget? child) {
                          Songlist = getlistsongs
                              .get('favorites')!
                              .toList()
                              .cast<DBSongs>();
                          return (Songlist.isEmpty)
                              ? Center(child: const Text('No Songs'))
                              : ListView.builder(
                                  itemCount: Songlist.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Musics(
                                        audioPlayer: widget.audioPlayer,
                                        index: index,
                                        item: Songlist,
                                        iconwant: false,
                                        isithomepage: false,
                                        conditionalicon: false,
                                        playlistname: 'favorites',
                                      ),
                                    );
                                  });
                        })

                    //  ListView.builder(
                    //   itemCount: 1,
                    //   itemBuilder: (context, index) {
                    //     return Text('no songs');
                    //   },
                    // )
                    ),
              )),
        ],
      ),
    );
  }
}

Widget containerinicon2(BuildContext context, item, index) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of((context)).size.width;

  return Stack(
    children: [
      Container(
          height: screenHeight * 0.04,
          width: screenWidth * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: darkblack),
          // color: darkblack,
          child: IconButton(
            // onPressed: () => Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ScreenLibrary(item: so,))),
            color: grey,
            icon: Icon(Icons.playlist_add),
            onPressed: () {
              PlaylistModelBottomSheet(context: context, Song: item[index]);
            },
          )
          // Icon(
          //   icon,

          ),
    ],
  );
}
