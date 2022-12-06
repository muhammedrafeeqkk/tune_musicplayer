part of 'playlists_bloc.dart';

@freezed
class PlaylistsState with _$PlaylistsState {
  const factory PlaylistsState({
    required List playlistkeyname,
    required  String playlistname,
    required List<DBSongs> playlistSongs,

  }) = _PlaylistsState;

  factory PlaylistsState._Initial() {
    Box<List> playlists = get_adding_lists();

    List<String> playlistKeys = playlists.keys.toList().cast();
    playlistKeys.removeWhere((item) => item.contains('favorites'));
    playlistKeys.removeWhere((element) => element.contains('recent'));
    return PlaylistsState(playlistname: '',
      
      playlistSongs: [], playlistkeyname: playlistKeys
    );
  }
}
