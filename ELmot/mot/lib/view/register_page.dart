import 'package:flutter/material.dart';

import '../helper/constant_style.dart';
import '../helper/constants.dart';
import '../module/request/activity/acty_request.dart';
import 'textfield_controller/textcontroller.dart';
import 'widget/loading_modal_widget.dart';
import 'widget/notifikasi_popup.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  ValueNotifier<bool> isHide = ValueNotifier(true);

  void updateEye() {
    setState(() {
      isHide.value = !isHide.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    onLoginClick() async {
      ActivityRequest.loginRequest(
        userName: username_login.text,
        passWord: password_login.text,
        imeI: "",
        noPhone: "",
        packageId: Constans.PACKAGE_ID_LOGIN,
      );

      LoadingScreen.show("Loading, please wait");
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          LoadingScreen.hide();
        },
      );
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ConstantStyle.backgroundhitam,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantStyle.backgroundhitam,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.5,
              margin: EdgeInsets.only(bottom: size.height * 0.04),
              padding: EdgeInsets.only(
                  top: size.height * 0.02, left: size.width * 0.05),
              child: Text(
                "Let's get started",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: size.width * 0.1),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.03),
              width: size.width * 1,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                // border: Border.all(width: 0.3, color: Colors.white),
                color: const Color.fromARGB(255, 22, 22, 26),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.014,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                child: TextField(
                  controller: username_login,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.width * 0.05),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "username",
                    hintStyle: TextStyle(
                      color: foregroundwidget2,
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: foregroundwidget2,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.03),
              width: size.width * 1,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                // border: Border.all(width: 0.3, color: Colors.white),
                color: const Color.fromARGB(255, 22, 22, 26),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.014,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                child: TextField(
                  controller: password_login,
                  obscureText: isHide.value,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.width * 0.05),
                  decoration: InputDecoration(
                    suffix: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        updateEye();
                      },
                      icon: Icon(!isHide.value
                          ? Icons.remove_red_eye
                          : Icons.visibility_off),
                      color: foregroundwidget,
                    ),
                    border: InputBorder.none,
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: foregroundwidget2,
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                      color: foregroundwidget2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.06, bottom: size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isHide = isHide;
                        });
                      },
                      child: Text(
                        "Forget password?",
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * 0.04),
                      ))
                ],
              ),
            ),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  if (username_login.text == "" || password_login.text == "") {
                    NotifikasiPopup.show("Username And Password cant null");
                  } else {
                    onLoginClick();
                  }
                },
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: foregroundwidget2),
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "or continue with",
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {},
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    // border: Border.all(width: 0.3, color: Colors.white),
                    color: const Color.fromARGB(255, 22, 22, 26),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      "Facebook",
                      style: TextStyle(
                          fontSize: size.width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
