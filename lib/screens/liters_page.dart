import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/darktheme_provider_app.dart';
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
  final _suppliedFocus = FocusNode();
  final _litreFocus = FocusNode();
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: notifier.isDark
                        ? AppTheme.primaryColor
                        : AppTheme.thirdColor,
                    width: 2,
                  ),
                ),
                backgroundColor: notifier.isDark
                    ? AlertDialogColor.primaryColor
                    : AlertDialogColor.secondaryColor,
                content: Text(
                  'pleasefillinallfields'.tr(),
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
                              : TextColor.primaryColor,
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
                  fontSize: 15,
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
                        'infoliters'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: notifier.isDark
                                ? TextColor.secondaryColor
                                : TextColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/fuel.png",
                      height: 140,
                      width: 190,
                      semanticLabel: 'fuelmarker'.tr(),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'suppliedvalue'.tr(),
                        textAlign: TextAlign.center,
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
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 180,
                        child: TextField(
                          controller: gasolineController,
                          textInputAction: TextInputAction.done,
                          focusNode: _suppliedFocus,
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
                          textInputAction: TextInputAction.done,
                          focusNode: _litreFocus,
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
                        type: GFButtonType.outline2x,
                        onPressed: loading ? null : handleCalc,
                        child: Text(
                          'calculate'.tr(),
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
          ),
        );
      },
    );
  }
}
