import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  SubmitBtn({Key? key , this.title}) : super(key: key);
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/10,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.pink, Colors.pinkAccent])),
      child: Text(
        '${title}',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
