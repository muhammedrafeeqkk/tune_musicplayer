import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/db_functions/db_function.dart';
import 'package:music_player/functions/recent.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../db/db_functions/db_models/data_model.dart';

part 'recent_event.dart';
part 'recent_state.dart';
part 'recent_bloc.freezed.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc() : super(RecentState._Initial()) {
    Box<List> recentSonglist = get_adding_lists();

    on<Recentsong>((event, emit) {
      emit(RecentState(
          RecentSongList:
              recentSonglist.get('recent')!.toList().cast<DBSongs>()));
    });

   
  }
}
