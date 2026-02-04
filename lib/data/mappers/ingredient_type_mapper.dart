import 'package:sandwich_master/domain/entities/ingredient_type.dart';
import 'package:sandwich_master/data/models/ingredient_type_model.dart';

extension IngredientTypeToLocal on IngredientType {
  IngredientTypeModel get toLocal {
    switch (this) {
      case IngredientType.bread:
        return IngredientTypeModel.bread;
      case IngredientType.protein:
        return IngredientTypeModel.protein;
      case IngredientType.topping:
        return IngredientTypeModel.topping;
      case IngredientType.sauce:
        return IngredientTypeModel.sauce;
    }
  }
}

extension IngredientTypeModelToEntity on IngredientTypeModel {
  IngredientType get toEntity {
    switch (this) {
      case IngredientTypeModel.bread:
        return IngredientType.bread;
      case IngredientTypeModel.protein:
        return IngredientType.protein;
      case IngredientTypeModel.topping:
        return IngredientType.topping;
      case IngredientTypeModel.sauce:
        return IngredientType.sauce;
    }
  }
}
