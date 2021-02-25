import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

Widget homeappbar(context, titlename, state) {
  String _search_text = '';
  final Color inActiveIconColor = Color(0xFFB6B6B6);
  return AppBar(
    elevation: 0.0,
    actions: [
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/cart'),
        child: Badge(
          position: BadgePosition.topEnd(top: 8, end: 8),
          badgeContent: state.cartProducts.length > 0
              ? Text(state.cartProducts.length.toString(),
                  style: TextStyle(color: Colors.white))
              : null,
          badgeColor: Colors.blueGrey,
          child: state.cartProducts.length == 0
          ?IconButton(
            
            icon: SvgPicture.asset("assets/images/shopping-cart (1).svg",color: Color(0xffe83636),),
            iconSize: 33,
            
                
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          )
          :IconButton(
            icon: Icon(Icons.shopping_cart),
            iconSize: 33,
            color: Color(0xffe83636),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
      ),
    ],
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    backgroundColor: Colors.white,
    title: Container(
      height: h(7),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          _search_text = value;
          Navigator.pushNamed(context, '/search',
              arguments: {'senttext': value});
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.grey[300],
            filled: true,
            hintText: _search_text != null && _search_text != ''
                ? _search_text
                : "Search.....",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            )),
      ),
    ),
  );
}
