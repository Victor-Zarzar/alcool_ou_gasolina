import 'package:alcool_ou_gasolina/components/AppAssets/app_assets.dart';
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
  TextEditingController fuelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
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
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageOne.asset(),
              const SizedBox(height: 10),
              Text(
                'Calcule Aqui',
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: TextColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: fuelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Calcular', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
