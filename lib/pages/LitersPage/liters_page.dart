import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LitersPage extends StatefulWidget {
  const LitersPage({super.key});

  @override
  State<LitersPage> createState() => _LitersPageState();
}

class _LitersPageState extends State<LitersPage> {
  TextEditingController gasolineController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool loading = false;
  String resultText = '';

  void handleCalc() async {
    setState(() {
      loading = true;
    });

    if (gasolineController.text.isEmpty || priceController.text.isEmpty) {
      setState(() {
        loading = false;
      });
      return showDialog(
        context: context,
        builder: (context) {
          return Consumer<UiProvider>(
            builder: (context, notifier, child) {
              return AlertDialog(
                backgroundColor: notifier.isDark
                    ? ButtonColor.primaryColor
                    : ButtonColor.secondaryColor,
                content: Text(
                  'pleasefillinallfields'.tr(),
                  style: GoogleFonts.jetBrainsMono(
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: notifier.isDark
                          ? TextColor.secondaryColor
                          : TextColor.secondaryColor,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: notifier.isDark
                              ? TextColor.secondaryColor
                              : TextColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    double gas = double.parse(gasolineController.text.replaceAll(',', '.'));
    double price = double.parse(priceController.text.replaceAll(',', '.'));

    double totalLiters = gas / price;

    setState(() {
      resultText = '${'totalliters'.tr()} ${totalLiters.toStringAsFixed(2)}';
      loading = false;
    });
  }

  void clearResult() {
    setState(() {
      if (resultText.isEmpty) {
        _showNoDataToDeleteDialog();
      } else {
        resultText = '';
        gasolineController.clear();
        priceController.clear();
      }
    });
  }

  Future<void> _showNoDataToDeleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return AlertDialog(
              backgroundColor: notifier.isDark
                  ? ButtonColor.primaryColor
                  : ButtonColor.secondaryColor,
              content: Text(
                'nodatatodelete'.tr(),
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: notifier.isDark
                        ? TextColor.secondaryColor
                        : TextColor.secondaryColor,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
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
            title: Text(
              'howmanylitersdidifill?'.tr(),
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
          ),
          backgroundColor:
              notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/fuel.png",
                    height: 140,
                    width: 190,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'suppliedvalue'.tr(),
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "priceforlitre".tr(),
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        controller: gasolineController,
                        cursorColor: notifier.isDark
                            ? FormColor.secondaryColor
                            : FormColor.primaryColor,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'suppliedvaluers'.tr(),
                          labelStyle: TextStyle(
                            fontSize: 10,
                            color: notifier.isDark
                                ? TextColor.secondaryColor
                                : TextColor.primaryColor,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.isDark
                                  ? FormColor.secondaryColor
                                  : FormColor.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        controller: priceController,
                        cursorColor: notifier.isDark
                            ? FormColor.secondaryColor
                            : FormColor.primaryColor,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'priceperlitre'.tr(),
                          labelStyle: TextStyle(
                            fontSize: 10,
                            color: notifier.isDark
                                ? TextColor.secondaryColor
                                : TextColor.primaryColor,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.isDark
                                  ? FormColor.secondaryColor
                                  : FormColor.primaryColor,
                              width: 2,
                            ),
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
                      color: notifier.isDark
                          ? ButtonColor.primaryColor
                          : ButtonColor.secondaryColor,
                      shape: GFButtonShape.square,
                      onPressed: loading ? null : handleCalc,
                      child: Text(
                        'calculate'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: TextColor.secondaryColor,
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
                      color: notifier.isDark
                          ? ButtonColor.primaryColor
                          : ButtonColor.secondaryColor,
                      shape: GFButtonShape.square,
                      onPressed: clearResult,
                      child: Text(
                        'clearresult'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: TextColor.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    resultText,
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.primaryColor,
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
