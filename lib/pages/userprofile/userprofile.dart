import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpoint/models/enums.dart';
import 'package:pawpoint/pages/common/bottombar.dart';
import 'package:pawpoint/pages/common/theappbar.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            appBar: theappBar(context, 'Your Data'),
            bottomNavigationBar:
                CustomBottomNavBar(selectedMenu: MenuState.profile),
            body: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                new SizedBox(height: 20.0),
                new Container(
                  child: new ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return new Column(
                        children: <Widget>[
                          // _maincategory(context),
                          //Divider(),
                          SizedBox(height: h(3)),
                          _header('Hi ${state.user.username} '),
                          // Text('How Can we help You ?'),
                          new SizedBox(height: h(4)),
                          Divider(),

                          // Divider(),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/icons/forgot.svg",
                              width: 38,
                              height: 38,
                              color: Colors.blueGrey,
                            ),
                            title: _header('Forget My Password'),
                            onTap: () =>
                                Navigator.pushNamed(context, '/orderhistory'),
                          ),
                          Divider(),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/icons/order.svg",
                              width: 38,
                              height: 38,
                            ),
                            title: _header('My orders'),
                            onTap: () =>
                                Navigator.pushNamed(context, '/orderHistory'),
                          ),
                          Divider(),
                          ListTile(
                            leading: SvgPicture.asset(
                              "assets/icons/profile.svg",
                              width: 38,
                              height: 38,
                            ),
                            title: _header('Update My info data'),
                            onTap: () =>
                                Navigator.pushNamed(context, '/orderhistory'),
                          ),

                          Divider(),

                          new SizedBox(height: h(1)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(str,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold)),
    ),
  ));
}

_launchURL(urllink) async {
  //const url = urllink;

  if (await canLaunch(urllink)) {
    await launch(urllink);
  } else {
    throw 'Could not launch $urllink';
  }
}
