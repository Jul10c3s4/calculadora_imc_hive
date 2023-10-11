import 'package:calculadora_imc_hive/models/imc_hive.dart';
import 'package:calculadora_imc_hive/pages/calculator-imc-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(ImcAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IMC Calculator App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: GoogleFonts.arimaTextTheme(),
        ),
        home: const CalculatorImcPage());
  }
}
