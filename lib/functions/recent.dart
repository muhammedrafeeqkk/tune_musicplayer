import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

class recent {
  static final Box<DBSongs> getAllSongs = get_allsongsbox();
  static final Box<List> getplaylistBox = get_adding_lists();
  static addingSonginRecent({required String SongId}) async {
    final List<DBSongs> allsongs = getAllSongs.values.toList().cast<DBSongs>();
    final List<DBSongs> RecentSongList =
        getplaylistBox.get('Recent')!.toList().cast<DBSongs>();
    final DBSongs recentSong =
        allsongs.firstWhere((song) => song.id.contains(SongId));
    if (RecentSongList.length >= 10) {
      RecentSongList.removeLast();
    }
    if (RecentSongList.where((song) => song.id == recentSong.id).isEmpty) {
      RecentSongList.insert(0, recentSong);
      await getplaylistBox.put('recent', RecentSongList);
    } else {
      RecentSongList.removeWhere((song) => song.id == recentSong.id);
      RecentSongList.insert(0, recentSong);
      await getplaylistBox.put('recent', RecentSongList);
    }
  }
}
