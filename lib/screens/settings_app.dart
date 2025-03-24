import 'package:alcool_ou_gasolina/controllers/notification_controller.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:alcool_ou_gasolina/screens/about_page.dart';
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
    final notificationController = Provider.of<NotificationController>(context);
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
              'settings'.tr(),
              style: GoogleFonts.jetBrainsMono(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:
                      notifier.isDark
                          ? TextColor.secondaryColor
                          : TextColor.primaryColor,
                ),
              ),
            ),
          ),
          body: Container(
            color:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
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
                      leading: Icon(
                        Icons.dark_mode,
                        semanticLabel: 'notifications_icon'.tr(),
                        size: 20,
                      ),
                      title: Text(
                        'darkmode'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                notifier.isDark
                                    ? TextColor.secondaryColor
                                    : TextColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notification_important,
                      semanticLabel: 'about_icon'.tr(),
                      size: 20,
                    ),
                    title: Text(
                      'notifications'.tr(),
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              notifier.isDark
                                  ? TextColor.secondaryColor
                                  : TextColor.primaryColor,
                        ),
                      ),
                    ),
                    trailing: Switch(
                      value: notificationController.notificationsEnabled,
                      onChanged: notificationController.toggleNotifications,
                      activeColor:
                          notifier.isDark
                              ? SwitchColor.darkActiveColor
                              : SwitchColor.thirdColor,
                      inactiveTrackColor:
                          notifier.isDark
                              ? SwitchColor.darkInactiveTrackColor
                              : SwitchColor.secondaryColor,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      semanticLabel: 'darkmode_icon'.tr(),
                      size: 20,
                    ),
                    title: Text(
                      'about'.tr(),
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:
                              notifier.isDark
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
          ),
        );
      },
    );
  }
}
