import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({super.key});

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, notifier, child) {
      return Scaffold(
        backgroundColor:
            notifier.isDark ? AppTheme.secondaryColor : AppTheme.primaryColor,
      );
    });
  }
}
