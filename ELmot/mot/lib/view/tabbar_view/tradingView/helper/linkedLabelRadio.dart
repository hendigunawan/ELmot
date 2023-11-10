import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinkedLabelRadio<T> extends StatelessWidget {
  const LinkedLabelRadio({
    super.key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.onTap,
  });

  final String label;
  final EdgeInsets padding;
  final T groupValue;
  final T value;
  final ValueChanged<T> onChanged;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<T>(
            groupValue: groupValue,
            value: value,
            onChanged: (T? newValue) {
              onChanged(newValue as T);
            },
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              constraints: BoxConstraints(
                minWidth: Get.width * 0.05,
                maxWidth: Get.width * 0.7,
                maxHeight: Get.height * 0.05,
                minHeight: Get.height * 0.005,
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
