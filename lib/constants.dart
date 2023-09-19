import 'package:flutter/material.dart';

const API_KEY = "MpLsvha6rvJBeHW6XWaz";
const kPrimaryColor = Colors.lightGreen;
final kBorderColor = Colors.greenAccent.shade400;
const kTextColor = Colors.white;

final kInputTextField = InputDecoration(
  prefixIcon: null,
  prefixIconColor: Colors.grey,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.lightGreen.shade500,
    ),
    borderRadius: BorderRadius.circular(5),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
  ),
  labelText: null,
);

final kLoginRegisterButtons = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(
    Colors.lightGreen.shade500,
  ),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  elevation: MaterialStateProperty.all(5),
  fixedSize: null,
);
