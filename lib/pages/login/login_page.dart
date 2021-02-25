import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pawpoint/size_config.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _svg_z1bue0 =
    '<svg viewBox="34.7 605.0 306.5 1.0" ><path transform="translate(15.0, 551.0)" d="M 326 54 L 20 54 C 8.954304695129395 54 337.0456848144531 54 326 54 Z" fill="#e83333" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yo28rr =
    '<svg viewBox="0.0 0.0 30.0 30.0" ><path  d="M 27.1734619140625 2.826565265655518 C 23.40233993530273 -0.94218510389328 17.26877975463867 -0.94218510389328 13.50000190734863 2.826565265655518 C 10.9242000579834 5.402347564697266 10.03128051757813 9.19686222076416 11.1445198059082 12.63984298706055 L 0.2578127980232239 23.52654266357422 C 0.09375 23.6929817199707 0 23.91564178466797 0 24.15000152587891 L 0 29.12112236022949 C 0 29.60628128051758 0.393750011920929 30.00000381469727 0.8789039850234985 30.00000381469727 L 5.850000381469727 30.00000381469727 C 6.084360122680664 30.00000381469727 6.30702018737793 29.90628242492676 6.47346019744873 29.7421817779541 L 7.715640068054199 28.4976634979248 C 7.90548038482666 28.3101634979248 7.996860504150391 28.04298400878906 7.96638011932373 27.77580070495605 L 7.811699867248535 26.43984031677246 L 9.663299560546875 26.26638221740723 C 10.08282089233398 26.22653961181641 10.41564083099365 25.89378356933594 10.45548057556152 25.47420310974121 L 10.62887954711914 23.62266159057617 L 11.96484088897705 23.77968406677246 C 12.21330070495605 23.81250190734863 12.46170043945313 23.72814178466797 12.65154075622559 23.56170272827148 C 12.83670234680176 23.39532089233398 12.94451904296875 23.15628051757813 12.94451904296875 22.90548324584961 L 12.94451904296875 21.26952171325684 L 14.55234146118164 21.26952171325684 C 14.78436088562012 21.26952171325684 15.00936126708984 21.17580032348633 15.17346096038818 21.01170349121094 L 17.42814064025879 18.78750038146973 C 20.8687801361084 19.90314292907715 24.5976619720459 19.0757999420166 27.1734619140625 16.50000190734863 C 30.94218063354492 12.73128128051758 30.94218063354492 6.597661972045898 27.1734619140625 2.826565265655518 Z M 24.68669891357422 9.042182922363281 C 23.65781784057617 10.07112312316895 21.98670196533203 10.07112312316895 20.95782089233398 9.042182922363281 C 19.92888259887695 8.013302803039551 19.92888259887695 6.34218168258667 20.95782089233398 5.31328296661377 C 21.98670196533203 4.284379005432129 23.65781784057617 4.284379005432129 24.68669891357422 5.31328296661377 C 25.71564102172852 6.34218168258667 25.71564102172852 8.013302803039551 24.68669891357422 9.042182922363281 Z M 24.68669891357422 9.042182922363281" fill="#0a0a0a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dvnr53 =
    '<svg viewBox="82.5 458.5 210.0 84.0" ><path transform="translate(82.5, 458.5)" d="M 0 1 L 210 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(82.5, 541.5)" d="M 0 1 L 210 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_r66f5d =
    '<svg viewBox="0.0 3.7 25.0 25.0" ><path transform="translate(0.0, 0.0)" d="M 22.80470085144043 3.710939645767212 L 2.195310115814209 3.710939645767212 C 0.984375 3.710939645767212 0 5.116491317749023 0 6.833151817321777 L 0 25.5887393951416 C 0 27.31645202636719 0.9921879768371582 28.71093940734863 2.195310115814209 28.71093940734863 L 22.80470085144043 28.71093940734863 C 24.00779914855957 28.71093940734863 25 27.32199859619141 25 25.5887393951416 L 25 6.833151817321777 C 25 5.122051239013672 24.01950073242188 3.710939645767212 22.80470085144043 3.710939645767212 Z M 22.4960994720459 5.79426383972168 C 22.04689979553223 6.427592277526855 14.32030010223389 17.36091804504395 14.05469989776611 17.7386589050293 C 13.63669967651367 18.32760047912598 13.08590030670166 18.64973258972168 12.5 18.64973258972168 C 11.91409969329834 18.64973258972168 11.35939979553223 18.32760047912598 10.94530010223389 17.73311233520508 C 10.76560020446777 17.48308563232422 3.125 6.672042846679688 2.503910064697266 5.79426383972168 L 22.4960994720459 5.79426383972168 Z M 1.464840054512024 25.16093635559082 L 1.464840054512024 7.260927200317383 L 7.792970180511475 16.21645736694336 L 1.464840054512024 25.16093635559082 Z M 2.507810115814209 26.62752914428711 L 8.832030296325684 17.68319320678711 L 9.910160064697266 19.21093940734863 C 10.60159969329834 20.19426345825195 11.52340030670166 20.73314094543457 12.5 20.73314094543457 C 13.47659969329834 20.73314094543457 14.39840030670166 20.19426345825195 15.08979988098145 19.21093940734863 L 16.16799926757813 17.68319320678711 L 22.49220085144043 26.62752914428711 L 2.507810115814209 26.62752914428711 Z M 23.53520011901855 25.16093635559082 L 17.20700073242188 16.21645736694336 L 23.53520011901855 7.260927200317383 L 23.53520011901855 25.16093635559082 Z M 23.53520011901855 25.16093635559082" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting, _obscureText = true;
  String _email, _username, _password;

  Widget _showTitle() {
    return Text('Login', style: Theme.of(context).textTheme.headline);
  }

  Widget _showUsernameInput1() {
    return Padding(
        padding: EdgeInsets.only(top: 70.0),
        child: TextFormField(
            onSaved: (val) => _username = val,
            validator: (val) => val.length < 4 ? 'Username too short' : null,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email',
              hintText: 'Enter your Email',
              // icon: Icon(Icons.face, color: Colors.grey)
              // icon: Icon(Icons.mail, color: const Color(0xffe83636))
            )));
  }

  Widget _showUsernameInput() {
    return Padding(
        padding: EdgeInsets.only(top: h(9), left: w(5), right: w(2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 35),
                child: Text(
                  'Email ',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: w(5),
                    color: const Color(0xff0a0a0a),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                )),
            new Flexible(
                child: TextFormField(
                    onSaved: (val) => _username = val,
                    validator: (val) =>
                        val.length < 1 ? 'Email too short' : null,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(),
                      // disabledBorder: UnderlineInputBorder(),
                      // border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      // labelText: 'Email',
                      hintText: '          Enter your Email',
                      // icon: Icon(Icons.face, color: Colors.grey)
                      // icon: Icon(Icons.mail, color: const Color(0xffe83636))
                    ))),
            Icon(Icons.mail, color: Colors.black, size: w(7.5)),
          ],
        ));
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: EdgeInsets.only(top: h(3), left: w(5), right: w(2.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Password ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff0a0a0a),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            new Flexible(
                child: TextFormField(
                    onSaved: (val) => _password = val,
                    validator: (val) =>
                        val.length < 1 ? 'Password too short' : null,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => _obscureText = !_obscureText);
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      enabledBorder: UnderlineInputBorder(),

                      focusedBorder: UnderlineInputBorder(),
                      // labelText: 'Email',
                      hintText: '          Enter your Password',
                      // icon: Icon(Icons.face, color: Colors.grey)
                      // icon: Icon(Icons.mail, color: const Color(0xffe83636))
                    ))),
            SizedBox(
              width: w(7.5),
              height: h(4),
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                    size: Size(h(4), h(4)),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_yo28rr,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _showEmailInput() {
    return Padding(
        padding: EdgeInsets.only(top: h(7)),
        child: TextFormField(
            onSaved: (val) => _email = val,
            validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter a valid email',
                icon: Icon(Icons.mail, color: Colors.grey))));
  }

  Widget _showPasswordInput1() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
            onSaved: (val) => _password = val,
            validator: (val) => val.length < 6 ? 'Username too short' : null,
            obscureText: _obscureText,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off)),
              border: UnderlineInputBorder(),
              labelText: 'Password',
              hintText: '      Enter password, min length 6',
              // icon: Icon(Icons.lock, color: Colors.grey)
            )));
  }

  Widget _showFormActions() {
    return ButtonTheme(
      minWidth: w(35),
      height: h(5),
      // alignedDropdown: Alignment.centerRight,

      child: _isSubmitting == true
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor))
          : RaisedButton(
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 30,
                  color: const Color(0xfffefcfc),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: const Color(0xffe83636),
              onPressed: _submit),
    );
  }

  void _submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    print(_username);
    print(_password);
    http.Response response = await http
        .post(login_url, body: {'username': _username, 'password': _password});
    final responseData = json.decode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      //final String errorMsg = responseData['errorcode'].toString();
      _showErrorSnack('Invalid Username or Password');
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData; //['user'];
    user.putIfAbsent('jwt', () => responseData['token']);
    prefs.setString('user', json.encode(user));
    print("-------------login------------------------");
    print(json.encode(user));
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text('User successfully logged in!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error logging in: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: h(100),
                height: w(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: h(40)),
                child: Container(
                    width: w(100),
                    height: h(100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffffffff)),
                    ),
                    child: Column(children: [
                      Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _showUsernameInput(),
                                _showPasswordInput(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: h(6), left: w(5)),
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 15,
                                      color: const Color(0xffe83636),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: h(3), right: w(5)),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _showFormActions(),
                                  ),
                                )
                              ])),
                      Padding(
                          padding: EdgeInsets.only(top: h(6), left: w(5)),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff1e1c1c),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ))),
                      Padding(
                          padding: EdgeInsets.only(top: h(3)),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 25,
                                      color: const Color(0xffe83636),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/register'))))
                    ])),
              ),
            ],
          ),
        ));
  }
}
