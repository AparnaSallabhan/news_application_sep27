// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_mark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkModelAdapter extends TypeAdapter<BookMarkModel> {
  @override
  final int typeId = 1;

  @override
  BookMarkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarkModel(
      fields[2] as String?,
      fields[0] as String?,
      fields[3] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookMarkModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
