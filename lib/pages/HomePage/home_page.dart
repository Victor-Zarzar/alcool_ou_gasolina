import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: GFAppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'Álcool ou Gasolina?',
          style: GoogleFonts.jetBrainsMono(
            textStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: TextColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
