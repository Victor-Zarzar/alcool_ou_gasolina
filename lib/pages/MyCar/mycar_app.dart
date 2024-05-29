import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/DarkTheme/darktheme_provider_app.dart';

class MyCarPage extends StatefulWidget {
  const MyCarPage({super.key});

  @override
  State<MyCarPage> createState() => _MyCarPageState();
}

class _MyCarPageState extends State<MyCarPage> {
  late final TextEditingController _plateController = TextEditingController();
  late final TextEditingController _modelController = TextEditingController();
  late final TextEditingController _yearController = TextEditingController();
  late final TextEditingController _consumptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCarInfo();
  }

  Future<void> _loadCarInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _plateController.text = prefs.getString('plate') ?? '';
      _modelController.text = prefs.getString('model') ?? '';
      _yearController.text = prefs.getInt('year')?.toString() ?? '';
      _consumptionController.text = prefs.getString('consumption') ?? '';
    });
  }

  Future<void> _saveCarInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('plate', _plateController.text);
    await prefs.setString('model', _modelController.text);
    await prefs.setInt('year', int.tryParse(_yearController.text) ?? 0);
    await prefs.setString('consumption', _consumptionController.text);
  }

  Future<void> _deleteCarInfo() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('plate');
    await prefs.remove('model');
    await prefs.remove('year');
    await prefs.remove('consumption');
    setState(() {
      _plateController.clear();
      _modelController.clear();
      _yearController.clear();
      _consumptionController.clear();
    });
    scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text('Car info deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return SizedBox(
          height: myHeight,
          width: myWidth,
          child: Scaffold(
            backgroundColor: notifier.isDark
                ? AppTheme.secondaryColor
                : AppTheme.primaryColor,
            appBar: AppBar(
              backgroundColor: notifier.isDark
                  ? AppTheme.secondaryColor
                  : AppTheme.primaryColor,
              automaticallyImplyLeading: false,
              title: Text(
                'My Car',
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: notifier.isDark
                        ? TextColor.secondaryColor
                        : TextColor.primaryColor,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () async {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    await _saveCarInfo();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Car info saved')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _deleteCarInfo();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  Image.asset(
                    "assets/car.png",
                    height: 140,
                    width: 190,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        controller: _plateController,
                        decoration: const InputDecoration(
                          labelText: 'Plate',
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: TextField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: 'Car Model',
                        labelStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: TextField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                        labelStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    width: 180,
                    child: TextField(
                      controller: _consumptionController,
                      decoration: const InputDecoration(
                        labelText: 'Consumption',
                        labelStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
