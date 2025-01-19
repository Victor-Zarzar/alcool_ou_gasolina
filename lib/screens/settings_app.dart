import 'package:alcool_ou_gasolina/controller/notification_controller.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/screens/about_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('notifications_enabled')) {
      setState(() {
        _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      });
    } else {
      NotificationService.showWeeklyNotification(
        title: 'title_notification'.tr(),
        body: 'body_notification'.tr(),
        payload: 'rate_app',
      );
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
    });
    await prefs.setBool('notifications_enabled', value);
    if (value) {
      NotificationService.showWeeklyNotification(
        title: 'title_notification'.tr(),
        body: 'body_notification'.tr(),
        payload: 'rate_app',
      );
    } else {
      NotificationService.cancelWeeklyNotification();
    }
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
              'settings'.tr(),
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
                    leading: Icon(
                      Icons.notification_important,
                      semanticLabel: 'notifications_icon'.tr(),
                    ),
                    title: Text(
                      'notifications'.tr(),
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
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: _toggleNotifications,
                      activeColor: notifier.isDark
                          ? SwitchColor.darkActiveColor
                          : SwitchColor.thirdColor,
                      inactiveTrackColor: notifier.isDark
                          ? SwitchColor.darkInactiveTrackColor
                          : SwitchColor.secondaryColor,
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
          ),
        );
      },
    );
  }
}
