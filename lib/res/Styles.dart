import 'package:flutter/material.dart';

class Styles {
  static BoxDecoration get defaultDialogBackground => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Colors.white70));

  static BoxDecoration get defaultTextFieldDecoration => BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: Colors.white70));

  static double getDefaultDialogHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * .85;

  static double getDefaultDialogWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * .85;
}

Widget horizontalSpace(double space) => SizedBox(
      width: space,
    );

Widget verticalSpace(double space) => SizedBox(
      height: space,
    );
