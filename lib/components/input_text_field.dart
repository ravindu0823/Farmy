import 'package:farmy/constants.dart';
import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  final Icon icon;
  final String labelText;
  final Function onChanged;
  final bool obscureText;

  const InputTextFieldWidget({
    super.key,
    required this.icon,
    required this.labelText,
    required this.onChanged,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: kInputTextField.copyWith(
          prefixIcon: icon,
          labelText: labelText,
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
