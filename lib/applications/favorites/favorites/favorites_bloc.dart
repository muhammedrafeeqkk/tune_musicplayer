import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';

import '../../../db/db_functions/db_models/data_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState._Initial()) {
    Box<List>playlistbox= get_adding_lists();

    



    on<Favorite>((event, emit) {
       emit(  FavoritesState(favoriteSongList: playlistbox.get('favorites')!.toList().cast<DBSongs>()));
    });
  }
}


