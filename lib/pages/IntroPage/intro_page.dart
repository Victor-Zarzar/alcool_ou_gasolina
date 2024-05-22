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
      body: SizedBox(
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
              skipButtonText: 'Pular',
              backButtonText: 'Voltar',
              doneButtonText: 'Concluir',
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
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> slides() {
    slideList = [
      GFImageOverlay(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        color: AppTheme.primaryColor,
        image: const AssetImage('lib/assets/gasoline.png'),
        boxFit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
            ColorFilterIntro.primaryColor.withOpacity(0.01), BlendMode.darken),
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
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20),
                child: Text(
                  'Qual Compensa mais?',
                  style: GoogleFonts.jetBrainsMono(
                    textStyle: TextStyle(
                        color: TextColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/fuel.png'),
                    fit: BoxFit.contain,
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
