import 'package:alcool_ou_gasolina/features/app_assets.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
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
            title: Text('titleappbar'.tr(), style: context.h1),
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
                        'whichonepaysmore'.tr(),
                        textAlign: TextAlign.center,
                        style: context.h2,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Fuel.asset(),
                    const SizedBox(height: 10),
                    Text("priceforlitre".tr(), style: context.bodySmall),
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
                          controller: gasolineController,
                          textInputAction: TextInputAction.done,
                          focusNode: _gasolineFocus,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'gasoline'.tr(),
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
                        controller: alcoholController,
                        textInputAction: TextInputAction.done,
                        focusNode: _alcoholFocus,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: 'alcohol'.tr(),
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
