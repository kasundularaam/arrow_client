import 'package:flutter/services.dart';

class IPAddressInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit characters
    text = text.replaceAll(RegExp(r'[^\d]'), '');

    List<String> octets = [];
    String currentOctet = '';

    for (int i = 0; i < text.length && octets.length < 4; i++) {
      currentOctet += text[i];

      if (octets.length < 2) {
        // First two octets: 3 digits each
        if (currentOctet.length == 3) {
          octets.add(currentOctet);
          currentOctet = '';
        }
      } else if (octets.length == 2) {
        // Third octet: 1 digit
        octets.add(currentOctet);
        currentOctet = '';
      } else if (octets.length == 3) {
        // Fourth octet: 1 to 3 digits
        if (currentOctet.length > 3) {
          currentOctet = currentOctet.substring(0, 3);
        }
      }
    }

    if (currentOctet.isNotEmpty && octets.length < 4) {
      octets.add(currentOctet);
    }

    String formattedText = octets.join('.');

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
