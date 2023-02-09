import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/models/food_model.dart';
import 'package:enebla_user_app/models/order_model.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

///there are a couple of things of to fix here
class OrderService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addFoodToOrderList(
      {required String foodName, required String price, required context}) {
    ///accept incomming food name , price and amount
    ///
    ///add it to a list in app State
    ///
    Map<String, List>? foodlist =
        AppStateProvider.of(context)?.state.orderFoodList;
    if (!(foodlist!['food']!.contains(foodName))) {
      AppStateProvider.of(context)?.state.orderFoodList['food']!.add(foodName);
      AppStateProvider.of(context)?.state.orderFoodList['price']!.add(price);
    }
  }

  removeFoodFromOrderList({required context, required String foodName}) {
    ///when you try to remove a value that already dont exist
    ///
    ///it gives an error should be fixed
    final index = AppStateProvider.of(context)
        ?.state
        .orderFoodList['food']!
        .indexOf(foodName);
    AppStateProvider.of(context)?.state.orderFoodList['food']!.removeAt(index!);

    AppStateProvider.of(context)
        ?.state
        .orderFoodList['price']!
        .removeAt(index!);
  }

  int getOrderTotal(context) {
    int total = 0;
    for (var val
        in AppStateProvider.of(context)!.state.orderFoodList['price']!) {
      total += int.parse(val);
    }
    return total;
  }

  addOrderToDatabase({
    required context,

    //we have to pass resturant uid here
  }) {
    ////there is a bug here when i make an order to the same resturant it is saved on data base in two separate resturant id which means i made an order to two separate resturants
    ///
    ///why is that?
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final resurantId =
        AppStateProvider.of(context)!.state.orderFoodList['resturantId']!.first;
    final foodList = AppStateProvider.of(context)!.state.orderFoodList['food'];
    final priceList =
        AppStateProvider.of(context)!.state.orderFoodList['price'];

    final total = getOrderTotal(context);

    final subtotal = total * 1.15;

    List placeHoler = [];

    int day = DateTime.now().day;

    String time = DateFormat.jm().format(DateTime.now());

    for (int i = 0; i < foodList!.length; i++) {
      placeHoler.add(
          Food(name: foodList[i], price: int.parse(priceList![i])).toJson());
    }

    String orderId = Uuid().v1();

    model.Order order = model.Order(
        day: day,
        time: time,
        orderby: uid,
        orderid: orderId,
        ordermadeto: resurantId,
        placeHolder: placeHoler,
        ordersubtotal: subtotal,
        ordertotal: total);

    print(orderId);
    _firestore
        .collection('order')
        .doc(resurantId)
        .set({
          uid: {
            'orderby': uid,
            'ordermadeto': resurantId,
            'orderlist': {orderId: placeHoler},
            'ordertotal': total,
            'ordersubtotal': subtotal,
            'day': DateTime.now().day,
            'time': DateFormat.jm().format(DateTime.now())
          }
        }, SetOptions(merge: true))
        .then((value) => print('order added successfully'))
        .onError((error, stackTrace) => print(error.toString()));

    //  Menu menuModel = Menu(id: menuId, name: name, listOfFood: foodItems);

    // _firestore
    //     .collection('menus')
    //     .doc(uid)
    //     .set({
    //       //this uid takes the resurant uid

    //       //we have to rename it as resturant
    //       'id': uid,
    //       'menulist': {name: menuModel.toJson()}
    //     }, SetOptions(merge: true))
    //     .then((value) => print('menu done'))
    //     .onError((error, stackTrace) => print(error.toString()));
  }
}
