import 'package:flutter/material.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 1. الخلفية البنفسجية المتدرجة بنفس روح الصورة
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B0282), // بنفسجي زاهي في الأعلى
              Color(0xFF380048), // بنفسجي داكن في الأسفل
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),

                // 2. الهيدر والعناوين الرئيسية
                Column(
                  children: [
                    const Text(
                      'سلسلة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // عنوان "The Best" بخط كبير ومميز
                    Transform.rotate(
                      angle: -0.05, // إمالة خفيفة لتطابق روح الشعار في الصورة
                      child: const Text(
                        'The Best',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              offset: Offset(3, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Text(
                      'لتعليم اللغة الانجليزية..',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // 3. النص التعريفي المقتبس من الصورة
                // 3. النص التعريفي المطور (البديل للتكرار)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: const Text(
                    'تطبيقك التفاعلي الأسهل لتصفح منهج The Best بالكامل، والاستماع للنطق الصحيح للكلمات والجمل بنقرة واحدة.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // 4. عرض الكتب في أسفل الصفحة
                // ملاحظة: يمكنك وضع الصورة المجمعة للكتب هنا أو استبدالها بـ Image.asset
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // 👈 يمكنك زيادة الرقم أو إنقاصه حسب رغبتك
                      child: Image.asset(
                        'assets/images/The_Best.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.menu_book_rounded,
                              size: 100,
                              color: Colors.white38,
                            ),
                      ),
                    ),
                  ),
                ),

                // 5. زر الانتقال إلى مكتبة الكتب الرئيسية
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // الانتقال للشاشة الرئيسية (المكتبة)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B0282),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تصفح المنهج الآن',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
