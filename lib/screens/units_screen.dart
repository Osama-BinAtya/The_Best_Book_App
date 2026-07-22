import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../main.dart'; // لاستدعاء themeNotifier
import '../utils/string_extensions.dart'; // 👈 استيراد الـ Extension التي اعتمدناها
import 'lesson_screen.dart';

class UnitsScreen extends StatelessWidget {
  final BookModel book;

  const UnitsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 💡 تحويل لون الكتاب من الهيكس إلى Color (تأكد أن اسم الحقل في BookModel هو color)
    final Color cardColor = book.color.toColor();

    // 💡 حساب لون النص والأيقونات تلقائياً ليكون متبايناً ومريحاً للعين فوق لون الكرت
    final bool isLightBg = cardColor.computeLuminance() > 0.5;
    final Color textColor = isLightBg ? const Color(0xFF0F172A) : Colors.white;
    final Color subtextColor = isLightBg ? Colors.black54 : Colors.white70;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          // زر التحويل بين الفاتح والداكن
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, currentMode, child) {
              return IconButton(
                icon: Icon(
                  isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                  color: isDark ? Colors.amber : const Color(0xFF0F172A),
                ),
                onPressed: () {
                  themeNotifier.value = isDark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              );
            },
          ),
        ],
      ),
      body: book.units.isEmpty
          ? Center(
              child: Text(
                'No units found',
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: book.units.length,
              itemBuilder: (context, index) {
                final unit = book.units[index];
                return Card(
                  color: cardColor, // 👈 الكرت يأخذ لون الكتاب الديناميكي
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      // خلفية دائرية شفافة تتكيف مع لون الخط
                      backgroundColor: textColor.withOpacity(0.15),
                      child: Text(
                        '${unit.order}',
                        style: TextStyle(
                          color: textColor, // 👈 الرقم بلون متباين
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      unit.title,
                      style: TextStyle(
                        color: textColor, // 👈 العنوان بلون متباين
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${unit.pages.length} Pages',
                      style: TextStyle(
                        color: subtextColor, // 👈 الوصف بلون متباين
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: textColor, // 👈 السهم بلون متباين
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonScreen(unit: unit),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
