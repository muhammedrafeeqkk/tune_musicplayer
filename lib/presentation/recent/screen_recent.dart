import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/homepagewidgets.dart';
import 'package:music_player/widgets/music.dart';

class ScreenRecent extends StatelessWidget {
  ScreenRecent({Key? key, required this.audioplayer}) : super(key: key);

  final AssetsAudioPlayer audioplayer;
//   @override
//   State<ScreenRecent> createState() => _ScreenRecentState();
// }

// class _ScreenRecentState extends State<ScreenRecent> {
  List<DBSongs> recentSonglist = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Box<List> getlistsongsbox = get_adding_lists();

  initState() {
    recentSonglist = getlistsongsbox.get('recent')!.toList().cast<DBSongs>();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.25),
            child: Text('Recent'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          title: Text(
                            'WANT TO CLEAR RECENT',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'NO'),
                              child: const Text('NO'),
                            ),
                            TextButton(
                                onPressed: () {
                                  getlistsongsbox.put('recent', []);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('YES'))
                          ],
                          // titlePadding:
                          //     EdgeInsets.only(top: screenHeight * 0.06),
                        ));
              },
              icon: Icon(
                Icons.delete_outline,
                size: 30,
              ),
            )
          ]),
      body: Column(
        children: [
          songtext(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.02, right: screenWidth * 0.02),
            child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: liteblack,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ValueListenableBuilder(
                  valueListenable: getlistsongsbox.listenable(),
                  builder: (context, value, child) {
                    return recentSonglist.isEmpty
                        ? Center(child: Text('NO SONGS'))
                        : ListView.builder(
                            itemCount: recentSonglist.length,
                            itemBuilder: (context, index) {
                              return Musics(
                                index: index,
                                item: recentSonglist,
                                iconwant: true,
                                isithomepage: true,
                                playlistname: 'recent',
                                audioPlayer: audioplayer,
                                conditionalicon: true,
                              );
                            },
                          );
                  },
                )),
          ))
        ],
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       flex: 3,
      //       child: Column(
      //         children: [
      //           librarytext(),
      //           Expanded(
      //             child: ListView(
      //               children: [
      //                 Center(
      //                     child: Text(
      //                   ' No  Library Found....',
      //                   style: TextStyle(color: grey),
      //                 ))
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //         flex: 9,
      //         child: Column(
      // children: [
      //   songtext(),
      //   Expanded(
      //       child: Padding(
      //     padding: EdgeInsets.only(
      //         left: screenWidth * 0.02, right: screenWidth * 0.02),
      //     child: Container(
      //       height: double.infinity,
      //       decoration: BoxDecoration(
      //           color: liteblack,
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(20),
      //               topRight: Radius.circular(20))),
      //       // child: ListView.builder(itemBuilder: (context, index) {
      //       //   return Musics(index: index, item: , iconwant: iconwant, isithomepage: isithomepage, playlistname: playlistname, audioPlayer: audioPlayer);
      //       // },)
      //     ),
      //   ))
      // ],
      //         )),
      //   ],
      // )
    );
  }
}

Widget librarytext() {
  return ListTile(
    iconColor: grey,
    textColor: grey,
    leading: Icon(
      Icons.playlist_add_check,
      size: 32,
    ),
    title: Text(
      'Library',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

Widget songtext() {
  return ListTile(
    iconColor: grey,
    textColor: grey,
    leading: Icon(
      Icons.music_note,
      size: 30,
    ),
    title: Text(
      'Songs',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
