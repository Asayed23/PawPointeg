import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/pages/paymentmethod/payment_method.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:http/http.dart' as http;

class PayOnline extends StatefulWidget {
  String payUrl;
  PayOnline({this.payUrl});
  @override
  _PayOnlineState createState() => _PayOnlineState();
}

class _PayOnlineState extends State<PayOnline> {
  bool _loading, _showwebview;

  @override
  void initState() {
    _showwebview = true;
    _loading = true;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          Order _order;
          // Order _order = Order();
          _order = state.currentorder;
          final Map arguments =
              ModalRoute.of(context).settings.arguments as Map;
          widget.payUrl = arguments['payUrl'];
          return Scaffold(
            appBar: AppBar(
              title: Text('Pay Online'),
            ),
            body: Stack(
              children: <Widget>[
                if (_showwebview)
                  WebView(
                    initialUrl: widget.payUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (request) {
                      print(request.url);
                      if (request.url.contains('success=true')) {
                        print('Success');

                        String _url = request.url
                            .substring(request.url.indexOf('id=') + 2);
                        _url = _url.substring(1, _url.indexOf('&'));
                        print(_url);

                        _order.payid = _url;
                        StoreProvider.of<AppState>(context)
                            .dispatch(Updatecurrentorder(_order));
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          setState(() {
                            _loading = true;
                          });
                        });

                        storeorderindb(state, context);
                      } else if (request.url.contains('success=false')) {
                        print('Fails');

                        Future.delayed(const Duration(milliseconds: 2000), () {
                          setState(() {
                            _showwebview = false;
                          });
                        });
                      }
                      return NavigationDecision.navigate;
                    },
                    onPageFinished: (finish) {
                      setState(() {
                        _loading = false;
                      });
                    },
                  ),
                if (_showwebview == false)
                  Center(
                    child: Column(children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 70,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/paymethod');
                          },
                          child: Text(
                              'Payment Failed Go Back to Payement Method')),
                    ]),
                  ),
                _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(),
              ],
            ),
          );
        }));
  }
}
