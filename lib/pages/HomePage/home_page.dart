import 'package:alcool_ou_gasolina/components/AppTheme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController gasolineController = TextEditingController();
  TextEditingController alcoholController = TextEditingController();
  bool loading = false;
  String resultText = '';
  bool visible = false;

  void handleCalc() async {
    setState(() {
      loading = true;
    });

    if (gasolineController.text.isEmpty || alcoholController.text.isEmpty) {
      setState(() {
        loading = false;
      });
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Preencha ambos os dados.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    double gas =
        double.parse(gasolineController.text.replaceAll(',', '.')) / 100;
    double alc =
        double.parse(alcoholController.text.replaceAll(',', '.')) / 100;
    double auxResult = alc / gas;

    if (auxResult >= 0.7) {
      setState(() {
        resultText = 'Compensa utilizar Gasolina!';
      });
    } else {
      setState(() {
        resultText = 'Compensa utilizar Álcool!';
      });
    }

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      loading = false;
      visible = true;
    });

    FocusScope.of(context).unfocus();
  }

  void clearResult() {
    setState(() {
      resultText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: GFAppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'Álcool ou Gasolina?',
          style: GoogleFonts.jetBrainsMono(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TextColor.primaryColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calcule Aqui',
              style: GoogleFonts.jetBrainsMono(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, 
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                height: 50,
                width: 180,
                child: TextField(
                  controller: gasolineController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Gasolina',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 180,
              child: TextField(
                controller: alcoholController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Álcool',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loading ? null : handleCalc,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: clearResult,
              child: const Text('Limpar Resultado'),
            ),
            const SizedBox(height: 10),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
