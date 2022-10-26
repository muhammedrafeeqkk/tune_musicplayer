import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

//getting all song hivebox
Box<DBSongs> get_allsongsbox() {
  return Hive.box<DBSongs>('Allsongs');
}

Box<List>get_adding_lists(){
  return Hive.box<List>('adding_lists');
}

