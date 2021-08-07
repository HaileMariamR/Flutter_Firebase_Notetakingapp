import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerstate extends ChangeNotifier {
  DateTime? selecteddate;

  onselectedChange(DateRangePickerSelectionChangedArgs args) {
    selecteddate = args.value;
    notifyListeners();
  }
}

class AuthUiState extends GetxController {
  var changevalue = "login".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print(changevalue.value);
    super.onInit();
  }

  void onClickforloginregister(String? input) {
    changevalue.value = input!;
  }
}
