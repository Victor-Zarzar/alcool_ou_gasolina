import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          backgroundColor:
              notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: Column(
              children: [
                SizedBox(
                  width: myWidth,
                  child: GFAppBar(
                    centerTitle: true,
                    backgroundColor: notifier.isDark
                        ? AppTheme.thirdColor
                        : AppTheme.primaryColor,
                    title: Text(
                      "about".tr(),
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
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.primaryColor,
                        semanticLabel: 'backtopage'.tr(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          semanticLabel: 'informationicon'.tr(),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "description".tr(),
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
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "victorzarzar".tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: notifier.isDark
                              ? TextColor.secondaryColor
                              : TextColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
