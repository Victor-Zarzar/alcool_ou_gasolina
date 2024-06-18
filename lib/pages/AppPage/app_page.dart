import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/pages/ConsumptionPage/consumption_page.dart';
import 'package:alcool_ou_gasolina/pages/HomePage/home_page.dart';
import 'package:alcool_ou_gasolina/pages/LitersPage/liters_page.dart';
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
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: GFTabBarView(
              controller: tabController,
              children: const <Widget>[
                HomePage(),
                ConsumptionPage(),
                LitersPage(),
                MyCarPage(),
                SettingsPage(),
              ],
            ),
          ),
          bottomNavigationBar: GFTabBar(
            labelPadding: EdgeInsets.zero,
            length: 5,
            tabBarHeight: 60,
            controller: tabController,
            tabBarColor:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
            labelColor: notifier.isDark
                ? TextColor.secondaryColor
                : TextColor.primaryColor,
            indicatorColor: notifier.isDark
                ? TextColor.secondaryColor
                : TextColor.primaryColor,
            labelStyle: GoogleFonts.jetBrainsMono(
              textStyle: const TextStyle(fontSize: 9),
            ),
            tabs: [
              Tab(
                icon: const Icon(
                  Icons.home,
                  size: 18,
                ),
                child: Text(
                  'home'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.car_repair,
                  size: 18,
                ),
                child: Text(
                  'consumption'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.local_gas_station_outlined,
                  size: 18,
                ),
                child: Text(
                  'liters'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.car_rental,
                  size: 18,
                ),
                child: Text(
                  'mycar'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(
                  Icons.settings,
                  size: 18,
                ),
                child: Text(
                  'settings'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
