import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/playlist_rename.dart';
import 'package:music_player/functions/playlists.dart';
import 'package:music_player/shortcuts/shortcuts.dart';
import 'package:music_player/shortcuts/shortcuts.dart';

customgrid({
  required color,
  required String playlistkeyname,
}) {
  return Builder(builder: (context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    Box<List> getplaylistBox = get_adding_lists();
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: GridTile(
        child: Column(
          children: [],
        ),
        footer: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            playlistkeyname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        header: Padding(
            padding: EdgeInsets.only(left: 105),
            child: PopupMenuButton(
                // color: darkblack,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                icon: Icon(
                  Icons.more_vert,
                  color: white,
                  size: 30,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Column(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        title: Text('Do you Want To Delete'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                              context,
                                            ),
                                            child: const Text('NO'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                getplaylistBox
                                                    .delete(playlistkeyname);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                'Successfully Deleted',
                                                                style:
                                                                    TextStyle(
                                                                  color: grey,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                playlistkeyname,
                                                                style:
                                                                    TextStyle(
                                                                  color: grey,
                                                                  fontSize: 8,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )));
                                                Navigator.pop(context);
                                              },
                                              child: Text('YES')),
                                        ],
                                      )));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: grey,
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(color: grey),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              playlist.playlistRename(
                                context: context,
                                playlistkeyname: playlistkeyname,
                              );
                            },
                            icon: Icon(
                              Icons.drive_file_rename_outline_rounded,
                              color: grey,
                            ),
                            label:
                                Text('Rename', style: TextStyle(color: grey)),
                          )
                        ],
                      ))
                    ])),
      ),
    );
  });
}

//  Column(
//                           children: [
//                             Stack(
//                               children: [y
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: darkblack),
//                                 ),
//                                 Positioned(
//                                   top: 30,
//                                   left: 45,
//                                   child: IconButton(
//                                       onPressed: () {
//                                         new_playlist_creating_widget(
//                                             context: context);
//                                       },
//                                       icon: Icon(
//                                         Icons.add,
//                                         color: grey,
//                                         size: 60,
//                                       )),
//                                 )
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           screencarlibrary())),
//                               child: playlistcontainer(context,
//                                   playbutton: false,
//                                   iconmore: true,
//                                   playlistname: "CAR",
//                                   assetimagepath:
//                                       'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
//                             ),
//                             playlistcontainer(context,
//                                 playbutton: false,
//                                 playlistname: 'koi',
//                                 iconmore: true,
//                                6145-d05b474e2155?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTQ1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60')
//                           ],
//                         );
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Widget playlistcontainer(
//   BuildContext context, {
//   required bool playbutton,
//   required bool iconmore,
//   required String playlistname,
//   required String assetimagepath,
// }) {
//   final screenHeight = MediaQuery.of(context).size.height;
//   final screenWidth = MediaQuery.of((context)).size.width;
//   return Stack(
//     children: [
//       Container(
//         height: 140,
//         width: 170,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             // color: white,
//             image: DecorationImage(
//                 image: NetworkImage(assetimagepath), fit: BoxFit.cover)),
//       ),
//       Positioned(
//         bottom: 10,
//         left: 30,
//         child: Text(
//           playlistname,
//           style:
//               TextStyle(color: grey, fontSize: 25, fontWeight: FontWeight.w600),
//         ),
//       ),
//       Positioned(
//         left: 115,
//         child: iconmore == true
//             ? PopupMenuButton(
//                 // color: darkblack,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 icon: Icon(
//                   Icons.more_vert,
//                   color: white,
//                   size: 40,
//                 ),
//                 itemBuilder: (context) => [
//                       PopupMenuItem(
//                           child: Column(
//                         children: [
//                           TextButton.icon(
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: ((context) => AlertDialog(
//                                         shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(32.0))),
//                                         title: Text('Do you Want To Delete'),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () => Navigator.pop(
//                                               context,
//                                             ),
//                                             child: const Text('NO'),
//                                           ),
//                                           TextButton(
//                                               onPressed: () {},
//                                               child: Text('YES')),
//                                         ],
//                                       )));
//                             },
//                             icon: Icon(
//                               Icons.delete,
//                               color: grey,
//                             ),
//                             label: Text(
//                               'Delete',
//                               style: TextStyle(color: grey),
//                             ),
//                           ),
//                           TextButton.icon(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => Dialog(
//                                     backgroundColor: skyblack,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(32.0))),
//                                     child: Container(
//                                       height: screenHeight * 0.28,
//                                       width: screenWidth * double.infinity,
//                                       child: Column(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: screenHeight * 0.02),
//                                             child: Text(
//                                               'Rename',
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: white),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(20.0),
//                                             child: TextField(
//                                               decoration: InputDecoration(
//                                                   prefixIcon:
//                                                       Icon(Icons.playlist_add),
//                                                   contentPadding:
//                                                       EdgeInsets.symmetric(
//                                                           vertical: 15),
//                                                   hintText: '  Enter Name..',
//                                                   fillColor: grey,
//                                                   filled: true,
//                                                   border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               25))),
//                                             ),
//                                           ),
//                                           ElevatedButton(
//                                               style: ButtonStyle(
//                                                   backgroundColor:
//                                                       MaterialStateProperty.all(
//                                                           pink)),
//                                               onPressed: () {},
//                                               child: Text('ok'))
//                                         ],
//                                       ),
//                                     )),
//                               );
//                             },
//                             icon: Icon(
//                               Icons.drive_file_rename_outline_rounded,
//                               color: grey,
//                             ),
//                             label:
//                                 Text('Rename', style: TextStyle(color: grey)),
//                           )
//                         ],
//                       ))
//                     ])
//             // IconButton(
//             //     onPressed: () {},

//             //   )
//             : SizedBox(),
//       ),
//       Positioned(
//           left: 50,
//           bottom: 60,
//           child: playbutton == true
//               ? IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.play_circle_outline_outlined,
//                     color: grey,
//                     size: 50,
//                   ))
//               : SizedBox()),
//     ],
//   );
// }


// // 