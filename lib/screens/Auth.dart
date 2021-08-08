import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note_takingapp/widgets/Login.dart';
import 'package:note_takingapp/widgets/Register.dart';
import 'package:note_takingapp/appstate/Appstate.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_takingapp/auth/Mainauth.dart';
import 'package:note_takingapp/auth/Usermodel.dart';

const List<Color> colorsforgradient = [
  Colors.pink,
  Colors.pinkAccent,
  Colors.pinkAccent,
];

class Auth extends StatelessWidget {
  Auth({Key? key}) : super(key: key);
  var isSmall = false;

  @override
  Widget build(BuildContext context) {
    AuthUiState appstate = Get.put(AuthUiState(), permanent: true);
    if (MediaQuery.of(context).size.width < 600) {
      isSmall = true;
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 1.5,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(children: [
                ClipperBackground(),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2,
                      top: MediaQuery.of(context).size.height / 6),
                  height: 200,
                  child: Image(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/a5/72/a8/a572a843aed1084c3027dba5e4f11ebc.jpg",
                        scale: 0.1),
                  ),
                ),
              ]),
            ),
            
            Expanded(
                flex: 4,
                child: Container(
                  child: Obx(
                    () => Stack(
                      children: [
                        (appstate.changevalue.value.toString() == "login")
                            ? Login()
                            : Register()
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ClipperBackground extends StatelessWidget {
  const ClipperBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipperforTopView(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colorsforgradient,
                begin: Alignment.topLeft,
                end: Alignment.center)),
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}

class ClipperforTopView extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var initalpoint = new Offset(size.width / 7, size.height - 30);
    var endpoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(
        initalpoint.dx, initalpoint.dy, endpoint.dx, endpoint.dy);

    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return true;
  }
}
