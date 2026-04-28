import 'package:flutter/material.dart';

abstract final class Responsivo {
  static const double limiteMobile = 640;
  static const double limiteTablet = 900;

  static bool eMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < limiteMobile;

  static bool eTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < limiteTablet;

  static bool eDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= limiteTablet;
}
