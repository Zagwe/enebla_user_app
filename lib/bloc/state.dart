import 'package:enebla_user_app/bloc/comment_bloc.dart';
import 'package:enebla_user_app/bloc/subscription_bloc.dart';
import 'package:enebla_user_app/models/food_model.dart';
import 'package:enebla_user_app/screens/comment_and_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'order_bloc.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;

  const AppStateContainer({
    Key? key,
    required this.blocProvider,
    required this.child,
  }) : super(key: key);

  @override
  State<AppStateContainer> createState() => _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state = AppState();
  BlocProvider get blocProvider => widget.blocProvider;

  @override
  Widget build(BuildContext context) => AppStateProvider(
        state: state,
        stateWidget: this,
        blocProvider: widget.blocProvider,
        child: widget.child,
      );
}

class AppStateProvider extends InheritedWidget {
  final AppState state;
  final _AppStateContainerState stateWidget;
  final BlocProvider blocProvider;

  const AppStateProvider(
      {Key? key,
      required Widget child,
      required this.state,
      required this.stateWidget,
      required this.blocProvider})
      : super(key: key, child: child);

  static _AppStateContainerState? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AppStateProvider>()
      ?.stateWidget;

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) =>
      oldWidget.state != state;
}

class AppState {
  //we can define app state variables in there

  //everyting we define in here will be exposed to the rest of the app
  List<Food> selectedFoodList = [];

  Map<String, List> orderFoodList = {
    'food': [],
    'price': [],
    'resturantId': []
  };

  bool visibility = false;
}

class BlocProvider {
  final OrderBloc orderBloc;
  final CommentBloc commentBloc;
  final SubscriptionBloc subscriptionBloc;
  BlocProvider(
      {required this.orderBloc,
      required this.commentBloc,
      required this.subscriptionBloc});
}
