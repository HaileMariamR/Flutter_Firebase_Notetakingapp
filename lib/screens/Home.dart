import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_takingapp/appdatabase/Appdatabase.dart';
import 'package:note_takingapp/screens/Addnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_takingapp/screens/Auth.dart';
import 'package:note_takingapp/utilities/constants.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import 'package:note_takingapp/widgets/Login.dart';

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
              margin: EdgeInsets.only(top: 10, left: 205),
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return List.generate(1, (index) {
                    return PopupMenuItem(
                      child: Text("Logout"),
                      value: index,
                    );
                  });
                },
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
                onSelected: (value) {
                  FirebaseAuth.instance.signOut();
                  Get.to(() => Auth());
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
            child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 130, left: 20),
                  child: Text(
                    "se.hailemariam.fikadie@gmail.com",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 90, left: 20),
                  child: Text(
                    "Eharry",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'pacifico',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://media-exp1.licdn.com/dms/image/C4E03AQGlC95Zri6GaA/profile-displayphoto-shrink_800_800/0/1574148998530?e=1632960000&v=beta&t=Su5ndfMs12vGrMoL95_6DiKTFHjTXQyZpJ6pMEmEYU8"),
                  ),
                ),
              ],
            ),
          ),
        ])),
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
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('time')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.docs.reversed.map((finalvalue) {
              var ts = finalvalue['time'];
              DateTime timevalue = ts.toDate();
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
                            padding: EdgeInsets.only(top: 20, left: 1),
                            child: Column(children: [
                              Text(
                                finalvalue['title'],
                                style: Ktitlestyle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 40),
                                child: Text(timevalue.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'DancingScript-Regular',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500)),
                              )
                            ]),
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
                                            fontFamily: 'DancingScript-Regular',
                                            fontSize: 20.0,
                                          ))
                                    ],
                                    text: "Description:     ",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontFamily: 'Lobster',
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
