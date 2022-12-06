import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';

import '../../db/db_functions/db_models/data_model.dart';

part 'playlists_event.dart';
part 'playlists_state.dart';
part 'playlists_bloc.freezed.dart';

class PlaylistsBloc extends Bloc<PlaylistsEvent, PlaylistsState> {
  PlaylistsBloc() : super(PlaylistsState._Initial()) {
    Box<List> playlists = get_adding_lists();

    on<Getplaylistnames>((event, emit) {
      List<String> keylist = playlists.keys.toList().cast<String>();
      keylist.removeWhere((element) => element.contains('favorites'));
      keylist.removeWhere((element) => element.contains('recent'));

      emit(
        PlaylistsState(
          playlistkeyname: keylist,
          playlistname: state.playlistname,
          playlistSongs: state.playlistSongs,
        ),
      );
    });

    on<Renameplaylist>((event, emit) async {
      List<DBSongs> _getplaylistnames =
          playlists.get(event.oldplaylistname)!.toList().cast<DBSongs>();

      await playlists.put(event.newplaylistname, _getplaylistnames);
      await playlists.delete(event.oldplaylistname);

      emit(PlaylistsState(
          playlistkeyname: _getplaylistnames,
          playlistname: event.newplaylistname,
          playlistSongs: state.playlistSongs));
    });

    on<Getplaylistsogs>((event, emit) {
      List<DBSongs> _getplaylistnames =
          playlists.get(event.playlistNames)!.toList().cast<DBSongs>();
      emit(PlaylistsState(
          playlistkeyname: _getplaylistnames,
          playlistname: event.playlistNames,
          playlistSongs: state.playlistSongs));
    });
  }
}
