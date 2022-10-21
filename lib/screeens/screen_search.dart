import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/just_audioplayer.dart';
import 'package:music_player/screeens/home.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/widgets/homepagewidgets.dart';
import 'package:music_player/widgets/miniplayer.dart';
import 'package:music_player/widgets/music.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Box<DBSongs> allsongBox = get_allsongsbox();
  List<DBSongs>? ddbSongs;
  List<DBSongs>? searchedSongs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ddbSongs = allsongBox.values.toList().cast<DBSongs>();
    searchedSongs = List<DBSongs>.from(ddbSongs!).toList().cast<DBSongs>();
  }

  songsearchfromdb(String searchsongs) {
    setState(() {
      searchedSongs = ddbSongs!
          .where((song) =>
              song.title.toLowerCase().contains(searchsongs.toLowerCase()))
          .toList();
    });
  }

  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Search')),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        songsearchfromdb(value);
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          prefixIcon: Icon(Icons.search),
                          hintText: '        search here...',
                          fillColor: grey,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 14,
              child: Container(
                width: screenwidth * 1,
                decoration: BoxDecoration(
                    color: liteblack, borderRadius: BorderRadius.circular(20)),
                child: searchedSongs!.isEmpty
                    ? Center(
                        child: Text('Song Not Found'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: searchedSongs!.length,
                        itemBuilder: (context, index) {
                          return Musics(
                            index: index,
                            item: searchedSongs!,
                            iconwant: true,
                            isithomepage: true,
                            conditionalicon: true,
                          playlistname: '',
                          );
                        }),
              )),
          Expanded(flex: 3, child: miniplayer())
        ],
      ),
    );
  }
}
