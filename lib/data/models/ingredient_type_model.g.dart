// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientTypeModelAdapter extends TypeAdapter<IngredientTypeModel> {
  @override
  final int typeId = 2;

  @override
  IngredientTypeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IngredientTypeModel.bread;
      case 1:
        return IngredientTypeModel.protein;
      case 2:
        return IngredientTypeModel.topping;
      case 3:
        return IngredientTypeModel.sauce;
      default:
        return IngredientTypeModel.bread;
    }
  }

  @override
  void write(BinaryWriter writer, IngredientTypeModel obj) {
    switch (obj) {
      case IngredientTypeModel.bread:
        writer.writeByte(0);
        break;
      case IngredientTypeModel.protein:
        writer.writeByte(1);
        break;
      case IngredientTypeModel.topping:
        writer.writeByte(2);
        break;
      case IngredientTypeModel.sauce:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
