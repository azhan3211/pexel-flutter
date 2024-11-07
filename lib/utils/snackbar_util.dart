import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static showSnackBarSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          message,
        style: const TextStyle(
          color: Colors.green
        ),
      ),
    ));
  }
}