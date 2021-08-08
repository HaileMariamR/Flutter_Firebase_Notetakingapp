import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:note_takingapp/appdatabase/Appdatabase.dart';
import 'package:get/get.dart';
import 'package:note_takingapp/screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:note_takingapp/appstate/Appstate.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ChangeNotifierProvider<DatePickerstate>(
        create: (_) => DatePickerstate(),
        child: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<DatePickerstate>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Title",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    
                    controller: controller1,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.lightBlueAccent,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Description",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: controller2,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      fillColor: Colors.lightBlueAccent,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: SfDateRangePicker(
                onSelectionChanged: appstate.onselectedChange,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
                child: ElevatedButton(
              onPressed: () {
                AppDatabase().addNote(
                    controller1.text, controller2.text, appstate.selecteddate);
                Get.to(() => HomePage());
                Get.snackbar(
                  "Added",
                  "Sucessfully added your note!",
                  icon: Icon(Icons.note, color: Colors.white),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  borderRadius: 10,
                  margin: EdgeInsets.all(15),
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                  isDismissible: true,
                  dismissDirection: SnackDismissDirection.HORIZONTAL,
                  forwardAnimationCurve: Curves.easeOutBack,
                );
              },
              child: Text("Add Note"),
            )),
          )
        ],
      ),
    );
  }
}
