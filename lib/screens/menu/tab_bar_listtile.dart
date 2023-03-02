import 'package:enebla_user_app/bloc/order_bloc.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/screens/order/order.dart';
import 'package:flutter/material.dart';
import 'package:enebla_user_app/theme/style.dart' as style;

class ListViewTile extends StatefulWidget {
  final name;
  final price;
  final containerColor;
  String? image;
  final notifyParent;

  ListViewTile(
      {super.key,
      this.image,
      required this.notifyParent,
      required this.name,
      required this.price,
      required this.containerColor});

  @override
  State<ListViewTile> createState() => _ListViewTileState();
}

class _ListViewTileState extends State<ListViewTile>
    with AutomaticKeepAliveClientMixin {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    // print(widget.image);
    final state = AppStateProvider.of(context)?.state;
    super.build(context);
    // final OrderBloc? bloc =
    //     AppStateProvider.of(context)?.blocProvider.orderBloc;
    // final bloc = AppStateProvider.of(context)?.blocProvider.orderBloc;

    final bloc = OrderBloc();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            widget.notifyParent(context);

            if (checked == true) {
              bloc.orderService.removeFoodFromOrderList(
                  context: context, foodName: widget.name);
              print(AppStateProvider.of(context)?.state.orderFoodList['food']);
              print(AppStateProvider.of(context)?.state.orderFoodList['price']);

              setState(() {
                checked = false;
              });
            } else {
              bloc.orderService.addFoodToOrderList(
                  context: context, foodName: widget.name, price: widget.price);
              print(AppStateProvider.of(context)?.state.orderFoodList['food']);
              print(AppStateProvider.of(context)?.state.orderFoodList['price']);
              setState(() {
                checked = true;
              });
            }
          },
          child: Container(
            // height: 100,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0.0, 10), //(x,y)
                      blurRadius: 1.0,
                      blurStyle: BlurStyle.inner),
                ],
                color: widget.containerColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.image == null
                        ? Image.asset(
                            'lib/assets/pubspec.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.network(widget.image!,
                            height: 80, width: 80, fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: style.Style.SecondaryColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.price,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Checkbox(
                        value: checked,
                        checkColor: Colors.green,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            checked = value!;
                          });
                          if (checked == true) {
                            bloc.orderService.addFoodToOrderList(
                                context: context,
                                foodName: widget.name,
                                price: widget.price);
                          } else {
                            bloc.orderService.removeFoodFromOrderList(
                                foodName: widget.name, context: context);
                          }
                        })
                  ],
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
