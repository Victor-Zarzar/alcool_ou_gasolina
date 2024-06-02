import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/pages/AboutPage/about_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return GFDrawer(
          color: notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          child: SizedBox(
            height: myHeight,
            width: myWidth,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ListTile(
                    trailing: Switch(
                      activeColor: SwitchColor.primaryColor,
                      inactiveTrackColor: SwitchColor.secondaryColor,
                      value: notifier.isDark,
                      onChanged: (value) => notifier.changeTheme(),
                    ),
                    leading: const Icon(
                      Icons.dark_mode,
                      size: 20,
                    ),
                    title: Text(
                      'darkmode'.tr(),
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
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    size: 20,
                  ),
                  title: Text(
                    'about'.tr(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}