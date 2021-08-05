import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_takingapp/appdatabase/Notemodel.dart';

class AppDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNote(String? inputtitle, String? inputdescription) async {
    try {
      firebaseFirestore.collection("notes").add(Note(
            title: inputtitle,
            Description: inputdescription,
          ).tojson());
    } catch (e) {
      print(e);
    }
  }
}
