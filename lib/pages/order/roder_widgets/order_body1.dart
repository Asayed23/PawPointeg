import 'package:flutter/material.dart';
import 'package:pawpoint/pages/order/roder_widgets/order_item.dart';
import 'package:pawpoint/size_config.dart';

Widget orderbody1(state, context, _scaffoldKey) {
  return SizedBox(
    width: double.infinity,
    child: Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Thanks Order completed ${state.currentorder.orderNumber} ",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    TextButton(
                      child: Text("add"),
                      onPressed: () {},
                    )
                  ]),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              _youritems(state, context)
            ],
          ),
        ),
      ),
    ),
  );
}

/////
///
///
Widget _youritems(state, context) {
  return Column(
    children: [
      Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("your order items",
            style: TextStyle(backgroundColor: Colors.grey)),
      )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: state.cartProducts.length,
          // scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  SizeConfig.orientation == Orientation.portrait ? 1 : 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 4.0,
              childAspectRatio:
                  SizeConfig.orientation == Orientation.portrait ? 3 : 1.3),
          itemBuilder: (context, i) => OrderItem(item: state.cartProducts[i]),
        ),
      ),
    ],
  );
}
