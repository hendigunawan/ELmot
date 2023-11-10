import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class ChangePasswordWidget extends StatelessWidget {
  final int type;
  const ChangePasswordWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    RxBool isShowPrev = false.obs;
    RxBool isShowNew = false.obs;
    RxBool isShowConfirmation = false.obs;
    // RxBool isDisable = true.obs;
    var controller = Get.put(ChangePinPasswordController());
    controller.setDefaultTextediting();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (controller.isDone.value == false) {
              NotifikasiPopup.showCANCEL(
                isCancel: () {
                  controller.isLoading.toggle();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                onSubmit: () {
                  Navigator.pop(context);
                },
                text: "Save change?",
                customText: 'Continue edit',
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Change ${type == 0 ? 'Password' : 'Pin'}",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(() {
            return Container(
                margin: EdgeInsets.only(right: 6.w),
                alignment: Alignment.center,
                child: controller.isLoading.value == false
                    ? TextButton(
                        child: Row(
                          children: [
                            Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            controller.isDone.value == true
                                ? Icon(
                                    Icons.check,
                                    size: 15.sp,
                                    color: Colors.blue,
                                  )
                                : Container()
                          ],
                        ),
                        onPressed: () {
                          if (oldPassController.text == '' ||
                              newPassController.text == '') {
                            NotifikasiPopup.showFAILED(
                              oldPassController.text == '' &&
                                      newPassController.text != ''
                                  ? 'Old ${type == 0 ? 'Password' : 'Pin'} can be empty'
                                  : oldPassController.text != '' &&
                                          newPassController.text == ''
                                      ? 'New ${type == 0 ? 'Password' : 'Pin'} can be empty'
                                      : 'Old and new ${type == 0 ? 'Password' : 'Pin'} can be empty',
                            );
                          } else if (controller.isDone.value == true) {
                            NotifikasiPopup.showINFO(
                                text:
                                    "Can't change the ${type == 0 ? 'Password' : 'Pin'} because you just changed it");
                          } else if (newPassController.text !=
                              confirmationPassController.text) {
                            NotifikasiPopup.showFAILED(
                              'New ${type == 0 ? 'Password' : 'Pin'} and Confirmation ${type == 0 ? 'Password' : 'Pin'} not matched',
                            );
                          } else {
                            if (type == 0) {
                              if (newPassController.text.length > 5) {
                                controller.isLoading.toggle();
                                controller.sendChangePassword(
                                    oldpass: oldPassController.text,
                                    newPass: newPassController.text,
                                    type: 0);
                              } else {
                                NotifikasiPopup.showFAILED(
                                    'New ${type == 0 ? 'Password' : 'Pin'} must be more than 5');
                              }
                            } else {
                              if (newPassController.text.length == 6) {
                                controller.isLoading.toggle();
                                controller.sendChangePassword(
                                    oldpass: oldPassController.text,
                                    newPass: newPassController.text,
                                    type: 1);
                              } else {
                                NotifikasiPopup.showFAILED(
                                    'New Pin must be 6 character');
                              }
                            }
                          }
                        },
                      )
                    : const CircularProgressIndicator());
          })
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type == 0
                  ? "Your password must be more than 6 characters and a maximum of 15 characters containing a combination of numbers, letters and characters"
                  : "Your Pins must be 6 characters long and can only contain numbers",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            SizedBox(
              height: 15.h,
              width: 1.sw,
              child: const Divider(
                color: Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            Text(
              "Enter old ${type == 0 ? 'password' : 'pin'} : ",
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.only(left: 8.w, right: 5.w),
              width: 0.45.sw,
              height: 25.h,
              decoration: BoxDecoration(
                  color: putihop85, borderRadius: BorderRadius.circular(5.r)),
              child: Obx(() {
                return TextField(
                  keyboardType:
                      type == 1 ? TextInputType.number : TextInputType.name,
                  inputFormatters: type == 1
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                      : [],
                  // enabled: isDisable.value,
                  controller: oldPassController,
                  obscureText: isShowPrev.value ? false : true,
                  maxLength: type == 0 ? 15 : 6,
                  style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          BoxConstraints.tightFor(width: 20.w),
                      counterText: '',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          isShowPrev.toggle();
                        },
                        child: Icon(
                          isShowPrev.value
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: isShowPrev.value ? Colors.blue : Colors.black,
                          size: 18.sp,
                        ),
                      )),
                );
              }),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Enter new ${type == 0 ? 'password' : 'pin'} : ",
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.only(left: 8.w, right: 5.w),
              width: 0.45.sw,
              height: 25.h,
              decoration: BoxDecoration(
                  color: putihop85, borderRadius: BorderRadius.circular(5.r)),
              child: Obx(() {
                return TextField(
                  // enabled: isDisable.value,
                  inputFormatters: type == 1
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                      : [],
                  controller: newPassController,
                  obscureText: isShowNew.value ? false : true,
                  maxLength: type == 0 ? 15 : 6,
                  style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          BoxConstraints.tightFor(width: 20.w),
                      counterText: '',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          isShowNew.toggle();
                        },
                        child: Icon(
                          isShowNew.value
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: isShowNew.value ? Colors.blue : Colors.black,
                          size: 18.sp,
                        ),
                      )),
                );
              }),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Confirmation new ${type == 0 ? 'password' : 'pin'} : ",
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color.fromARGB(255, 187, 187, 187),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.only(left: 8.w, right: 5.w),
              width: 0.45.sw,
              height: 25.h,
              decoration: BoxDecoration(
                  color: putihop85, borderRadius: BorderRadius.circular(5.r)),
              child: Obx(() {
                return TextField(
                  // enabled: isDisable.value,
                  inputFormatters: type == 1
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                      : [],
                  controller: confirmationPassController,
                  obscureText: isShowConfirmation.value ? false : true,
                  maxLength: type == 0 ? 15 : 6,
                  style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          BoxConstraints.tightFor(width: 20.w),
                      counterText: '',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          isShowConfirmation.toggle();
                        },
                        child: Icon(
                          isShowConfirmation.value
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: isShowConfirmation.value
                              ? Colors.blue
                              : Colors.black,
                          size: 18.sp,
                        ),
                      )),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ChangePinPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDone = false.obs;
  RxString updatePass = ''.obs;
  void sendChangePassword(
      {required String oldpass, required String newPass, required int type}) {
    updatePass.value = newPass;
    updatePass.refresh();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.toggle();
      OrderMassage.reqChangePassPin(
          oldPasin: oldpass, newPasin: newPass, type: type);
    });
  }

  void setDefaultTextediting() {
    isLoading.value = false;
    isDone.value = false;
    Future.delayed(const Duration(milliseconds: 51), () {
      oldPassController.clear();
      newPassController.clear();
      confirmationPassController.clear();
    });
  }
}
