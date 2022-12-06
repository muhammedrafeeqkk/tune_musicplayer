import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/applications/favorites/favorites/favorites_bloc.dart';

import 'package:music_player/applications/home/search/search_bloc.dart';
import 'package:music_player/applications/playlistGridView/playlists_bloc.dart';
import 'package:music_player/applications/recent/recent_bloc.dart';

import 'package:music_player/db/db_functions/db_models/data_model.dart';
import 'package:music_player/functions/playlist_rename.dart';
import 'package:music_player/presentation/splash/screen_splashscreen.dart';

import 'package:music_player/shortcuts/shortcuts.dart';

Future<void> main() async {
  //hive registering
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DBSongsAdapter().typeId)) {
    Hive.registerAdapter(DBSongsAdapter());
  }

  //all songs hive box opening
  await Hive.openBox<DBSongs>('Allsongs');
  //adding_list hive box opening
  await Hive.openBox<List>('Adding_lists');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => RecentBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => PlaylistsBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: darkblack,
          ),
          scaffoldBackgroundColor: skyblack,
        ),
        home: splashscreen(),
      ),
    );
  }
}
