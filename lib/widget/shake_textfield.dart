import 'package:flutter/material.dart';
import 'dart:math' show pi, sin;

Widget shakeTextfield({
  required Animation<double> shakeAnimation,
  required TextEditingController textfieldCtrl,
  required AnimationController shakeController,
  required FocusNode focusnode,
  required String hintext,
  required String errorMessage,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  double shakeIntensity = 5.0,
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)),
  Color? borderColor,
  Color? errorColor,
}) {
  return SizedBox(
    height: 40,
    child: AnimatedBuilder(
      animation: shakeAnimation,
      builder: (context, child) {
        final double shakeOffset =
            sin(shakeAnimation.value * 2 * pi) * shakeIntensity;

        return Transform.translate(
          offset: Offset(shakeOffset, 0),
          child: TextField(
            controller: textfieldCtrl,
            focusNode: focusnode,
            style: textStyle ??
                TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              isDense: true,
              contentPadding: contentPadding,
              hintText: hintext,
              hintStyle: hintStyle ??
                  TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.surfaceTint,
                  ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.tertiary,
                ),
                borderRadius: borderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: errorMessage.isNotEmpty
                      ? errorColor ?? Theme.of(context).colorScheme.primary
                      : borderColor ?? Theme.of(context).colorScheme.tertiary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorMessage.isNotEmpty
                      ? errorColor ?? Theme.of(context).colorScheme.primary
                      : borderColor ?? Theme.of(context).colorScheme.tertiary,
                ),
                borderRadius: borderRadius,
              ),
              suffixIcon: errorMessage.isNotEmpty
                  ? Icon(
                      Icons.error,
                      size: 20,
                      color:
                          errorColor ?? Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
          ),
        );
      },
    ),
  );
}
