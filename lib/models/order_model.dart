import 'package:enebla_user_app/models/usermodel.dart';

import 'food_model.dart';

class Order {
  int id;
  User orderMadeBy;
  int orderTotalPrice;
  List<Food> listOfFoodItemsInOrder;
  Enum orderstatus;

  set setOrderStatus(Enum orderstatus) {
    this.orderstatus = orderstatus;
  }

  Order(
      {required this.id,
      required this.orderTotalPrice,
      required this.orderMadeBy,
      required this.listOfFoodItemsInOrder,
      required this.orderstatus});
  factory Order.fromMap(Map) {
    return Order(
      id: Map["id"],
      orderTotalPrice: Map["orderTotalPrice"],
      orderMadeBy: Map['orderMadeBy'],
      listOfFoodItemsInOrder: Map["listOfFoodItemsInOrder"],
      orderstatus: Map["orderstatus"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "orderTotalprice": orderTotalPrice,
      "listOfFoodItemsInOrder": listOfFoodItemsInOrder,
      "orderMadeBy": orderMadeBy,
      "orderstatus": orderstatus
    };
  }
}
