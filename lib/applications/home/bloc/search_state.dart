part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  
  const factory SearchState({
   required List<DBSongs>allSongList,
   
  }) = _SearchState;

  factory SearchState._Initial(){
    Box<DBSongs>allDbSongs=get_allsongsbox();
    List<DBSongs>allsongs=allDbSongs.values.toList();
    return SearchState(allSongList: allsongs);
  }
}
