// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantAdapter extends TypeAdapter<Restaurant> {
  @override
  final int typeId = 1;

  @override
  Restaurant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Restaurant(
      name: fields[5] as String,
      quality: fields[6] as String,
      imageUrl: fields[7] as String,
      id: fields[8] as int,
      numOfRatings: fields[9] as int,
      rating: fields[10] as double,
      tags: (fields[11] as List).cast<Tag>(),
      menu: (fields[12] as List).cast<Menu>(),
    );
  }

  @override
  void write(BinaryWriter writer, Restaurant obj) {
    writer
      ..writeByte(8)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.quality)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.numOfRatings)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.tags)
      ..writeByte(12)
      ..write(obj.menu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
