import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_trading/GetxController/favoritecontrollerlocal.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';
import 'package:online_trading/view/tabbar_view/tradingView/helper/buildlistfav.dart';
import 'package:online_trading/view/tabbar_view/tradingView/helper/enum.dart';
import 'package:online_trading/view/widget/modal_bottom/main.modal.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../helper/LinkedLabelRadio.dart';

class PopupBottom {
  static show(BuildContext context) {
    final getRunning = Get.put(RunningTradeController());

    var aaaaa = Get.put(FavoriteControllerLocal()).body.getAll();
    RxList<bool> list = <bool>[].obs;
    Rx<Trading>? trading = Trading.seeAll.obs;
    if (getRunning.rombongan.isNotEmpty) {
      trading.value = Trading.fokus;
    } else {
      trading.value = Trading.seeAll;
    }
    list.value = List.generate(aaaaa.length, (index) {
      List<bool> a = [];
      for (var i = 0; i < aaaaa.length; i++) {
        if (getRunning.rombongan.isNotEmpty) {
          for (var x = 0; x < getRunning.rombongan.length; x++) {
            if (aaaaa[i].groupTag == getRunning.rombongan[x].groupTag) {
              a.add(true);
            } else {
              a.add(false);
            }
          }
        } else {
          a.add(false);
        }
      }

      return a[index];
    });
    list.refresh();
    WoltModalSheet.show<void>(
      pageIndexNotifier: BottomModal.pageIndexNotifier,
      context: context,
      pageListBuilder: (modalSheetContext) {
        final textTheme = Theme.of(context).textTheme;
        return [
          BottomModal.page1(
            modalSheetContext,
            textTheme,
            padding: 0,
            Obx(
              () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinkedLabelRadio(
                      padding: EdgeInsets.zero,
                      label: 'All',
                      value: Trading.seeAll,
                      groupValue: trading.value,
                      onChanged: (Trading? value) {
                        trading.value = value!;
                        trading.refresh();
                      },
                      onTap: () {
                        if (trading.value != Trading.seeAll) {
                          trading.value = Trading.seeAll;
                          trading.refresh();
                        }
                        getRunning.rombongan.clear();
                        getRunning.rombongan.refresh();
                      },
                    ),
                    LinkedLabelRadio(
                      padding: EdgeInsets.zero,
                      label: 'Favorite Selected',
                      value: Trading.fokus,
                      groupValue: trading.value,
                      onChanged: (Trading? value) {
                        if (BottomModal.pageIndexNotifier.value == 0 &&
                            BuildListFav.list().isNotEmpty) {
                          BottomModal.pageIndexNotifier.value =
                              BottomModal.pageIndexNotifier.value + 1;
                          trading.value = value!;

                          trading.refresh();
                        }
                      },
                      onTap: () {
                        if (BuildListFav.list().isNotEmpty) {
                          BottomModal.pageIndexNotifier.value =
                              BottomModal.pageIndexNotifier.value + 1;
                          if (trading.value != Trading.fokus) {
                            trading.value = Trading.fokus;
                            trading.refresh();
                          }
                        }

                        if (BuildListFav.list().isEmpty) {
                          NotifikasiPopup.show("Favorite Is Empty");
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          BottomModal.page2(
            modalSheetContext,
            textTheme,
            onBack: () {
              trading.value = Trading.seeAll;
              trading.refresh();
            },
            sliverList: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => Obx(() {
                  return CheckboxListTile(
                    value: list[index],
                    title: Text(
                      BuildListFav.list()[index].groupTag!,
                      style: TextStyle(
                          color: Colors.white, fontSize: FontSizes.size14),
                    ),
                    onChanged: (values) {
                      getRunning.listQuery.clear();
                      list[index] = !list[index];
                      list.refresh();
                      if (list[index] == false) {
                        getRunning.rombongan.removeWhere(((element) =>
                            element.groupTag ==
                            BuildListFav.list()[index].groupTag));
                        getRunning.rombongan.refresh();
                      }
                      FavoriteLoacalB getMember;
                      List<FavoriteLoacalB> where = getRunning.rombongan
                          .where((p0) =>
                              p0.groupTag ==
                              BuildListFav.list()[index].groupTag)
                          .toList();
                      if (where.isEmpty) {
                        if (list[index] == true) {
                          if (BuildListFav.list()[index].member.isNotEmpty) {
                            getMember = BuildListFav.list()[index];
                            getRunning.rombongan.add(getMember);
                          } else {
                            NotifikasiPopup.show('Member Favorite Empty');
                          }
                        }
                      }
                    },
                  );
                }),
                childCount: BuildListFav.list().isEmpty
                    ? 0
                    : BuildListFav.list().length,
              ),
            ),
          ),
        ];
      },
      modalTypeBuilder: (context) {
        final size = MediaQuery.of(context).size.width;
        if (size < pageBreakpoint) {
          return WoltModalType.bottomSheet;
        } else {
          return WoltModalType.dialog;
        }
      },
      onModalDismissedWithBarrierTap: () {
        debugPrint('Closed modal sheet with barrier tap');
        Navigator.of(context).pop();
        BottomModal.pageIndexNotifier.value = 0;
      },
      maxDialogWidth: 560,
      minDialogWidth: 400,
    );
  }
}
