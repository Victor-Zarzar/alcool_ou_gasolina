import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/components/DarkTheme/darktheme_provider_app.dart';
import 'package:alcool_ou_gasolina/pages/AppPage/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  late List<Widget> slideList;
  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          backgroundColor: notifier.isDark
                        ? AppTheme.thirdColor
                        : AppTheme.primaryColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: myHeight,
              width: myWidth,
              child: SafeArea(
                child: GFIntroScreen(
                  slides: slides(),
                  pageController: _pageController,
                  currentIndex: initialPage,
                  pageCount: 2,
                  introScreenBottomNavigationBar:
                      GFIntroScreenBottomNavigationBar(
                    navigationBarHeight: 60,
                    skipButtonText: 'jump'.tr(),
                    backButtonText: 'previous'.tr(),
                    doneButtonText: 'conclude'.tr(),
                    forwardButtonText: 'next'.tr(),
                    pageController: _pageController,
                    pageCount: slideList.length,
                    currentIndex: initialPage,
                    onSkipTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppPage(),
                        ),
                      );
                    },
                    onForwardButtonTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    },
                    onBackButtonTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    },
                    onDoneTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppPage(),
                        ),
                      );
                    },
                    navigationBarColor: notifier.isDark
                        ? BarColor.secondaryColor
                        : BarColor.primaryColor,
                    showDivider: false,
                    inactiveColor: Inactive.primaryColor,
                    activeColor: Active.primaryColor,
                    backButtonTextStyle: const TextStyle(fontSize: 15),
                    skipButtonTextStyle: const TextStyle(fontSize: 15),
                    forwardButtonTextStyle: const TextStyle(fontSize: 15),
                    doneButtonTextStyle: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> slides() {
    slideList = [
      SizedBox(
        height: 250,
        width: 250,
        child: Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return GFImageOverlay(
              padding: const EdgeInsets.all(10),
              image: const AssetImage('assets/gasoline.png'),
              boxFit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  ColorFilterIntro.primaryColor.withOpacity(0.01),
                  BlendMode.darken),
              borderRadius: BorderRadius.circular(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30),
                    child: Text(
                      'introtext'.tr(),
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                            color: notifier.isDark
                                ? TextColor.secondaryColor
                                : TextColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 30),
                child: Consumer<UiProvider>(
                  builder: (context, notifier, child) {
                    return Text(
                      'introtexttwo'.tr(),
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: TextStyle(
                          color: notifier.isDark
                              ? TextColor.secondaryColor
                              : TextColor.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  height: 300,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: const DecorationImage(
                      image: AssetImage('assets/fuel.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
    return slideList;
  }
}
