import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _gasolineFocus = FocusNode();
  final _alcoholFocus = FocusNode();
  TextEditingController gasolineController = TextEditingController();
  TextEditingController alcoholController = TextEditingController();
  bool loading = false;
  String resultText = '';
  bool visible = false;

  KeyboardActionsConfig _buildKeyboardActionsConfig(
      BuildContext context, bool isDark) {
    return KeyboardActionsConfig(
      keyboardBarColor: isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
      actions: [
        KeyboardActionsItem(
          focusNode: _gasolineFocus,
        ),
        KeyboardActionsItem(
          focusNode: _alcoholFocus,
        ),
      ],
    );
  }

  void handleCalc() async {
    setState(() {
      loading = true;
    });

    if (gasolineController.text.isEmpty || alcoholController.text.isEmpty) {
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

    double gas =
        double.parse(gasolineController.text.replaceAll(',', '.')) / 100;
    double alc =
        double.parse(alcoholController.text.replaceAll(',', '.')) / 100;
    double auxResult = alc / gas;

    if (auxResult >= 0.7) {
      setState(() {
        resultText = 'alcoholresult'.tr();
      });
    } else {
      setState(() {
        resultText = 'gasolineresult'.tr();
      });
    }

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      loading = false;
      visible = true;
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
              'titleappbar'.tr(),
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
          body: KeyboardActions(
            config: _buildKeyboardActionsConfig(context, notifier.isDark),
            child: SizedBox(
              height: myHeight,
              width: myWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/imageone.png",
                      height: 140,
                      width: 190,
                      semanticLabel: 'fuelimage'.tr(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'whichonepaysmore'.tr(),
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
                          cursorColor: notifier.isDark
                              ? FormColor.secondaryColor
                              : FormColor.primaryColor,
                          controller: gasolineController,
                          textInputAction: TextInputAction.done,
                          focusNode: _gasolineFocus,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'gasoline'.tr(),
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
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        cursorColor: notifier.isDark
                            ? FormColor.secondaryColor
                            : FormColor.primaryColor,
                        controller: alcoholController,
                        textInputAction: TextInputAction.done,
                        focusNode: _alcoholFocus,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'alcohol'.tr(),
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
