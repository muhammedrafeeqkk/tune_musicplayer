part of 'recent_bloc.dart';

@freezed
class RecentState with _$RecentState {
  const factory RecentState({
    required List<DBSongs> RecentSongList,
  }) = _RecentState;

  factory RecentState._Initial() {
    Box<List> recentSongBox = get_adding_lists();
    return RecentState(
        RecentSongList: recentSongBox.get('recent')!.toList().cast<DBSongs>());
  }
}
