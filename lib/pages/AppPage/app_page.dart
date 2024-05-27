import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/pages/HomePage/home_page.dart';
import 'package:alcool_ou_gasolina/pages/MyCar/mycar_app.dart';
import 'package:alcool_ou_gasolina/pages/SettingsPage/settings_app.dart';
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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: GFAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Álcool ou Gasolina?',
              style: GoogleFonts.jetBrainsMono(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: notifier.isDark ? Colors.grey.shade600 : Colors.black,
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
                MyCarPage(),
                SettingsPage(),
              ],
            ),
          ),
          bottomNavigationBar: GFTabBar(
            length: 3,
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
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 16,
                ),
                child: Text(
                  'Home',
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.car_rental,
                  size: 16,
                ),
                child: Text(
                  'My Car',
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size: 16,
                ),
                child: Text(
                  'Settings',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
