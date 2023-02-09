import 'dart:async';

import 'package:enebla_user_app/service/order_services.dart';
import 'package:rxdart/subjects.dart';

class OrderBloc {
  StreamController<bool> displayFloatinActionButton = BehaviorSubject<bool>();

  Stream<bool> get dispalayFloatingStream => displayFloatinActionButton.stream;
  final OrderService orderService = OrderService();
}
