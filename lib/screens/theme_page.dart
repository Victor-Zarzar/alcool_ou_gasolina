import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UiProvider>(context);

    return Scaffold(
      backgroundColor:
          notifier.isDark
              ? BackGroundColor.primaryColor
              : BackGroundColor.secondaryColor,
      appBar: GFAppBar(
        title: Text("select_theme".tr(), style: context.h1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:
                notifier.isDark ? IconColor.thirdColor : IconColor.primaryColor,
            semanticLabel: 'backtopage'.tr(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor:
            notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children:
              ThemeModeOption.values.map((option) {
                IconData icon;
                String label;

                switch (option) {
                  case ThemeModeOption.light:
                    icon = Icons.light_mode;
                    label = "light_theme".tr();
                    break;
                  case ThemeModeOption.dark:
                    icon = Icons.dark_mode;
                    label = "dark_theme".tr();
                    break;
                  case ThemeModeOption.system:
                    icon = Icons.settings;
                    label = "system_theme".tr();
                    break;
                }

                return RadioListTile<ThemeModeOption>(
                  title: Text(label, style: context.bodyMediumFont),
                  secondary: Icon(
                    icon,
                    semanticLabel: 'select_icon'.tr(),
                    color:
                        notifier.isDark
                            ? IconColor.thirdColor
                            : IconColor.primaryColor,
                  ),
                  activeColor:
                      notifier.isDark
                          ? IconColor.thirdColor
                          : IconColor.primaryColor,
                  value: option,
                  groupValue: notifier.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      notifier.changeTheme(value);
                    }
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
