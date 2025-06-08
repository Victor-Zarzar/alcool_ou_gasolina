import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('${'launch_error'.tr()} $url');
    }
  }

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
                    backgroundColor:
                        notifier.isDark
                            ? AppTheme.thirdColor
                            : AppTheme.primaryColor,
                    title: Text("about".tr(), style: context.h1),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color:
                            notifier.isDark
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
                        Icon(Icons.info, semanticLabel: 'informationicon'.tr()),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "description".tr(),
                            style: context.bodySmallBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () {
                        _launchUrl('https://www.victorzarzar.com.br');
                      },
                      child: Text(
                        "developed".tr(),
                        textAlign: TextAlign.center,
                        style: context.bodySmallBold,
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
