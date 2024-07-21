import 'package:flutter/material.dart';

String priceTextTh(String input) {
  // Reverse the input string to process from the least significant digit
  String reversedInput = input.split('').reversed.join('');

  // Use a buffer to build the formatted string
  StringBuffer formatted = StringBuffer();

  // Insert commas every 3 digits
  for (int i = 0; i < reversedInput.length; i++) {
    if (i > 0 && i % 3 == 0) {
      formatted.write(','); // Add a comma every 3 digits
    }
    formatted.write(reversedInput[i]);
  }

  // Reverse the result to get the final formatted number
  return 'N ${formatted.toString().split('').reversed.join()}';
}
