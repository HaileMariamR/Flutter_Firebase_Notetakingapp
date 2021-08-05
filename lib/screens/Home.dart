import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_takingapp/screens/Addnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: "Search notes...",
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
          primary: false,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 2,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(),
        body: BodyStream(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => AddNote());
          },
        ),
      ),
    );
  }
}

class BodyStream extends StatelessWidget {
  const BodyStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((finalvalue) {
              return ListTile(
                title: Text((finalvalue['title']!= null)?finalvalue['title']:""),
                subtitle: Text((finalvalue["Description"] != null)?finalvalue['Description']:""),
              );
            }).toList(),
          );
        });
  }
}
