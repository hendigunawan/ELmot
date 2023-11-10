import 'package:flutter/material.dart';
import 'package:animated_page_reveal/animated_page_reveal.dart';

class CarrouselModel {
  String? title;
  String? description;
  String? imageAsset;
  String? iconPage;
  Color? color;
  TextStyle? titleStyle;
  TextStyle? descriptionStyle;

  CarrouselModel({
    this.title = '',
    this.description = '',
    this.imageAsset = '',
    this.iconPage = '',
    this.color,
    this.descriptionStyle,
    this.titleStyle,
  });
}

class Carrousel extends StatelessWidget {
  const Carrousel(
      {super.key,
      this.width,
      this.height,
      this.listItem,
      this.boxDecoration,
      this.borderRadius});
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  final List<CarrouselModel>? listItem;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!.toDouble()),
      child: Container(
        decoration: boxDecoration,
        width: width,
        height: height,
        child: AnimatedPageReveal(
          children: listItem!.map(
            (e) {
              return PageViewModel(
                title: e.title.toString(),
                description: e.description.toString(),
                color: e.color as Color,
                imageAssetPath: e.imageAsset.toString(),
                iconAssetPath: e.iconPage.toString(),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
