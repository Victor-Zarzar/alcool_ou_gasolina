import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class Fuel {
  Fuel._();

  static Image asset() {
    return Image.asset(
      'assets/imgs/imageone.png',
      height: 140,
      width: 190,
      semanticLabel: 'fuelimage'.tr(),
    );
  }
}

class Gasoline {
  Gasoline._();

  static Image asset() {
    return Image.asset(
      'assets/imgs/gas.png',
      height: 140,
      width: 190,
      semanticLabel: 'dashboard'.tr(),
    );
  }
}

class FuelMarker {
  FuelMarker._();

  static Image asset() {
    return Image.asset(
      'assets/imgs/fuel.png',
      height: 140,
      width: 190,
      semanticLabel: 'fuelmarker'.tr(),
    );
  }
}

class Car {
  Car._();

  static Image asset() {
    return Image.asset(
      'assets/imgs/car.png',
      height: 140,
      width: 190,
      semanticLabel: 'imageofacar'.tr(),
    );
  }
}

class CarFipe {
  CarFipe._();

  static Image asset() {
    return Image.asset(
      'assets/imgs/carfipe.png',
      height: 180,
      width: 230,
      semanticLabel: 'dashboard'.tr(),
    );
  }
}

class PTBR {
  PTBR._();

  static Widget asset() {
    return SvgPicture.asset('assets/icons/pt.svg', height: 20, width: 20);
  }
}

class ES {
  ES._();

  static Widget asset() {
    return SvgPicture.asset('assets/icons/es.svg', height: 20, width: 20);
  }
}

class EN {
  EN._();

  static Widget asset() {
    return SvgPicture.asset('assets/icons/en.svg', height: 20, width: 20);
  }
}
