// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/GetxController/favoritecontrollerlocal.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/model/temp_stockgrouplist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/tabbar_view/TabBarView1/part/Card/cardvertical.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/special_notations.dart';

class TabBarFavorit extends StatefulWidget {
  const TabBarFavorit({super.key});

  @override
  State<TabBarFavorit> createState() => _TabBarFavoritState();
}

class _TabBarFavoritState extends State<TabBarFavorit> {
  final createController = Get.put(FavoriteControllerLocal());

  RxList<TempStockGroupListModel> options = <TempStockGroupListModel>[].obs;
  RxList<TempStockGroupListModel> optionGroup = <TempStockGroupListModel>[].obs;

  int selectedOptionIndex = 0;
  @override
  void initState() {
    super.initState();
    createController;
    setState(() {});
  }

  void showDropdown() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          backgroundColor: bgabu,
          title: Text(
            "Select favorit",
            style: TextStyle(
              color: Colors.white,
              fontSize: FontSizes.size14,
            ),
          ),
          content: SizedBox(
            height: 0.18.sh,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:
                    createController.body.getAll().asMap().entries.map((entry) {
                  int index = entry.key;

                  return SizedBox(
                      height: 0.05.sh,
                      child: GestureDetector(
                        child: Text(
                          " - ${createController.body.getAll()[index].groupTag}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: FontSizes.size14,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedOptionIndex = index;
                          });
                          Navigator.pop(context);
                        },
                      ));
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  void dropdownNewGroup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: bgabu,
            title: Text(
              "Add new group",
              style: TextStyle(color: Colors.white, fontSize: FontSizes.size14),
            ),
            content: TextField(
              autofocus: true,
              controller: groupname_controller,
              style: TextStyle(color: Colors.white, fontSize: FontSizes.size14),
              decoration: InputDecoration(
                hintStyle:
                    TextStyle(color: Colors.grey, fontSize: FontSizes.size14),
                hintText: "Input group name",
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              SizedBox(
                width: 90.w,
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white, fontSize: FontSizes.size12),
                  ),
                ),
              ),
              SizedBox(
                width: 90.w,
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (groupname_controller.text.length < 2) {
                      NotifikasiPopup.showWarning(
                          "Group name length must more than 3 character");
                    } else {
                      createController.onAddBody(
                          groupname_controller.text, false);

                      groupname_controller.clear();
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white, fontSize: FontSizes.size12),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return createController.body.getAll().isEmpty
        ? Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 10.w, bottom: 5.h),
                  child: Text(
                    "List favorits",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Group is Empty",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton(
              mini: true,
              shape: const CircleBorder(),
              onPressed: () {
                dropdownNewGroup();
              },
              child: Icon(
                Icons.add,
                size: 22.sp,
              ),
            ),
          )
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 8.h,
                  bottom: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                        showDropdown();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        width: 0.45.sw,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: foregroundwidget,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${createController.body.getAll()[selectedOptionIndex].groupTag}",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size13,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                              child: FittedBox(
                                child: Icon(
                                  size: 8.sp,
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r)),
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          dropdownNewGroup();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 17.sp,
                            ),
                            Text(
                              ' Add',
                              style: TextStyle(
                                fontSize: FontSizes.size11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r)),
                            backgroundColor: Colors.red),
                        onPressed: () {
                          NotifikasiPopup.showCANCEL(
                            onSubmit: () {
                              createController.removeBody(
                                createController.body
                                    .getAll()[selectedOptionIndex],
                              );

                              setState(() {
                                if (selectedOptionIndex == 0) {
                                  return;
                                } else {
                                  selectedOptionIndex = selectedOptionIndex - 1;
                                }
                              });
                              Navigator.pop(context);
                            },
                            text:
                                "Delete Group ${createController.body.getAll()[selectedOptionIndex].groupTag}",
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 17.sp,
                            ),
                            Text(
                              ' Delete',
                              style: TextStyle(
                                fontSize: FontSizes.size11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: 5.h,
                  left: 10.w,
                  bottom: 5.h,
                ),
                child: Text(
                  "List favorits",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: Detail(selectedOptionIndex: selectedOptionIndex),
              ),
            ],
          );
  }
}

