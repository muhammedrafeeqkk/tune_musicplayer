import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/db/db_functions/db_models/data_model.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState._Initial()) {
    on<Search>((event, emit) {
      final Box<DBSongs> DBallSongs = get_allsongsbox();
      final List<DBSongs> allsongs = DBallSongs.values.toList();
      late List<DBSongs> searchedSongs;

      searchedSongs = allsongs
          .where((song) => song.title
              .toLowerCase()
              .contains(event.SearchValue.toLowerCase()))
          .toList();

      emit(SearchState(allSongList: searchedSongs));
    });
  }
}
