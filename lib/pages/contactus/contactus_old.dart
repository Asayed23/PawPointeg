import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawpoint/pages/common/theappbar.dart';
import 'package:pawpoint/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: theappBar(context, 'Contact Us'),
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/logo1.png'),
                    ),
                    // _header('Paw Point'),
                    // _horizontalListView(state.serviceProducts, 'service'),
                    new SizedBox(height: h(10)),
                    // Divider(),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/phone-call.svg",
                        width: 38,
                        height: 38,
                        color: Colors.blueGrey,
                      ),
                      title: Row(
                        children: [
                          GestureDetector(
                              onTap: () => _launchURL('tel:01020720189'),
                              child: _header('01020720189')),
                          GestureDetector(
                              onTap: () => _launchURL('tel:01008728854'),
                              child: _header('01008728854')),
                        ],
                      ),
                      onTap: () => {},
                    ),

                    // Divider(),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/whatsapp.svg",
                        width: 38,
                        height: 38,
                      ),
                      title: _header('01020720189'),
                      onTap: () =>
                          _launchURL('https://wa.me/message/DX6QGNPAX3ZKK1'),
                    ),
                    // Divider(),

                    Divider(),

                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/facebook.svg",
                        width: 38,
                        height: 38,
                      ),
                      title: _header('facebook.com/pawpointeg'),
                      onTap: () =>
                          _launchURL('https://www.facebook.com/pawpointeg'),
                    ),
                    Divider(),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/instagram.svg",
                        width: 38,
                        height: 38,
                      ),
                      title: _header('pawpointeg'),
                      onTap: () => _launchURL(
                          'https://instagram.com/pawpointeg?igshid=1xz7bs45up7zq'),
                    ),
                    Divider(),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/email.svg",
                        width: 38,
                        height: 38,
                      ),
                      title: _header('pawpoint20@gmail.com'),
                      // onTap: () => _launchURL('pawpoint20@gmail.com'),
                    ),
                    Divider(),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/gps.svg",
                        width: 38,
                        height: 38,
                      ),
                      title: _header('Paw point Al Sheikh Zayed, Giza'),
                      onTap: () => _launchURL(
                          'https://www.google.com/maps/dir//30.0435555,30.987951/@29.970908,31.023076,10z/data=!4m5!4m4!1m1!4e2!1m0!3e0'),
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
  }
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(str,
          style: new TextStyle(
              fontSize: 18.0,
              color: Color(0xffe83636),
              fontWeight: FontWeight.bold)),
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
