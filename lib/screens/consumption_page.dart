import 'package:alcool_ou_gasolina/features/app_assets.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({super.key});

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  final _kmsFocus = FocusNode();
  final _litersFocus = FocusNode();
  TextEditingController distanceController = TextEditingController();
  TextEditingController fuelController = TextEditingController();
  bool loading = false;
  String resultText = '';

  void handleCalc() {
    setState(() {
      loading = true;
    });

    double distance =
        double.tryParse(distanceController.text.replaceAll(',', '.')) ?? 0;
    double fuel =
        double.tryParse(fuelController.text.replaceAll(',', '.')) ?? 0;

    if (distance == 0 || fuel == 0) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return Consumer<UiProvider>(
            builder: (context, notifier, child) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color:
                        notifier.isDark
                            ? AppTheme.primaryColor
                            : AppTheme.thirdColor,
                    width: 2,
                  ),
                ),
                backgroundColor:
                    notifier.isDark
                        ? AlertDialogColor.primaryColor
                        : AlertDialogColor.secondaryColor,
                content: Text(
                  'pleasefillinallfields'.tr(),
                  style: context.bodySmallDialog,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK', style: context.bodySmallDialog),
                  ),
                ],
              );
            },
          );
        },
      );
      return;
    }

    double consumption = distance / fuel;

    setState(() {
      resultText =
          '${'consumption'.tr()}: ${consumption.toStringAsFixed(2)} Km/l';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: GFAppBar(
            backgroundColor:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('calculateconsumption'.tr(), style: context.h1),
          ),
          backgroundColor:
              notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              height: myHeight,
              width: myWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'infoconsumption'.tr(),
                        textAlign: TextAlign.center,
                        style: context.h2,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Gasoline.asset(),
                    const SizedBox(height: 10),
                    Text('averageconsumption'.tr(), style: context.bodySmall),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 180,
                        child: TextField(
                          cursorColor:
                              notifier.isDark
                                  ? FormColor.secondaryColor
                                  : FormColor.primaryColor,
                          controller: distanceController,
                          textInputAction: TextInputAction.done,
                          focusNode: _kmsFocus,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'kmsdriven'.tr(),
                            labelStyle: context.textSmall,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    notifier.isDark
                                        ? FormColor.secondaryColor
                                        : FormColor.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        cursorColor:
                            notifier.isDark
                                ? FormColor.secondaryColor
                                : FormColor.primaryColor,
                        controller: fuelController,
                        textInputAction: TextInputAction.done,
                        focusNode: _litersFocus,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'liters'.tr(),
                          labelStyle: context.textSmall,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.isDark
                                      ? FormColor.secondaryColor
                                      : FormColor.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 180,
                      child: GFButton(
                        color:
                            notifier.isDark
                                ? ButtonColor.primaryColor
                                : ButtonColor.secondaryColor,
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline2x,
                        onPressed: loading ? null : handleCalc,
                        child: Text(
                          'calculate'.tr(),
                          style: context.textSmallBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(resultText),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
