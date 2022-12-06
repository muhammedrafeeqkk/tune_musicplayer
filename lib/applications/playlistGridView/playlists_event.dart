part of 'playlists_bloc.dart';

@freezed
class PlaylistsEvent with _$PlaylistsEvent {
  const factory PlaylistsEvent.getplaylistnames() = Getplaylistnames;


  const factory PlaylistsEvent.renameplaylist({
    required String newplaylistname,
    required  String  oldplaylistname

  }) = Renameplaylist;
  const  factory PlaylistsEvent.getplaylistsogs({
    required String playlistNames,
  })= Getplaylistsogs;
    
}

