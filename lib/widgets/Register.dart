import 'package:flutter/material.dart';
import 'package:note_takingapp/auth/Mainauth.dart';
import 'package:note_takingapp/screens/Auth.dart';
import 'package:note_takingapp/screens/Home.dart';
import 'package:note_takingapp/widgets/GoogleSignin.dart';
import 'package:note_takingapp/widgets/Login.dart';
import 'package:note_takingapp/widgets/createorloginlable.dart';
import 'CustomTextField.dart';
import 'Submitbtn.dart';
import 'package:get/get.dart';
import 'Divider.dart';
import 'GoogleSignin.dart';
import 'package:provider/provider.dart';
import 'package:note_takingapp/appstate/Appstate.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();

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
                textEditingController: appstate.emailController,
                title: "Email",
              )),
          Expanded(
              flex: 2,
              child: CustomTextField(
                textEditingController: appstate.passwordController,
                title: "Password",
              )),
          Expanded(
              flex: 2,
              child: CustomTextField(
                textEditingController: appstate.confirmPasswordController,
                title: "Confirm",
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  await MainAuth()
                      .SignupwithEmail(appstate.emailController.text, appstate.passwordController.text)
                      .then((value) {
                    if (value != null) {
                      Get.to(() => Auth());
                      Get.snackbar(
                        "Check Your Email",
                        "You have just recived an email Verification!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                        borderRadius: 10,
                        margin: EdgeInsets.all(15),
                        colorText: Colors.red,
                        duration: Duration(seconds: 10),
                        isDismissible: true,
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        forwardAnimationCurve: Curves.easeOutBack,
                      );
                    }
                  });
                },
                child: SubmitBtn(
                  title: "Register",
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
                child: GoogleSignin()),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                appstate.onClickforloginregister("login");
                print(appstate.changevalue);
              },
              child: CreateorLoginLabel(
                title: "Login",
                detail: "have an account?",
              ),
            ),
          )
        ],
      ),
    );
  }
}
