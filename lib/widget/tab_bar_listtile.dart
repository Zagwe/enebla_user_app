import 'package:enebla_user_app/bloc/order_bloc.dart';
import 'package:enebla_user_app/bloc/state.dart';
import 'package:enebla_user_app/screens/order/order.dart';
import 'package:flutter/material.dart';

class ListViewTile extends StatefulWidget {
  final name;
  final price;
  final containerColor;
  final notifyParent;

  const ListViewTile(
      {super.key,
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
            height: 60,
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
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
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
