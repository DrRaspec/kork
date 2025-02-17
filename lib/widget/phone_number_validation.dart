import 'package:flutter/services.dart';

TextInputFormatter phoneNumberFormatter() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    String text = newValue.text.replaceAll(' ', '');
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5 || i == 8) {
        formattedText += ' ';
      }
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  });
}
