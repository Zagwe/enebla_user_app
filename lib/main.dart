import 'package:enebla_user_app/bloc/order_bloc.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/bloc/subscription_bloc.dart';
import 'package:enebla_user_app/screens/chapapayment/fallback.dart';
import 'package:enebla_user_app/screens/onboarding/onBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/another_style.dart' as style;
import 'package:shared_preferences/shared_preferences.dart';

//added some import 'bloc/comment_bloc.dart';

import 'bloc/comment_bloc.dart';
import 'enebla_user_home.dart';

int? isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final blocProvider = BlocProvider(
      subscriptionBloc: SubscriptionBloc(),
      commentBloc: CommentBloc(),
      orderBloc: OrderBloc());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('OnBording');

  // print(FirebaseAuth.instance.currentUser!.uid);
  runApp(
      AppStateContainer(blocProvider: blocProvider, child: const EneblaUser()));
}

class EneblaUser extends StatelessWidget {
  const EneblaUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: style.Style.themeData,
        home: isViewed != 0 ? OnBording() : EneblaHome(),
        routes: {"/fallback": (context) => Fallback()});
  }
}
