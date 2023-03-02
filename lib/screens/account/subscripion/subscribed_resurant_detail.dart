import 'package:enebla_user_app/bloc/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:enebla_user_app/theme/style.dart' as style;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribedResturantDetail extends StatelessWidget {
  final name;
  final currentBalance;
  final imageUrl;
  final resturantId;
  final subscriptionAmount;

  SubscribedResturantDetail({
    super.key,
    required this.name,
    required this.currentBalance,
    required this.imageUrl,
    required this.resturantId,
    required this.subscriptionAmount,
  });
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of(context)!.blocProvider.subscriptionBloc;
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //resturant image an  name
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border(
                    bottom: BorderSide(color: Colors.grey.shade500, width: 1))),
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),

          //unsubscripiton info and caution
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'Unsubscription Form',
                  style: TextStyle(
                      height: 1.1, fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Text(
                    'if you wish to unsubscribe from this resturant please fill the your compliant in the following text field, we will get back to you with less that 24 hours!!'
                        .toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                //resturant informatino and caustino
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900),
                        children: [
                      TextSpan(
                          text:
                              'by filling this form you are requesting to unsubscribe from '
                                  .toUpperCase()),
                      TextSpan(
                          text: name,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w900)),
                      TextSpan(
                          text:
                              ' resturant which you currently have a balance of '
                                  .toUpperCase()),
                      TextSpan(
                          text: currentBalance,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w900)),
                    ])),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: controller,
                  scrollPadding: const EdgeInsets.all(12),
                  keyboardType: TextInputType.multiline,
                  minLines: 1, // <-- SEE HERE
                  maxLines: 5,
                  autofocus: true,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      focusColor: style.Style.primaryColor,
                      hoverColor: style.Style.primaryColor,
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'you need to write a complient';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,

                      ///unsubscribe button
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                                // side: BorderSide(
                                //     width: 5, color: Colors.red.shade900),
                                // borderRadius: BorderRadius.circular(10)
                                ),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              //logic
                              bloc.subscriptionService.unsubscribe(
                                  resturantId: resturantId,
                                  currentBalance: currentBalance,
                                  subscriptionAmount: subscriptionAmount,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  complinet: controller.text);
                            }
                          },
                          child: Text("unsubscribe".toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
