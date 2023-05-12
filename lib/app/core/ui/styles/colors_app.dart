import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get backgroundd => Colors.grey[300]!;
}

extension ColorsAppExtencion on BuildContext {
  ColorsApp get colorsApp => ColorsApp.instance;
}
