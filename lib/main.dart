import 'package:flutter/material.dart';

// هنا هننادي على الملفات من جوه الفولدر الجديد بتاعك
// استبدلي 'screens' باسم الفولدر اللي إنتِ عملتيه
import 'screens/role_selection_screen.dart';
// بالاسم اللي إنتِ مسمياه بدون i

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProFix',
      theme: ThemeData(
        primaryColor: const Color(0xFF3D5CFF),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      // دي أول شاشة هتظهر لما تفتحي التطبيق
      home: const RoleSelectionScreen(),
    );
  }
}
