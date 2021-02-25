import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDproductdetails extends StatelessWidget {
  XDproductdetails({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffcfc),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(319.0, 30.0),
            child:
                // Adobe XD layer: 'surface1' (group)
                SizedBox(
              width: 30.0,
              height: 30.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                    size: Size(30.0, 30.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_xy445i,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(32.0, 35.0),
            child:
                // Adobe XD layer: 'surface1' (group)
                SizedBox(
              width: 30.0,
              height: 30.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                    size: Size(30.0, 30.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_vyar5m,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(138.0, 20.0),
            child: Text(
              'DETIALS',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xff856d49),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(20.0, 281.0),
            child: Text(
              'Fokker Cat Dry Food ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff3e3937),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(19.0, 330.0),
            child: Text(
              'Available weight',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff3e3937),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(259.0, 324.0),
            child: Text(
              '2Kg',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xffe44600),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(251.0, 286.0),
            child: Text(
              '275.0 EGP',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xffe44600),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(19.0, 380.0),
            child: Text(
              'Description',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xff3e3937),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 471.0),
            child: Text(
              'Weight ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 502.0),
            child: Text(
              'Food Form ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 429.0),
            child: Transform.rotate(
              angle: 0.0,
              child: Container(
                width: 375.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: const Color(0xffd8cfcf),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(18.0, 440.0),
            child: Text(
              'Item ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(53.0, 440.0),
            child: Text(
              'Number ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 533.0),
            child: Transform.rotate(
              angle: 0.0,
              child: Container(
                width: 375.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: const Color(0xffd8cfcf),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 583.0),
            child: Text(
              'Made In ',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 542.0),
            child: Text(
              'Lifestage',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(351.0, 471.0),
            child: Text(
              '2',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(297.0, 502.0),
            child: Text(
              'Dry Food',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(331.0, 542.0),
            child: Text(
              'Dog',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(256.0, 583.0),
            child: Text(
              'Made in France',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(314.0, 440.0),
            child: Text(
              '123456',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff3d3333),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(276.0, 645.0),
            child: Container(
              width: 75.0,
              height: 49.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                color: const Color(0xff554337),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(319.2, 662.4),
            child: Transform.rotate(
              angle: -1.5533,
              child:
                  // Adobe XD layer: 'surface1' (group)
                  SizedBox(
                width: 15.0,
                height: 20.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 15.0, 20.0),
                      size: Size(15.0, 20.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: SvgPicture.string(
                        _svg_2szmc,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(290.0, 656.0),
            child: Text(
              '1',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xfffcf0eb),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(5.0, 106.0),
            child: Container(
              width: 364.0,
              height: 152.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(-0.02, -0.21),
                  colors: [const Color(0xff463631), const Color(0xfffcd576)],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(133.0, 84.0),
            child:
                // Adobe XD layer: 'IMG_20201221_110621' (shape)
                Container(
              width: 110.0,
              height: 146.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(-10, -10),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(130.0, 237.0),
            child: Transform.rotate(
              angle: -0.0175,
              child: Container(
                width: 109.0,
                height: 16.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xffb5975b),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 744.0),
            child: Container(
              width: 343.0,
              height: 62.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 0.71),
                  colors: [const Color(0xfff39542), const Color(0xff7a4b21)],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(-10, -10),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(131.0, 762.0),
            child: Text(
              'Add To Cart',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff0d0d0d),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_xy445i =
    '<svg viewBox="0.0 2.3 30.0 30.0" ><path transform="translate(0.0, 0.0)" d="M 21.25313949584961 2.324219703674316 C 19.85628128051758 2.324219703674316 18.51797866821289 2.678227424621582 17.28048133850098 3.37589693069458 C 16.43904113769531 3.848768711090088 15.66329956054688 4.479255199432373 15 5.228607654571533 C 14.33670043945313 4.479255199432373 13.56096076965332 3.848768711090088 12.71952152252197 3.37589693069458 C 11.48202037811279 2.678227424621582 10.14377975463867 2.324219703674316 8.74452018737793 2.324219703674316 C 3.923436164855957 2.324219703674316 0 6.649797439575195 0 11.96501731872559 C 0 15.73251533508301 1.804686307907104 19.73246383666992 5.362500190734863 23.85393142700195 C 8.332019805908203 27.29577255249023 11.96952056884766 30.16402816772461 14.49612045288086 31.96503067016602 L 15 32.32422256469727 L 15.50387954711914 31.96503067016602 C 18.03048133850098 30.16402816772461 21.66797828674316 27.29577255249023 24.63749885559082 23.85393142700195 C 28.19532012939453 19.73246383666992 30 15.73251533508301 30 11.96501731872559 C 30 6.649797439575195 26.0765380859375 2.324219703674316 21.25313949584961 2.324219703674316 Z M 23.29452133178711 22.44308853149414 C 20.6390380859375 25.52057647705078 17.40468215942383 28.1356086730957 15 29.88494873046875 C 12.59532165527344 28.1356086730957 9.360960006713867 25.52057647705078 6.705481052398682 22.44308853149414 C 3.487500190734863 18.71442031860352 1.856249928474426 15.18982124328613 1.856249928474426 11.96501731872559 C 1.856249928474426 7.776408672332764 4.947654247283936 4.370729923248291 8.746860504150391 4.370729923248291 C 10.93361949920654 4.370729923248291 12.94218063354492 5.476669788360596 14.25702095031738 7.409475803375244 L 15 8.49737548828125 L 15.74298095703125 7.409475803375244 C 17.05782318115234 5.476669788360596 19.06637954711914 4.370729923248291 21.25313949584961 4.370729923248291 C 25.05234146118164 4.370729923248291 28.14378547668457 7.776408672332764 28.14378547668457 11.96501731872559 C 28.14378547668457 15.18982124328613 26.51249885559082 18.71442031860352 23.29452133178711 22.44308853149414 Z M 23.29452133178711 22.44308853149414" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_vyar5m =
    '<svg viewBox="0.0 2.1 30.0 30.0" ><path transform="translate(0.0, 0.0)" d="M 28.19425010681152 14.68076229095459 C 28.07315444946289 14.65802574157715 27.94815826416016 14.64438343048096 27.82316398620605 14.64892959594727 L 6.659911632537842 14.64892959594727 L 7.120824813842773 14.39834785461426 C 7.573937892913818 14.14788150787354 7.984082221984863 13.81077861785889 8.335629463195801 13.39636611938477 L 14.268967628479 6.477505207061768 C 15.05023956298828 5.60752010345459 15.18303489685059 4.204629421234131 14.58145713806152 3.161568164825439 C 13.88228225708008 2.045617580413818 12.5386323928833 1.804211735725403 11.58156776428223 2.619532823562622 C 11.5034704208374 2.683303594589233 11.429274559021 2.756181716918945 11.36287689208984 2.833618640899658 L 0.6288825273513794 15.35042190551758 C -0.2109301686286926 16.32511901855469 -0.2109301686286926 17.91023826599121 0.6288825273513794 18.88948249816895 L 11.36287689208984 31.40626525878906 C 12.20264530181885 32.38096237182617 13.55809497833252 32.38096237182617 14.39786338806152 31.4017162322998 C 14.46426105499268 31.32429122924805 14.52285957336426 31.24231910705566 14.58145713806152 31.15567970275879 C 15.18303489685059 30.10810852050781 15.05023956298828 28.70978927612305 14.268967628479 27.83980560302734 L 8.347349166870117 20.90732192993164 C 8.030950546264648 20.53838539123535 7.667684078216553 20.22856712341309 7.273169040679932 19.99174308776855 L 6.628663063049316 19.65475845336914 L 27.70596885681152 19.65475845336914 C 28.80362892150879 19.70023345947266 29.76449012756348 18.80750846862793 29.97158241271973 17.5503978729248 C 30.15907669067383 16.18845748901367 29.3661060333252 14.90394401550293 28.19425010681152 14.68076229095459 Z M 28.19425010681152 14.68076229095459" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_2szmc =
    '<svg viewBox="10.3 0.0 15.0 20.0" ><path  d="M 15.35306167602539 10.00467967987061 L 24.90358352661133 2.521875858306885 C 25.16686630249023 2.317188024520874 25.3125 2.042187929153442 25.3125 1.748435854911804 C 25.3125 1.4546879529953 25.16686630249023 1.181252002716064 24.90358352661133 0.9750000238418579 L 24.06782150268555 0.3203123807907104 C 23.80453491210938 0.1140623912215233 23.45347213745117 0 23.08044815063477 0 C 22.70543670654297 0 22.35437202453613 0.1140623912215233 22.09307861328125 0.3203123807907104 L 10.71942710876465 9.228119850158691 C 10.45614242553711 9.434359550476074 10.3125 9.710919380187988 10.3125 10.00311946868896 C 10.3125 10.29843902587891 10.45614242553711 10.5734395980835 10.71942710876465 10.78124046325684 L 22.08113098144531 19.67967987060547 C 22.34441566467285 19.88591957092285 22.69548034667969 20 23.07049179077148 20 C 23.44346237182617 20 23.79452896118164 19.88591957092285 24.057861328125 19.67967987060547 L 24.89362335205078 19.02499961853027 C 25.43817138671875 18.59844017028809 25.43817138671875 17.9046802520752 24.89362335205078 17.47812080383301 L 15.35306167602539 10.00467967987061 Z M 15.35306167602539 10.00467967987061" fill="#fff3f3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
