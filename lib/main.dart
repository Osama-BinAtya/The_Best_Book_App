import 'package:flutter/material.dart';
import 'package:the_best_books_app/screens/intro_screen.dart';

// متغير بسيط لإدارة الثيم (فاتح / داكن) في كامل التطبيق
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kids English App',
          themeMode: currentMode,

          // 1. الثيم الفاتح (هوية السلسلة البنفسجية الزاهية)
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF6B0282),

            // خلفية بنفسجية ملكية
            scaffoldBackgroundColor: const Color(0xFF510162),

            // كروت بيضاء وواضحة
            cardColor: Colors.white,

            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 2. الثيم الداكن (بنفسجي ليلي داكن جداً ومريح للعين)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF6B0282),

            // 👈 خلفية بنفسجية ليلية شديدة الداكنة (Night Purple)
            scaffoldBackgroundColor: const Color(0xFF14021A),

            // 👈 كروت بنفسجية داكنة بدرجة متباينة وأنيقة
            cardColor: const Color(0xFF2A0A33),

            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          home: const IntroScreen(),
        );
      },
    );
  }
}
