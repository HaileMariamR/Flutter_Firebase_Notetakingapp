import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_takingapp/appdatabase/Notemodel.dart';
import 'package:note_takingapp/appstate/Appstate.dart';
class AppDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void addNote(String? inputtitle, String? inputdescription , DateTime? time) {
    try {
      firebaseFirestore.collection("notes").add(Note(
            title: inputtitle,
            Description: inputdescription,
            time: time

          ).tojson());
    } catch (e) {
      print(e);
    }
  }

  void deletenote(String id) {
    try {
      firebaseFirestore.collection('notes').doc('${id}').delete();
    } catch (e) {}
  }
}
