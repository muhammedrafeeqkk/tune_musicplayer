// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBSongsAdapter extends TypeAdapter<DBSongs> {
  @override
  final int typeId = 0;

  @override
  DBSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBSongs(
      id: fields[0] as String,
      title: fields[1] as String,
      artist: fields[2] as String,
      uri: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DBSongs obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DBDetailsAdapter extends TypeAdapter<DBDetails> {
  @override
  final int typeId = 1;

  @override
  DBDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBDetails(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DBDetails obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
