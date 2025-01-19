import 'package:flutter/material.dart';

class ImageOne {
  ImageOne._();

  static Image asset() {
    return Image.asset(
      'assets/imageone.png',
      height: 250,
      width: 220,
    );
  }
}