// ignore: must_be_immutable
class Detail extends StatelessWidget {
  Detail({super.key, this.selectedOptionIndex});
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(FavoriteControllerLocal());
    createController
        .getAll(createController.body.getAll()[selectedOptionIndex!]);
    final openBox = ObjectBoxDatabase.quotesBox;
    if (createController.body.getAll()[selectedOptionIndex!].member.isEmpty) {
      null;
    } else {
      ActivityRequest.quoteRequest(
          packageId: Constans.PACKAGE_ID_QUOTES,
          arrayStockCode: createController
              .getAll(createController.body.getAll()[selectedOptionIndex!])
              .map((e) => ArrayStockCode(board: 'RG', stockCode: e.stockCode))
              .toList());
    }
    return createController.obx(
      (s) {
        if (s!.isEmpty) {
          return Container();
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: s.length,
          itemBuilder: (context, index) {
            var arrayData = createController
                .getAll(createController.body.getAll()[selectedOptionIndex!]);
            List<Quotes> getDataQuote = [];
            for (int i = 0; i < arrayData.length; i++) {
              var query = openBox
                  .query(Quotes_.stockCode
                      .equals(arrayData[i].stockCode.toString()))
                  .build()
                  .findFirst();
              getDataQuote.add(query!);
            }
            List<PackageStockList> dataStockCode = [];
            for (int i = 0; i < s.length; i++) {
              var query = ObjectBoxDatabase.stockList
                  .query(
                    PackageStockList_.stcokCode.equals(
                      s[i].stockCode.toString(),
                    ),
                  )
                  .build()
                  .findFirst();
              if (query == null) {
                dataStockCode = [];
              } else {
                dataStockCode.add(query);
              }
            }
            StringBuffer getSpecialNotiver() {
              String getSN = dataStockCode[index].remake2.toString();
              String specialNotiver = getSN.substring(19, 30);
              List<String> fragments = specialNotiver.split('-');
              final buffer = StringBuffer();

              for (String fragment in fragments) {
                if (fragment != "-") {
                  buffer.write(fragment);
                }
              }
              return buffer;
            }

            if (arrayData.isEmpty) {
              return Container();
            } else {
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.white, fontSize: FontSizes.size12),
                      )
                    ],
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  bool dismiss = false;
                  NotifikasiPopup.showCANCEL(
                    onSubmit: () {
                      var getBody = createController.body
                          .query(FavoriteLoacalB_.groupTag.equals(
                              createController.body
                                  .getAll()[selectedOptionIndex!]
                                  .groupTag
                                  .toString()))
                          .build()
                          .findFirst();
                      createController.onAddMember(
                        getBody,
                        s[index].stockCode.toString(),
                        true,
                      );

                      Navigator.pop(context);
                      dismiss = true;
                    },
                    isCancel: () {
                      dismiss = false;
                      Navigator.of(context).pop();
                    },
                    customText: "Yes",
                    text:
                        "Are you sure want to delete ${getDataQuote[index].stockCode} from ${createController.body.getAll()[index].groupTag}",
                  );
                  return dismiss;
                },
                movementDuration: const Duration(milliseconds: 400),
                key: Key("${getDataQuote[index].stockCode}"),
                child: CardVertical(
                  stockCode: getDataQuote[index].stockCode,
                  stockName: dataStockCode[index].stockName,
                  spesialnotasi: getSpecialNotiver().isEmpty
                      ? ''
                      : getSpecialNotiver().toString(),
                  detailspesialnotasi: getSpecialNotiver().isEmpty
                      ? ""
                      : specialNotations(
                          getSpecialNotiver(),
                        ).toString(),
                  last: getDataQuote[index].lastPrice,
                  freq: getDataQuote[index].freq,
                  change: getDataQuote[index].change,
                  prev: getDataQuote[index].prevPrice,
                  changerate: getDataQuote[index].chgRate,
                  vol: getDataQuote[index].volume,
                  high: getDataQuote[index].hiPrice,
                  low: getDataQuote[index].loPrice,
                ),
              );
            }
          },
        );
      },
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onEmpty: Center(
          child: Text(
        'No favorit available',
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
      )),
      onError: (error) => Text(
        "ERROR: $error",
        style: TextStyle(color: Colors.white, fontSize: 15.sp),
      ),
    );
  }
}
