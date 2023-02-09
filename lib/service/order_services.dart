import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/models/food_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    for (int i = 0; i < foodList!.length; i++) {
      placeHoler.add(
          Food(name: foodList[i], price: int.parse(priceList![i])).toJson());
    }

    _firestore
        .collection('order')
        .doc(resurantId)
        .set({
          'orderby': uid,
          'orderfoodlist': placeHoler,
          'ordertotal': total,
          'ordersubtotal': subtotal
        })
        .then((value) => print('order added successfully'))
        .onError((error, stackTrace) => print(error.toString()));
  }
}
