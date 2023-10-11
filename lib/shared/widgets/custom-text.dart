import 'package:flutter/material.dart';

class CustomText {
  static title(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  static titleWhite(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  static subTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  static subTitleOk(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  static subTitleCancel(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  static subTitleCard(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  static subTitleCardButton(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  static subTitleButton(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
