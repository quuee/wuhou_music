// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongListEntityAdapter extends TypeAdapter<SongListEntity> {
  @override
  final int typeId = 1;

  @override
  SongListEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongListEntity(
      id: fields[0] as int,
      songList: fields[1] as String,
      songListAlbum: fields[2] as String,
      count: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongListEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songList)
      ..writeByte(2)
      ..write(obj.songListAlbum)
      ..writeByte(3)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongListEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
