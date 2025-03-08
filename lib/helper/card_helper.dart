String getCardType(String cardNumber) {
  if (cardNumber.startsWith('4')) {
    return 'Visa';
  } else if (RegExp(
          r'^(5[1-5]|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)')
      .hasMatch(cardNumber)) {
    return 'Mastercard';
  }
  return 'Unknown';
}

String maskCardNumber(String cardNumber) {
  var firstTwo = cardNumber.substring(0, 2);
  var lastTwo = cardNumber.substring(cardNumber.length - 2);
  var maskedPart = '*' * (cardNumber.length - 4);
  return '$firstTwo$maskedPart$lastTwo';
}
