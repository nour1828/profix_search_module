import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/search_screen.dart';

void main() {
  // Ensure framework is initialized and set system UI overlay style
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const ProfixApp());
}

class ProfixApp extends StatelessWidget {
  const ProfixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profix Service App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF4A68FF),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        fontFamily: 'Roboto', // Default professional font
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SearchScreen(),
    );
  }
}