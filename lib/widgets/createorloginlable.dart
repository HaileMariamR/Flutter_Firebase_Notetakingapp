import 'package:flutter/material.dart';

class CreateorLoginLabel extends StatelessWidget {
  CreateorLoginLabel({Key? key, this.title, this.detail}) : super(key: key);
  String? title;
  String? detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${detail}',
            style: TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '${title}',
            style: TextStyle(
                color: Colors.red, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
