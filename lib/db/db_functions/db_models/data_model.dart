import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class DBSongs {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String artist;
  @HiveField(3)
  final String uri;

  DBSongs({
    required this.id,
    required this.title,
    required this.artist,
    required this.uri,
  });
}
@HiveType(typeId: 1)
class DBDetails{
  @HiveField(0)
  final String name;

  DBDetails({
required this.name,
  });
}

