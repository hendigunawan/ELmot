import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/textinput/textfield.dart';

class LeadingDesktop extends StatefulWidget {
  const LeadingDesktop({super.key});

  @override
  State<LeadingDesktop> createState() => _LeadingDesktopState();
}

class _LeadingDesktopState extends State<LeadingDesktop> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  final password_login = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    onLoginClick() async {
      Get.put(LoginContrller())
          .addLoginData(username_login.text, password_login.text);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(23),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.1,
                child: Row(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height / 1.2,
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            // Icon(
                            //   Icons.workspaces_rounded,
                            //   size: 60,
                            //   color: Colors.white,
                            // ),
                            // Text(
                            //   "MOT",
                            //   style:
                            //       TextStyle(color: Colors.white, fontSize: 26),
                            // ),
                            Image.asset(
                              "assets/images/logofast.png",
                              width: 30.w,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Log In",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 0.11.sh,
                              child: CustomTextInput(
                                textColor: Colors.white,
                                hintTextString: "Username / Email",
                                textEditController: username_login,
                                inputType: InputType.Default,
                              ),
                            ),
                            SizedBox(
                              height: 0.11.sh,
                              child: CustomTextInput(
                                textColor: Colors.white,
                                hintTextString: "Password",
                                textEditController: password_login,
                                inputType: InputType.Password,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  print("lupa password");
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: FontSizes.size4),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                color: Colors.white,
                                minWidth: 150.w,
                                height: 45.h,
                                // minWidth: double.maxFinite,
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizes.size6),
                                ),
                                onPressed: () => onLoginClick()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.2, 0.8],
                        colors: [
                          Colors.blue,
                          Colors.white,
                        ],
                      )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, right: 12, bottom: 30, left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                "assets/images/fast.png",
                                width: 25.w,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/fast0NLINE.png",
                                width: 80.w,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                "assets/images/logofast.png",
                                width: 15.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),

              // scr old
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 6,
              //       child: Container(
              //         color: const Color.fromARGB(255, 19, 19, 19),
              //         child: Center(
              //           child: Carrousel(
              //             borderRadius: 20,
              //             width: size.width / 4.5,
              //             height: size.height / 1.5,
              //             listItem: [
              //               CarrouselModel(
              //                 title: 'A',
              //                 description: 'AA',
              //                 color: const Color.fromARGB(255, 0, 89, 255),
              //               ),
              //               CarrouselModel(
              //                 title: 'B',
              //                 description: 'BB',
              //                 color: const Color.fromARGB(255, 255, 0, 0),
              //               ),
              //               CarrouselModel(
              //                 title: 'C',
              //                 description: 'CC',
              //                 color: const Color.fromARGB(255, 238, 255, 0),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 2,
              //       child: Container(
              //         padding: EdgeInsets.only(
              //           top: size.height / 8.5,
              //           left: size.width / 45,
              //           right: size.width / 60,
              //         ),
              //         height: size.height,
              //         color: const Color(0xFFF434343),
              //         child: Container(
              //           child: Center(
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Sign in with\nPassword',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: size.aspectRatio * 20,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: size.height / 20,
              //                 ),
              //                 CustomTextInput(
              //                   hintTextString: 'Username or Email',
              //                   textEditController: username_login,
              //                   inputType: InputType.Default,
              //                   themeColor:
              //                       const Color.fromARGB(255, 129, 129, 129),
              //                 ),
              //                 CustomTextInput(
              //                   hintTextString: 'Password',
              //                   textEditController: password_login,
              //                   inputType: InputType.Password,
              //                   prefixIcon: const Icon(
              //                     Icons.lock,
              //                     color: Color.fromARGB(255, 129, 129, 129),
              //                   ),
              //                   themeColor:
              //                       const Color.fromARGB(255, 129, 129, 129),
              //                 ),
              //                 SizedBox(
              //                   height: size.height / 30,
              //                 ),
              //                 GestureDetector(
              //                   onTap: () {
              //                     setState(() {
              //                       isChecked = !isChecked;
              //                     });
              //                   },
              //                   child: Row(
              //                     children: [
              //                       Container(
              //                         margin: EdgeInsets.only(
              //                           right: size.width * 0.005,
              //                         ),
              //                         width: 24.0,
              //                         height: 24.0,
              //                         decoration: BoxDecoration(
              //                           shape: BoxShape.rectangle,
              //                           borderRadius: BorderRadius.circular(5),
              //                           border: Border.all(color: Colors.grey),
              //                           color: isChecked
              //                               ? Colors.green
              //                               : Colors.transparent,
              //                         ),
              //                         child: Icon(
              //                           Icons.check,
              //                           size: 16.0,
              //                           color: isChecked
              //                               ? Colors.white
              //                               : Colors.transparent,
              //                         ),
              //                       ),
              //                       const Text('Remember me'),
              //                       const Spacer(),
              //                       TextButton(
              //                         onPressed: () {},
              //                         child: const Text('Resset Pasword?'),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: size.height * 0.03,
              //                 ),
              //                 Button(
              //                   'SIGN IN',
              //                   onPressed: () {
              //                     onLoginClick();
              //                   },
              //                   type: ButtonType.defaults,
              //                   borderRadius: BorderRadius.circular(5),
              //                   height: size.height / 20,
              //                   width: size.width / 6,
              //                 ),
              //                 SizedBox(
              //                   height: size.height * 0.03,
              //                 ),
              //                 const Center(
              //                   child: Text(
              //                     'Or Continue With',
              //                     style: TextStyle(
              //                         color: Color.fromARGB(255, 129, 129, 129)),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: size.height * 0.03,
              //                 ),
              //                 Center(
              //                   child: Row(
              //                     children: [
              //                       Button(
              //                         '',
              //                         onPressed: () {},
              //                         type: ButtonType.withIcon,
              //                         borderRadius: BorderRadius.circular(10),
              //                         icon: const Icon(
              //                           Icons.facebook,
              //                           size: 50,
              //                           color: Color(0xFFF1FA4F9),
              //                         ),
              //                         height: size.height * 0.08,
              //                         width: size.width * 0.04,
              //                       ),
              //                       SizedBox(
              //                         width: size.width * 0.01,
              //                       ),
              //                       Button(
              //                         '',
              //                         onPressed: () {},
              //                         type: ButtonType.withIcon,
              //                         borderRadius: BorderRadius.circular(10),
              //                         icon: const Icon(
              //                           Icons.apple,
              //                           size: 50,
              //                           color: Colors.white,
              //                         ),
              //                         height: size.height * 0.08,
              //                         width: size.width * 0.04,
              //                       ),
              //                       SizedBox(
              //                         width: size.width * 0.01,
              //                       ),
              //                       Button(
              //                         '',
              //                         onPressed: () {},
              //                         type: ButtonType.withIcon,
              //                         borderRadius: BorderRadius.circular(10),
              //                         icon: const Icon(
              //                           Icons.apple,
              //                           size: 50,
              //                           color: Colors.white,
              //                         ),
              //                         height: size.height * 0.08,
              //                         width: size.width * 0.04,
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
