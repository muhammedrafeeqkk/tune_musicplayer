import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/screen_search.dart';
import 'package:music_player/screeens/screenfavorites.dart';
import 'package:music_player/screeens/screenliabrary.dart';
import 'package:music_player/screeens/screenrecent.dart';
import 'package:music_player/screeens/userpage.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/homepagewidgets.dart';
import 'package:music_player/widgets/drewbaritems.dart';
import 'package:music_player/widgets/miniplayer.dart';
import 'package:music_player/widgets/music.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<int> onPressedIndex = ValueNotifier(0);

class myhome extends StatefulWidget {
  const myhome({Key? key}) : super(key: key);

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  final textController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<SongModel> Allsongs = [];
  Box<DBSongs> getboxsongs = get_allsongsbox();
  List<DBSongs> Songlist = [];
  bool _isnotfavorite = true;

  @override
  void initState() {
    super.initState();

    final List keys = getboxsongs.keys.toList();
    for (var key in keys) {
      final song = getboxsongs.get(key)!;
      Songlist.add(song);
    }
  }

  Widget build(BuildContext context) {
    final List<DBSongs> dbSongList =
        getboxsongs.values.toList().cast<DBSongs>();
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(190),
          ),
        ),
        backgroundColor: grey,
        width: screenwidth * 0.61,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.25),
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.65,
                child: Column(
                  children: [
                    drewbaritems1(text: 'NOTIFICATION'),
                    sizedspace(context),
                    drewbaritems1(text: "DARK MODE"),
                    sizedspace(context),
                    drewbaritems2(context, text3: 'About'),
                    sizedspace(context),
                    drewbaritems2(context, text3: 'Privacy'),
                    sizedspace(context),
                    drewbaritems2(context, text3: 'License'),
                    sizedspace(context),
                    drewbaritems2(context, text3: 'share'),
                  ],
                ),
              ),
            ),
            Text(
              'VERSION\n    0.0.1',
              style: TextStyle(color: liteblack, fontSize: 10),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: darkblack,
        title: Padding(
          padding: EdgeInsets.only(left: screenwidth * 0.25),
          child: Text('Home'),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: grey),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(screenwidth * 0.02),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchScreen(),
                                        ));
                                  },
                                  icon: Icon(Icons.search)),
                            ),

                            // AnimSearchBar(
                            //   color: skyblack,
                            //   closeSearchOnSuffixTap: true,
                            //   autoFocus: true,
                            //   helpText: "Search Your Song !!!!",
                            //   style: TextStyle(color: white),
                            //   width: 200,
                            //   textController: textController,
                            //   onSuffixTap: () {
                            //     setState(() {

                            //     });
                            //   },
                            // ),
                            GestureDetector(
                              onTap: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => userscreen())))),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatharlogo.jpg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
              flex: 14,
              child: ListView(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 180),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.03),
                              Text(
                                'TO PLAY',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: grey,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenwidth * 0.18),
                                child: Text(
                                  'without',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500,
                                      color: grey),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenwidth * 0.05),
                                child: const Text(
                                  'PASSION',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        SizedBox(
                          height: screenHeight * 0.19,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.0,
                                horizontal: screenwidth * 0.015),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScreenFavorites(),
                                    ),
                                  ),
                                  child: const shortcutwidgets(
                                    imageurl:
                                        'https://images.unsplash.com/photo-1517409091671-180985f2ca15?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8NHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
                                    text: 'MY\nFAVORITE',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ScreenRecent()))),
                                  child: const shortcutwidgets(
                                    imageurl:
                                        'https://images.unsplash.com/photo-1549349807-4575e87c7e6a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=442&q=80',
                                    text: 'RECENT',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScreenLibrary(
                                                item: dbSongList,
                                              ))),
                                  child: const shortcutwidgets(
                                    imageurl:
                                        'https://images.unsplash.com/photo-1628288277962-e4dbf53f9aac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                    text: 'MY\nLIBRARY',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenwidth * 0.62),
                          child: allsongs(context),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenwidth * 0.01),
                            child: Container(
                                width: screenwidth * 1,
                                decoration: BoxDecoration(
                                    color: liteblack,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ValueListenableBuilder(
                                    valueListenable: getboxsongs.listenable(),
                                    builder: (BuildContext context,
                                        Box<DBSongs> value, Widget? child) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: dbSongList.length,
                                          itemBuilder: (context, index) {
                                            return Musics(
                                              isithomepage: true,
                                              iconwant: true,
                                              conditionalicon: true,
                                              item: dbSongList,
                                              index: index,
                                              playlistname: '',
                                            );
                                          });
                                    }))
                            //  FutureBuilder<List<SongModel>>(
                            //   future: _audioQuery.querySongs(
                            //       sortType: SongSortType.TITLE,
                            //       orderType: OrderType.ASC_OR_SMALLER,
                            //       uriType: UriType.EXTERNAL,
                            //       ignoreCase: true),
                            //   builder: (context, item) {
                            //     if (item.data == null) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     }
                            //     if (item.data!.isEmpty) {
                            //       return Center(child: Text('NO Songs'));
                            //     }
                            //     return ListView.builder(
                            //       itemCount: item.data?.length,
                            //       shrinkWrap: true,
                            //       physics: ScrollPhysics(),
                            //       itemBuilder: (context, index) {

                            //       },
                            //     );
                            //   },
                            // ),
                            ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [miniplayer()],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
