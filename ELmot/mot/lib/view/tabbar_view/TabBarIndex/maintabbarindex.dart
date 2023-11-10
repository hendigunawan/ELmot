import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/GetxController/IndexListTopController.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/model/index_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/part/detail_index.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/widget/card_widget.dart';

class MainTabbarIndex extends StatefulWidget {
  const MainTabbarIndex({super.key});

  @override
  State<MainTabbarIndex> createState() => _MainTabbarIndexState();
}

class _MainTabbarIndexState extends State<MainTabbarIndex> {
  IndexListTopController getData = Get.put(IndexListTopController());
  @override
  void initState() {
    super.initState();
    getData;
  }

  @override
  Widget build(BuildContext context) {
    getData.getAll();
    final openBox = ObjectBoxDatabase.indexaja;
    return getData.obx(
      (s) {
        List<IndexModelS> datas = [];
        for (int i = 0; i < s!.first.array.length; i++) {
          var query = openBox
              .query(IndexModelS_.indexCode.equals(s.first.array[i].IndexCode!))
              .build()
              .findFirst();
          if (query != null) {
            datas.add(query);
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 10.w),
              child: Text(
                "Index Lists",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (datas[index].indexCode != "COMPOSITE") {
                          ActivityRequest.indexMemberListRequest(
                              packageId:
                                  Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST,
                              indexName: datas[index].indexCode.toString());
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailIndexTop(
                                  indexCode: datas[index].indexCode.toString());
                            },
                          ));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 2.h,
                          left: 5.w,
                          right: 5.w,
                        ),
                        child: SizedBox(
                          width: 1.sw,
                          height: 135.h,
                          child: CardWidgetIndex(
                            unchangeI: datas[index].unChange,
                            indexName: datas[index].indexCode.toString(),
                            change: datas[index].change,
                            changeR: datas[index].changeR,
                            freq: datas[index].freq,
                            highI: datas[index].highI,
                            lowI: datas[index].lowI,
                            openI: datas[index].prevI,
                            prevI: datas[index].prevI,
                            valueI: datas[index].value,
                            volumeI: datas[index].volume,
                            upI: datas[index].up,
                            downI: datas[index].down,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onEmpty: const Center(
          child: Text(
        'No data available',
        style: TextStyle(color: Colors.white),
      )),
      onError: (error) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.9),
          height: 1.sh,
          width: 1.sw,
          child: Container(
            padding: EdgeInsets.all(20.w),
            height: 0.425.sh,
            width: 0.7.sw,
            color: foregroundwidget,
            alignment: Alignment.center,
            child: Text(
              'ERROR CONNECT \n PLEASE TURN ON INTERNET OR CHECK VPN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// class MainTabbarIndex extends StatefulWidget {
//   const MainTabbarIndex({super.key});

//   @override
//   State<MainTabbarIndex> createState() => _MainTabbarIndexState();
// }

// class _MainTabbarIndexState extends State<MainTabbarIndex> {
//   // final List<ListItem> _items = [
//   //   ListItem(title: 'LQ45'),
//   //   ListItem(title: 'TOP100'),
//   //   ListItem(title: 'TOP50'),
//   //   ListItem(title: 'LQ100'),
//   //   ListItem(title: 'U17'),
//   // ];
//   // void _onItemTap(int index, String data) async {
//   //   final SharedPreferences setIndex = await SharedPreferences.getInstance();
//   //   if (index == setIndex.getInt("active_index")) {
//   //     Navigator.pushNamed(context, '/SeeAllIndexView',
//   //         arguments: <String, String>{
//   //           'indexCode': data,
//   //         });
//   //   } else {
//   //     showDialog(
//   //         context: context,
//   //         builder: (BuildContext context) {
//   //           return AlertDialog(
//   //             backgroundColor: ConstantStyle.foreground,
//   //             title: const Text(
//   //               "Attention!",
//   //               style: TextStyle(color: Colors.white),
//   //             ),
//   //             content: Text("Set $data as Index ",
//   //                 style: const TextStyle(color: Colors.white)),
//   //             actions: <Widget>[
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   Navigator.pop(context);
//   //                   Navigator.pushNamed(context, '/SeeAllIndexView',
//   //                       arguments: <String, String>{
//   //                         'indexCode': data,
//   //                       });
//   //                 },
//   //                 child: const Icon(
//   //                   Icons.remove_red_eye,
//   //                   color: Colors.white,
//   //                 ),
//   //               ),
//   //               ElevatedButton(
//   //                   style:
//   //                       ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//   //                   onPressed: () {
//   //                     setState(() {
//   //                       for (int i = 0; i < _items.length; i++) {
//   //                         _items[i].isSelected = false;
//   //                       }
//   //                       // setIndex.remove("indexSelected");
//   //                       setIndex.setInt("active_index", index);
//   //                       _items[index].isSelected = true;
//   //                       Navigator.pop(context);
//   //                     });
//   //                   },
//   //                   child: const Text("Ok")),
//   //               ElevatedButton(
//   //                   style:
//   //                       ElevatedButton.styleFrom(backgroundColor: Colors.red),
//   //                   onPressed: () {
//   //                     Navigator.of(context).pop();
//   //                   },
//   //                   child: const Text("Cancel")),
//   //             ],
//   //           );
//   //         });
//   //   }
//   // }

//   // void _loadActiveIndex() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   int? activeIndex = prefs.getInt('active_index');
//   //   if (activeIndex != null) {
//   //     setState(() {
//   //       _items[activeIndex].isSelected = true;
//   //     });
//   //   }
//   // }

//   // final indextopController = Get.put(
//   //   IndexListTopController(),
//   // );
//   @override
//   void initState() {
//     super.initState();
//     // indextopController;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     IndexListTopController getData = Get.put(IndexListTopController());
//     getData.getAll();
//     final openBox = ObjectBoxDatabase.indexaja;
//     return getData.obx(
//       (s) {
//         List<IndexModelS> datas = [];
//         for (int i = 0; i < s!.first.array.length; i++) {
//           var query = openBox
//               .query(IndexModelS_.indexCode.equals(s.first.array[i].IndexCode!))
//               .build()
//               .findFirst();
//           if (query != null) {
//             datas.add(query);
//           }
//         }
//         return Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: size.height * 0.005,
//                     left: size.width * 0.045,
//                     right: size.width * 0.04,
//                     bottom: size.height * 0.005),
//                 child: Text(
//                   "Index Lists",
//                   style: TextStyle(
//                       color: Colors.white, fontSize: size.width * 0.04),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: datas.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                           onTap: () {
//                             if (datas[index].indexCode != "COMPOSITE") {
//                               ActivityRequest.indexMemberListRequest(
//                                   packageId:
//                                       Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST,
//                                   indexName: datas[index].indexCode.toString());

//                               Navigator.pushNamed(context, '/DetailIndexTop',
//                                   arguments: <String, String>{
//                                     'indexCode':
//                                         datas[index].indexCode.toString(),
//                                   });
//                             }
//                           },
//                           child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: size.height * 0.005,
//                                   left: size.width * 0.03,
//                                   right: size.width * 0.03),
//                               child: SizedBox(
//                                   width: size.width * 1,
//                                   height: size.height * 0.138,
//                                   child: CardWidgetIndex(
//                                     indexName:
//                                         datas[index].indexCode.toString(),
//                                     change: datas[index].change,
//                                     changeR: datas[index].changeR,
//                                     freq: datas[index].freq,
//                                     highI: datas[index].highI!.toDouble(),
//                                     lowI: datas[index].lowI!.toDouble(),
//                                     openI: datas[index].prevI!.toDouble(),
//                                     prevI: datas[index].prevI!.toDouble(),
//                                     valueI: datas[index].value!.toDouble(),
//                                     volumeI: datas[index].volume!.toDouble(),
//                                     upI: datas[index].up,
//                                     downI: datas[index].down,
//                                     size: 1,
//                                   ))));
//                     }),
//               )
//             ]);
//       },
//       onLoading: const Center(
//         child: CircularProgressIndicator(),
//       ),
//       onEmpty: const Center(
//           child: Text(
//         'No favorit available',
//         style: TextStyle(color: Colors.white),
//       )),
//       onError: (error) => Text(error!),
//     );

//   }
// }