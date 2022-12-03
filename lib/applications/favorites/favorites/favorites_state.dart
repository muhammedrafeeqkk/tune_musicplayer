part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    required List<DBSongs> favoriteSongList ,
   
  }) = _FavoritesState;


  factory FavoritesState._Initial(){
    Box<List>playlistbox=get_adding_lists();
    return  FavoritesState(favoriteSongList: playlistbox.get('favorites')!.toList().cast<DBSongs>());
  }
}
