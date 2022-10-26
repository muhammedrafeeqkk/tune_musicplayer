import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/screen_drawer.dart';
import 'package:music_player/screeens/screen_search.dart';
import 'package:music_player/screeens/screen_favorites.dart';
import 'package:music_player/screeens/screen%20_liabrary.dart';
import 'package:music_player/screeens/screen_recent.dart';
import 'package:music_player/screeens/screen_user.dart';

import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/homepagewidgets.dart';
import 'package:music_player/widgets/drewbaritems.dart';

import 'package:music_player/widgets/music.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> onPressedIndex = ValueNotifier(0);

class myhome extends StatefulWidget {
  const myhome({Key? key}) : super(key: key);

  @override
  State<myhome> createState() => _myhomeState();
}
//////////////////////////////

///////////////////////

class _myhomeState extends State<myhome> {
  final textController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
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
      drawer: drawer(screenwidth: screenwidth, screenHeight: screenHeight),
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
                                          builder: (context) => SearchScreen(
                                              audioPlayer: audioPlayer),
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
                                    AssetImage('assets/images/tune.png'),
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
                                      builder: (context) => ScreenFavorites(
                                          audioPlayer: audioPlayer),
                                    ),
                                  ),
                                  child: const shortcutwidgets(
                                    imageurl: 'assets/images/recent1.jpg',
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
                                    imageurl: 'assets/images/favorites1.jpg',
                                    text: 'RECENT',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScreenLibrary(
                                                audioPlayer: audioPlayer,
                                                item: dbSongList,
                                              ))),
                                  child: const shortcutwidgets(
                                    imageurl: 'assets/images/library.jpg',
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
                                              audioPlayer: audioPlayer,
                                              isithomepage: true,
                                              iconwant: true,
                                              conditionalicon: true,
                                              item: dbSongList,
                                              index: index,
                                              playlistname: '',
                                            );
                                          });
                                    }))),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  getsavedata() async {
    final sharedpref = await SharedPreferences.getInstance();
    final savedvalue = sharedpref.getString('saved_value');
    if (savedvalue != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => userscreen(),
          ));
    }
  }
}
