import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:note_takingapp/auth/Mainauth.dart';
import 'package:note_takingapp/screens/Auth.dart';
import 'package:note_takingapp/screens/Home.dart';
import 'package:note_takingapp/widgets/GoogleSignin.dart';
import 'package:note_takingapp/widgets/createorloginlable.dart';
import 'CustomTextField.dart';
import 'Submitbtn.dart';
import 'Divider.dart';
import 'package:get/get.dart';
import 'GoogleSignin.dart';
import 'package:note_takingapp/appstate/Appstate.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var con1 = TextEditingController();
  var con2 = TextEditingController();
  var con3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthUiState appstate = Get.find();
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: CustomTextField(
              textEditingController: con1,
              title: "Email Address",
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomTextField(
              textEditingController: con2,
              title: "Password",
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  await MainAuth()
                      .SigninwithEmail(con1.text, con2.text)
                      .then((value) {
                    if (value != null) {
                      Get.to(() => HomePage());
                      Get.snackbar(
                        "Logged In",
                        "Well come back! Succesfully Logged In!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        borderRadius: 10,
                        margin: EdgeInsets.all(15),
                        colorText: Colors.red,
                        duration: Duration(seconds: 2),
                        isDismissible: true,
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    } else {
                      Get.to(() => Auth());

                      Get.snackbar(
                        "Faild",
                        "Email or password incorrect!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        borderRadius: 10,
                        margin: EdgeInsets.all(15),
                        colorText: Colors.red,
                        duration: Duration(seconds: 2),
                        isDismissible: true,
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    }
                  });
                },
                child: SubmitBtn(
                  title: "Login",
                ),
              )),
          Expanded(
            flex: 1,
            child: CustomDivider(),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                MainAuth().SignupinwithGoogle().then((value) {
                  if (value != null) {
                    Get.to(() => HomePage());
                    Get.snackbar(
                      "Logged In",
                      "Well come back! Succesfully Logged In!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      borderRadius: 10,
                      margin: EdgeInsets.all(15),
                      colorText: Colors.red,
                      duration: Duration(seconds: 2),
                      isDismissible: true,
                      dismissDirection: SnackDismissDirection.HORIZONTAL,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  } else {
                    Get.to(() => Auth());

                    Get.snackbar(
                      "Faild",
                      "Email or password incorrect!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      borderRadius: 10,
                      margin: EdgeInsets.all(15),
                      colorText: Colors.red,
                      duration: Duration(seconds: 2),
                      isDismissible: true,
                      dismissDirection: SnackDismissDirection.HORIZONTAL,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  }
                });
              },
              child: GoogleSignin(),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                appstate.onClickforloginregister("register");
                print(appstate.changevalue);
              },
              child: CreateorLoginLabel(
                title: "Register",
                detail: "Don\'t have an account?",
              ),
            ),
          )
        ],
      ),
    );
  }
}
