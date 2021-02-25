import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpoint/constants.dart';
import 'package:pawpoint/models/enums.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          final Color inActiveIconColor = Color(0xFFB6B6B6);
          return Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 20,
                  color: Color(0xFFDADADA).withOpacity(0.15),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.home,
                          color: MenuState.home == widget.selectedMenu
                              ? Theme.of(context).primaryColor
                              : inActiveIconColor,
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/home')),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: MenuState.fav == widget.selectedMenu
                            ? Theme.of(context).primaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/favorite');
                      },
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.account_circle,
                          color: MenuState.profile == widget.selectedMenu
                              ? Theme.of(context).primaryColor
                              : inActiveIconColor,
                        ),
                        onPressed: () {
                          return state.user != null
                              ? Navigator.pushNamed(context, '/profile')
                              : Navigator.pushNamed(context, '/login');
                        }),
                  ],
                )),
          );
        });
  }
}
