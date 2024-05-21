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
      backgroundColor: Colors.orangeAccent,
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: SafeArea(
          child: GFIntroScreen(
            color: Colors.orangeAccent,
            slides: slides(),
            pageController: _pageController,
            currentIndex: initialPage,
            pageCount: 2,
            introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
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
              navigationBarColor: Colors.orange,
              showDivider: false,
              inactiveColor: Colors.grey,
              activeColor: GFColors.SUCCESS,
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
        color: Colors.orangeAccent,
        image: const AssetImage('lib/assets/gasoline.png'),
        boxFit: BoxFit.contain,
        borderRadius: BorderRadius.circular(5),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20),
              child: Text(
                'Bem vindo ao app\n Gasolina ou Álcool?',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: const DecorationImage(
                  image: AssetImage('lib/assets/fuel.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 2),
            GFButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              text: "Iniciar",
              textStyle: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                fontSize: 14,
              ),
              color: Colors.orange,
              shape: GFButtonShape.square,
              size: GFSize.LARGE,
            ),
          ],
        ),
      ),
    ];
    return slideList;
  }
}
