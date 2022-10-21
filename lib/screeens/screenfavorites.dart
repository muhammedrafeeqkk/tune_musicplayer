import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/favorites.dart';
import 'package:music_player/screeens/home.dart';

import 'package:music_player/screeens/screenliabrary.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/miniplayer.dart';

import 'package:music_player/widgets/music.dart';
import 'package:music_player/widgets/playlistshowmodelsheet.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/homepagewidgets.dart';

final AudioPlayer AuudioPlayer = AudioPlayer();
ValueNotifier<int> newIndex = ValueNotifier(0);

class ScreenFavorites extends StatefulWidget {
  ScreenFavorites({Key? key}) : super(key: key);

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
                        Stack(
                          children: [
                            Container(
                              height: screenHeight * 0.04,
                              width: screenWidth * 0.09,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: darkblack),
                              child: IconButton(
                                onPressed: () {
                                  favorites.AddingToFavorites(
                                      context: context,
                                      id: Songlist[favValue].id);
                                  setState(() {
                                    favorites.isThisFavourite(
                                        id: Songlist[favValue].id);
                                  });
                                },
                                icon: Songlist.isEmpty
                                    ? Icon(Icons.hourglass_empty_rounded)
                                    : Icon(
                                        favorites.isThisFavourite(
                                            id: Songlist[favValue].id),
                                        color: pink,
                                        size: 30),
                              ),
                            )
                          ],
                        ),
                        Songlist.isEmpty
                            ? SizedBox(
                                width: screenWidth * .43,
                                height: screenHeight * .18,
                                child: Image.network(
                                  'https://play-lh.googleusercontent.com/mOkjjo5Rzcpk7BsHrsLWnqVadUK1FlLd2-UlQvYkLL4E9A0LpyODNIQinXPfUMjUrbE',
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                child: Container(
                                  width: screenWidth * .43,
                                  height: screenHeight * .18,
                                  child: QueryArtworkWidget(
                                      nullArtworkWidget: Image.network(
                                        'https://play-lh.googleusercontent.com/mOkjjo5Rzcpk7BsHrsLWnqVadUK1FlLd2-UlQvYkLL4E9A0LpyODNIQinXPfUMjUrbE',
                                        fit: BoxFit.cover,
                                      ),
                                      id: int.parse(Songlist[favValue].id),
                                      artworkFit: BoxFit.cover,
                                      type: ArtworkType.AUDIO),
                                ),
                              ),
                        containerinicon2(context, Songlist, favValue)
                      ],
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
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
                          Text(
                            Songlist.isEmpty
                                ? '-----'
                                : Songlist[favValue].artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
          allsongs(context),
          Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
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
          Expanded(
              flex: 3,
              child: Container(
                child: miniplayer(),
              ))
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
