import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/pages/ConsumptionPage/consumption_page.dart';
import 'package:alcool_ou_gasolina/pages/HomePage/home_page.dart';
import 'package:alcool_ou_gasolina/pages/MyCar/mycar_app.dart';
import 'package:alcool_ou_gasolina/pages/SettingsPage/settings_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: GFAppBar(
            backgroundColor: notifier.isDark ? AppTheme.secondaryColor : AppTheme.primaryColor,
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
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: GFTabBarView(
              controller: tabController,
              children: const <Widget>[
                HomePage(),
                ConsumptionPage(),
                MyCarPage(),
                SettingsPage(),
              ],
            ),
          ),
          bottomNavigationBar: GFTabBar(
            labelPadding: EdgeInsets.zero,
            length: 4,
            tabBarHeight: 60,
            controller: tabController,
            tabBarColor: notifier.isDark
                ? AppTheme.secondaryColor
                : AppTheme.primaryColor,
            labelColor: notifier.isDark
                ? TextColor.secondaryColor
                : TextColor.primaryColor,
            indicatorColor: notifier.isDark
                ? TextColor.secondaryColor
                : TextColor.primaryColor,
            labelStyle: GoogleFonts.jetBrainsMono(
              textStyle: const TextStyle(fontSize: 8),
            ),
            tabs: [
              Tab(
                icon: const Icon(
                  Icons.home,
                  size: 16,
                ),
               child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'home'.tr(),
                  ),
                ),
              ),
               Tab(
                icon: const Icon(
                  Icons.gas_meter_outlined,
                  size: 16,
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'consumption'.tr(),
                  ),
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.car_rental,
                  size: 16,
                ),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'mycar'.tr(),
                  ),
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.settings,
                  size: 16,
                ),
                 child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'settings'.tr(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
