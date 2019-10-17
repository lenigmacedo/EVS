import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorsTheme {

  static const Color primaryColor = Color(0xFF1e469a);
  static const Color secondaryColor = Color(0xFF49a7c1);

  static LinearGradient gradient = LinearGradient(
    colors: const [primaryColor, secondaryColor],
  );
}

class Settings {
  //Manter orientação vertical
  static final orientation = SystemChrome.setPreferredOrientations(
      ([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]));

  //Remover cor barra de status
  static final statusBar = SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}
