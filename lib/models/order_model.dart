import 'package:enebla_user_app/models/usermodel.dart';

import 'food_model.dart';

class Order {
  String orderby;
  String ordermadeto;
  String orderid;
  int ordertotal;
  double ordersubtotal;
  int day;
  List placeHolder;
  String time;

  Order(
      {required this.day,
      required this.time,
      required this.orderby,
      required this.orderid,
      required this.ordermadeto,
      required this.placeHolder,
      required this.ordersubtotal,
      required this.ordertotal});

  // Order(
  //     {required this.id,
  //     required this.orderTotalPrice,
  //     required this.orderMadeBy,
  //     required this.listOfFoodItemsInOrder,
  //     required this.orderstatus});

  factory Order.fromMap(Map) {
    return Order(
      orderby: Map['orderby'],
      ordermadeto: Map['ordermadeto'],
      day: Map['day'],
      orderid: Map['orderid'],
      ordersubtotal: Map['ordersubtotal'],
      ordertotal: Map['ordertotal'],
      placeHolder: Map['placeHolder'],
      time: Map['time'],

      // id: Map["id"],
      // orderTotalPrice: Map["orderTotalPrice"],
      // orderMadeBy: Map['orderMadeBy'],
      // listOfFoodItemsInOrder: Map["listOfFoodItemsInOrder"],
      // orderstatus: Map["orderstatus"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      orderby: {
        'orderby': orderby,
        'ordermadeto': ordermadeto,
        'orderlist': {orderid: placeHolder},
        'ordertotal': ordertotal,
        'ordersubtotal': ordersubtotal,
        'day': day,
        'time': time
      }
    };
  }
}
