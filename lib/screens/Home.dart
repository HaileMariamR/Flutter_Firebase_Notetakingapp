import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_takingapp/appdatabase/Appdatabase.dart';
import 'package:note_takingapp/screens/Addnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_takingapp/utilities/constants.dart';

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
          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.docs.map((finalvalue) {
              return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.all(5),
                  child: Stack(children: [
                    Card(
                      color: Colors.amber,
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Text(
                              finalvalue['title'],
                              style: Ktitlestyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Divider(
                              height: 2,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: finalvalue['Description'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'DancingScript',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                    text: "Description:     ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'WindSong',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 205),
                      child: PopupMenuButton(
                        itemBuilder: (context) {
                          return List.generate(1, (index) {
                            return PopupMenuItem(
                              child: Text("Delete"),
                              value: index,
                            );
                          });
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                        onSelected: (value) {
                          AppDatabase().deletenote(finalvalue.id);
                        },
                      ),
                    ),
                  ]));
            }).toList(),
          );
        });
  }
}
