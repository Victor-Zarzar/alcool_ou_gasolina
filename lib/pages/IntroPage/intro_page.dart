import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:alcool_ou_gasolina/pages/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: myHeight,
          width: myWidth,
          child: SafeArea(
            child: GFIntroScreen(
              color: AppTheme.primaryColor,
              slides: slides(),
              pageController: _pageController,
              currentIndex: initialPage,
              pageCount: 2,
              introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
                navigationBarHeight: 60,
                skipButtonText: 'Pular',
                backButtonText: 'Voltar',
                doneButtonText: 'Concluir',
                forwardButtonText: 'Avançar',
                pageController: _pageController,
                pageCount: slideList.length,
                currentIndex: initialPage,
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
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                navigationBarColor: BarColor.primaryColor,
                showDivider: false,
                inactiveColor: Inactive.primaryColor,
                activeColor: Active.primaryColor,
                backButtonTextStyle: const TextStyle(fontSize: 13),
                skipButtonTextStyle: const TextStyle(fontSize: 13),
                forwardButtonTextStyle: const TextStyle(fontSize: 13),
                doneButtonTextStyle: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> slides() {
    slideList = [
      SizedBox(
        height: 250,
        width: 250,
        child: GFImageOverlay(
          padding: const EdgeInsets.all(10),
          color: AppTheme.primaryColor,
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
                padding: const EdgeInsets.only(top: 30.0, left: 20),
                child: Text(
                  'Bem vindo ao app\n Álcool ou Gasolina?',
                  style: GoogleFonts.jetBrainsMono(
                    textStyle: TextStyle(
                        color: TextColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20),
                child: Text(
                  'Qual Compensa mais?',
                  style: GoogleFonts.jetBrainsMono(
                    textStyle: TextStyle(
                        color: TextColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  height: 250,
                  width: 250,
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
