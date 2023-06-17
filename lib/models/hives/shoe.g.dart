// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoeAdapter extends TypeAdapter<Shoe> {
  @override
  final int typeId = 0;

  @override
  Shoe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shoe(
      id: fields[0] as int?,
      image: fields[1] as String?,
      name: fields[2] as String?,
      description: fields[3] as String?,
      price: fields[4] as double?,
      color: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Shoe obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
