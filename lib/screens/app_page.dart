import 'package:alcool_ou_gasolina/controllers/locale_controller.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:alcool_ou_gasolina/screens/consumption_page.dart';
import 'package:alcool_ou_gasolina/screens/fipe_page.dart';
import 'package:alcool_ou_gasolina/screens/home_page.dart';
import 'package:alcool_ou_gasolina/screens/liters_page.dart';
import 'package:alcool_ou_gasolina/screens/mycar_page.dart';
import 'package:alcool_ou_gasolina/screens/settings_app.dart';
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
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final currentLocale = context.locale;
    return Consumer<LocaleController>(
      builder: (context, languageProvider, child) {
        final notifier = Provider.of<UiProvider>(context);
        return Scaffold(
          body: SizedBox(
            key: ValueKey(currentLocale),
            height: myHeight,
            width: myWidth,
            child: GFTabBarView(
              key: _tabBarKey,
              controller: tabController,
              children: const <Widget>[
                HomePage(),
                ConsumptionPage(),
                LitersPage(),
                MyCarPage(),
                FipePage(),
                SettingsPage(),
              ],
            ),
          ),
          bottomNavigationBar: GFTabBar(
            labelPadding: EdgeInsets.zero,
            length: 6,
            tabBarHeight: 70,
            controller: tabController,
            tabBarColor:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
            labelColor:
                notifier.isDark
                    ? TextColor.secondaryColor
                    : TextColor.primaryColor,
            indicatorColor:
                notifier.isDark
                    ? TextColor.secondaryColor
                    : TextColor.primaryColor,
            labelStyle: GoogleFonts.jetBrainsMono(
              textStyle: const TextStyle(fontSize: 9),
            ),
            tabs: [
              Tab(
                icon: const Icon(Icons.home, size: 18),
                child: Text(
                  'home'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(Icons.car_repair, size: 18),
                child: Text(
                  'consumption'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(Icons.local_gas_station_outlined, size: 18),
                child: Text(
                  'liters'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(Icons.car_rental, size: 18),
                child: Text(
                  'mycar'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(Icons.car_crash, size: 18),
                child: Text(
                  'fipe'.tr(),
                  style: GoogleFonts.jetBrainsMono(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Tab(
                icon: const Icon(Icons.settings, size: 18),
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
