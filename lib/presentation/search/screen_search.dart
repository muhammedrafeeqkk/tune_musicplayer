import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:music_player/applications/home/search/search_bloc.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

import 'package:music_player/shortcuts/shortcuts.dart';

import 'package:music_player/widgets/music.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, required this.audioPlayer}) : super(key: key);
  final AssetsAudioPlayer audioPlayer;

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
  // Box<DBSongs> allsongBox = get_allsongsbox();
  // List<DBSongs>? ddbSongs;
  // List<DBSongs>? searchedSongs;

  // initState() {
  //   ddbSongs = allsongBox.values.toList().cast<DBSongs>();
  //   searchedSongs = List<DBSongs>.from(ddbSongs!).toList().cast<DBSongs>();
  // }

  // songsearchfromdb(String searchsongs) {
  //   // setState(() {
  //     // searchedSongs = ddbSongs!
  //         // .where((song) =>
  //         //     song.title.toLowerCase().contains(searchsongs.toLowerCase()))
  //         // .toList();
  //   // });
  // }

  Widget build(BuildContext context) {
    // initState();
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
                          BlocProvider.of<SearchBloc>(context)
                              .add(Search(SearchValue: value));
                        },
                        decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: const Icon(Icons.search),
                            hintText: '        search here...',
                            fillColor: grey,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      )),
                ],
              )),
          Expanded(
              flex: 14,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return Container(
                    width: screenwidth * 1,
                    decoration: BoxDecoration(
                        color: liteblack,
                        borderRadius: BorderRadius.circular(20)),
                    child: state.allSongList.isEmpty
                        ? Center(
                            child: Text('Song Not Found'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: state.allSongList.length,
                            itemBuilder: (context, index) {
                              return Musics(
                                audioPlayer: audioPlayer,
                                index: index,
                                item: state.allSongList,
                                iconwant: true,
                                isithomepage: true,
                                conditionalicon: true,
                                playlistname: '',
                              );
                            }),
                  );
                },
              )),
        ],
      ),
    );
  }
}
