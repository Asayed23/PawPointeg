import 'package:flutter/material.dart';

Widget cardTab(state, context, _scaffoldKey) {
  /*     _addCard(cardToken) async {
      final User user = state.user;
      // update user's data to include cardToken (PUT /users/:id)
      await http.put('http://localhost:1337/users/${user.id}',
          body: {"card_token": cardToken},
          headers: {"Authorization": "Bearer ${user.jwt}"});
      // associate cardToken (added card) with Stripe customer (POST /card/add)
      http.Response response = await http.post('http://localhost:1337/card/add',
          body: {"source": cardToken, "customer": user.customerId});
      final responseData = json.decode(response.body);
      return responseData;
    } */

  return Column(children: [
    Padding(padding: EdgeInsets.only(top: 10.0)),
    RaisedButton(
        elevation: 8.0,
        child: Text('Add Card'),
        onPressed: () async {
          //final String cardToken = "xksds";
          // Show snackbar
          final snackbar = SnackBar(
              content:
                  Text('Card Added!', style: TextStyle(color: Colors.green)));
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }),
    Expanded(
        child: ListView(
            children: state.cards
                .map<Widget>((c) => (ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: Icon(Icons.credit_card, color: Colors.white)),
                    title: Text(
                        "${c['card']['exp_month']}/${c['card']['exp_year']}, ${c['card']['last4']}"),
                    subtitle: Text(c['card']['brand']),
                    trailing: state.cardToken == c['id']
                        ? Chip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(Icons.check_circle,
                                    color: Colors.white)),
                            label: Text("Primary Card"))
                        : FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text('Set as Primary',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink)),
                            onPressed: () {
                              print('store card in database');
                            }))))
                .toList()))
  ]);
}
