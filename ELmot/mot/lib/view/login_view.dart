// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/login_order.model.dart';
import 'package:online_trading/module/ordering/pkg/info/login_order.pkg.dart';
import 'package:online_trading/view/bottomnavbar/bottomnavbarwidget.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:flutter/material.dart';
import 'package:online_trading/view/widget/button.dart';
import 'package:online_trading/view/widget/judul_widget/judul.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/textinput/textfield.dart';

import 'widget/loading_modal_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LocalAuthentication auth;
  bool supportState = false;
  RxBool checkboxA = false.obs;
  RxBool checkboxB = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool value) {
      setState(() {
        supportState = value;
      });
    });
  }

  void handleCheckA() {
    if (checkboxB.value == true) {
      checkboxB.toggle();
    }
    if (checkboxA.value != true) {
      checkboxA.toggle();
    }
  }

  void handleCheckB() {
    if (checkboxA.value == true) {
      checkboxA.toggle();
    }
    if (checkboxB.value != true) {
      checkboxB.toggle();
    }
  }

  String msg = "You are not authorized.";

  @override
  Widget build(BuildContext context) {
    LoginControl controllerLogin = Get.put(LoginControl());
    controllerLogin;
    return WillPopScope(
      onWillPop: () async {
        return controllerLogin.isLoading.value == false ? true : false;
      },
      child: Scaffold(
        backgroundColor: ConstantStyle.backgroundhitam,
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: ConstantStyle.backgroundhitam,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const JudulTitle(
                title: "Hey Wellcome Back",
                colorText: Colors.white,
              ),
              CustomTextInput(
                textColor: Colors.white,
                hintTextString: "Username / Email",
                textEditController: username_login,
                inputType: InputType.Default,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextInput(
                textColor: Colors.white,
                hintTextString: "Password",
                textEditController: password_login,
                inputType: InputType.Password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 7.w, right: 7.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            "Config Setting",
                            style: TextStyle(
                              color: putihop85,
                              fontSize: 13.sp,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  titlePadding: EdgeInsets.only(
                                      left: 15.w, right: 15.w, top: 10.h),
                                  title: Text(
                                    "Config Setting",
                                    style: TextStyle(
                                        color: putihop85, fontSize: 16.sp),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: bgabu,
                                  actionsPadding: EdgeInsets.only(bottom: 10.h),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 30.h,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                backgroundColor: Colors.blue),
                                            onPressed: () {
                                              if (checkboxA.value == true) {
                                                Navigator.pop(context);
                                              } else {
                                                if (urlController.text == '' ||
                                                    portController.text == '') {
                                                  NotifikasiPopup.showWarning(
                                                      'Please input Url / Port');
                                                } else {
                                                  urlController.clear();
                                                  portController.clear();

                                                  Navigator.pop(context);
                                                }
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r)),
                                  content: Container(
                                    padding: EdgeInsets.all(15.w),
                                    height: 230.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return CheckboxListTile(
                                            visualDensity:
                                                VisualDensity.compact,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              "Primary Config",
                                              style: TextStyle(
                                                  color: putihop85,
                                                  fontSize: 12.sp),
                                            ),
                                            value: checkboxA.value,
                                            onChanged: (value) {
                                              handleCheckA();
                                            },
                                          );
                                        }),
                                        Obx(() {
                                          return CheckboxListTile(
                                            visualDensity:
                                                VisualDensity.compact,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              "Custom Config",
                                              style: TextStyle(
                                                  color: putihop85,
                                                  fontSize: 12.sp),
                                            ),
                                            value: checkboxB.value,
                                            onChanged: (value) {
                                              handleCheckB();
                                            },
                                          );
                                        }),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Url / IP",
                                                  style: TextStyle(
                                                      color: putihop85,
                                                      fontSize: 14.sp),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, right: 4.w),
                                                  decoration: BoxDecoration(
                                                    color: putihop85,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5.r,
                                                    ),
                                                  ),
                                                  width: 0.55.sw,
                                                  height: 30.h,
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    onTap: () {
                                                      handleCheckB();
                                                    },
                                                    controller: urlController,
                                                    maxLength: 25,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                        color: Colors.black26,
                                                        fontSize: 12.sp,
                                                      ),
                                                      hintText:
                                                          "ex: www.google.com",
                                                      counterText: '',
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Port",
                                                  style: TextStyle(
                                                    color: putihop85,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    right: 4.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: putihop85,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5.r,
                                                    ),
                                                  ),
                                                  width: 0.55.sw,
                                                  height: 30.h,
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    onTap: () {
                                                      handleCheckB();
                                                    },
                                                    controller: portController,
                                                    maxLength: 5,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                          r'[0-9]',
                                                        ),
                                                      )
                                                    ],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                        color: Colors.black26,
                                                        fontSize: 12.sp,
                                                      ),
                                                      hintText: "ex: 44444",
                                                      counterText: '',
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        TextButton(
                          child: Text(
                            "Forget pasword?",
                            style: TextStyle(
                              color: putihop85,
                              fontSize: 13.sp,
                            ),
                          ),
                          onPressed: () {
                            NotifikasiPopup.showINFO(
                              text: 'Coming soon',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Forget pasword?",
                      style: TextStyle(
                        color: putihop85,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Button("Submit", onPressed: () {
                  if (username_login.text == '' && password_login.text == '') {
                    NotifikasiPopup.showWarning(
                        'Username and password cant be empty');
                  } else if (username_login.text == '' &&
                      password_login.text != '') {
                    NotifikasiPopup.showWarning('Username cant be empty');
                  } else if (username_login.text != '' &&
                      password_login.text == '') {
                    NotifikasiPopup.showWarning('Password cant be empty');
                  } else {
                    controllerLogin.requestLogin(
                        password: password_login.text,
                        username: username_login.text);
                  }
                },
                    type: ButtonType.secondary,
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Center(
                      child: Text(msg),
                    ),
                    const Divider(),
                    if (supportState)
                      Text(
                        'Support',
                        style: TextStyle(fontSize: FontSizes.size13),
                      )
                    else
                      const Text('Not'),
                    ElevatedButton(
                      onPressed: _getAvilable,
                      child: const Text('Bio'),
                    ),
                    ElevatedButton(
                      onPressed: _dahLah,
                      child: const Text('Bio'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dahLah() async {
    try {
      bool auntec = await auth.authenticate(
        localizedReason: "Pleas Insert FingerPrint/FaceId",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      print(auntec);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAvilable() async {
    List<BiometricType> avilable = await auth.getAvailableBiometrics();

    print('List: $avilable');

    if (!mounted) {
      return;
    }
  }
}

class LoginContrller extends GetxService {
  final loginModel = LoginDataModel().obs;
  final SecureStorage store = SecureStorage();
  RxBool isFirst = false.obs;

  void addLoginData(String userName, String userPass) {
    loginModel.update((val) {
      val!.userName = userName;
      val.userPass = userPass;
    });
  }

  @override
  void onInit() async {
    super.onInit();
    if (await store.getUserName() != '' || await store.getUserName() != null) {
      username_login.text = (await store.getUserName() ?? '');
    }
    ever(loginModel, (callback) => requestLoginToServer(callback));
    ever(Get.put(LoginOrderController()).order!, (callback) {
      loading();
    });
  }

  void requestLoginToServer(LoginDataModel data) {
    OrderMassage.loginOrder(
      userName: data.userName.toString(),
      passWord: data.userPass.toString(),
    );
    store.setUserName(data.userName!);
    store.setPassWord(data.userPass!);
    loading(data: data);
  }

  void loading({LoginDataModel? data}) {
    LoadingScreen.show("Loading, please wait");

    if (Get.put(LoginOrderController(), permanent: true).order!.value.account !=
        null) {
      cekStatusErrorCode();
      LoadingScreen.hide();
    } else {
      LoadingScreen.hide();
    }
  }

  void cekStatusErrorCode() async {
    Get.offNamed(
      '/homeview',
    );
    isFirst.toggle();
  }
}

class LoginDataModel {
  String? userName;
  String? userPass;

  LoginDataModel({this.userName, this.userPass});
}

class LoginControl extends GetxController {
  final SecureStorage store = SecureStorage();
  RxString user = ''.obs;
  RxString pass = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isDone = false.obs;
  @override
  void onInit() async {
    super.onInit();
    ever(listlogin, (callback) => checkIfExist());
    ever(isLoading, (callback) => isLoadingFunc());
  }

  void requestLogin({required String username, required String password}) {
    user.value = username;
    pass.value = password;
    OrderMassage.loginOrder(
      userName: username,
      passWord: password,
    );
    isLoading.value = true;
  }

  void isLoadingFunc() {
    if (isLoading.value == true) {
      NotifikasiPopup.showLOADINGWITHDISABLE();
    } else {
      NotifikasiPopup.hide();
    }
  }

  void checkIfExist() async {
    if (listlogin.isNotEmpty) {
      isLoading.value = false;
      store.setUserName(user.value);
      store.setPassWord(pass.value);
      Get.offAndToNamed(
        '/homeview',
      );
      setNull();
      Get.delete();
    }
  }

  void setNull() {
    listlogin.clear();
    username_login.clear();
    password_login.clear();
    user.value = '';
    pass.value = '';
  }
}

class LogoutController extends GetxController {
  final SecureStorage store = SecureStorage();

  void logoutReq() {
    OrderMassage.logoutOrder();
  }

  void onLogoutSuccess() async {
    Get.put<bool>(false, tag: "getStatusLogin");
    await store.setPassWord('');
    await store.resetPassWord();
    username_login.text = (await store.getUserName())!;
    Get.put(LoginOrderController()).order!.value = LoginOrder();
    Get.find<LoginOrderController>().order!.refresh();
    bottomindex.value = 0;
  }
}
