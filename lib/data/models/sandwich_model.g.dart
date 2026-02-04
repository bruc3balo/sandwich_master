// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sandwich_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SandwichModelAdapter extends TypeAdapter<SandwichModel> {
  @override
  final int typeId = 1;

  @override
  SandwichModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SandwichModel(
      id: fields[0] as String,
      name: fields[1] as String,
      bread: fields[2] as IngredientModel,
      proteins: (fields[3] as List).cast<IngredientModel>(),
      toppings: (fields[4] as List).cast<IngredientModel>(),
      sauces: (fields[5] as List).cast<IngredientModel>(),
      image: fields[6] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, SandwichModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.bread)
      ..writeByte(3)
      ..write(obj.proteins)
      ..writeByte(4)
      ..write(obj.toppings)
      ..writeByte(5)
      ..write(obj.sauces)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SandwichModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
