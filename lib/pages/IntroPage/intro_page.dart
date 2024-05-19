import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: SizedBox(height: myHeight, width: myWidth, child: Column()));
  }
}
