import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle = const ButtonStyle(
  padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0)),
  backgroundColor: WidgetStatePropertyAll(Colors.white),
  foregroundColor: WidgetStatePropertyAll(Colors.black),
  textStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
);
