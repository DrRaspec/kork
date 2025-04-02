import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget otpTextField(
  TextEditingController controller,
  FocusNode focusNode,
  BuildContext context, {
  bool next = false,
  bool previous = false,
}) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      border: Border.all(color: Get.theme.colorScheme.tertiary),
      borderRadius: BorderRadius.circular(60),
    ),
    child: Center(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (next) {
              FocusScope.of(context).nextFocus();
            } else {
              focusNode.unfocus(); 
            }
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    ),
  );
}
