import 'package:alcool_ou_gasolina/controllers/locale_controller.dart';
import 'package:alcool_ou_gasolina/controllers/notification_controller.dart';
import 'package:alcool_ou_gasolina/features/app_assets.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:alcool_ou_gasolina/screens/about_page.dart';
import 'package:alcool_ou_gasolina/screens/theme_page.dart';
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
            title: Text('settings'.tr(), style: context.h1),
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
                      leading: Icon(
                        Icons.translate,
                        color:
                            notifier.isDark
                                ? IconColor.thirdColor
                                : IconColor.primaryColor,
                      ),
                      title: Text(
                        'language'.tr(),
                        style: context.bodyMediumFont,
                      ),
                      trailing: PopupMenuButton<Locale>(
                        color:
                            notifier.isDark
                                ? PopupMenuColor.thirdColor
                                : PopupMenuColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.language, color: IconColor.thirdColor),
                            const SizedBox(width: 4),
                            Text('english'.tr(), style: context.bodyMediumFont),
                            Icon(
                              Icons.arrow_drop_down,
                              color: IconColor.thirdColor,
                              semanticLabel: 'arrow_icon'.tr(),
                            ),
                          ],
                        ),
                        onSelected: (Locale locale) {
                          Provider.of<LocaleController>(
                            context,
                            listen: false,
                          ).changeLanguage(context, locale);
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              PopupMenuItem(
                                value: const Locale('en', 'US'),
                                child: Row(
                                  children: [
                                    EN.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'english'.tr(),
                                      style: GoogleFonts.jetBrainsMono(
                                        textStyle: TextStyle(
                                          color:
                                              notifier.isDark
                                                  ? TextColor.secondaryColor
                                                  : TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: const Locale('pt', 'BR'),
                                child: Row(
                                  children: [
                                    PTBR.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'portuguese'.tr(),
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color:
                                              notifier.isDark
                                                  ? TextColor.secondaryColor
                                                  : TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: const Locale('es'),
                                child: Row(
                                  children: [
                                    ES.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'spanish'.tr(),
                                      style: GoogleFonts.jetBrainsMono(
                                        textStyle: TextStyle(
                                          color:
                                              notifier.isDark
                                                  ? TextColor.secondaryColor
                                                  : TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      semanticLabel: 'arrow_icon'.tr(),
                      color:
                          notifier.isDark
                              ? IconColor.thirdColor
                              : IconColor.primaryColor,
                    ),
                    title: Text('theme'.tr(), style: context.bodyMediumFont),
                    trailing: Icon(
                      Icons.arrow_forward,
                      semanticLabel: 'arrow_icon'.tr(),
                      color:
                          notifier.isDark
                              ? IconColor.thirdColor
                              : IconColor.primaryColor,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ThemePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notification_important,
                      semanticLabel: 'about_icon'.tr(),
                      size: 20,
                    ),
                    title: Text(
                      'notifications'.tr(),
                      style: context.bodyMediumFont,
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
                    title: Text('about'.tr(), style: context.bodyMediumFont),
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
