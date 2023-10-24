// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongEntityAdapter extends TypeAdapter<SongEntity> {
  @override
  final int typeId = 0;

  @override
  SongEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongEntity(
      id: fields[0] as String,
      album: fields[1] as String?,
      albumId: fields[2] as int?,
      artist: fields[3] as String,
      title: fields[4] as String,
      duration: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.album)
      ..writeByte(2)
      ..write(obj.albumId)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
