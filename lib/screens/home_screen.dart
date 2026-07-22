import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/local_data_service.dart';
import '../utils/string_extensions.dart'; // 👈 تم الاستيراد لاستخدام toColor()
import '../main.dart'; // لاستدعاء themeNotifier
import 'units_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<BookModel>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = LocalDataService().loadCurriculum();
  }

  @override
  Widget build(BuildContext context) {
    // فحص هل الوضع الحالي داكن أم فاتح؟
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'The Best',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
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
      body: FutureBuilder<List<BookModel>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No books found!',
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 18,
                ),
              ),
            );
          }

          final books = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio:
                  0.72, // 👈 تعديل النسبة لاستيعاب الغلاف والعنوان ببراح
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];

              // 👈 تحويل لون الكتاب الديناميكي من JSON
              final bookThemeColor = book.color.toColor();

              // 👈 تحديد لون النص المريح للعين تلقائياً لعنوان الكتاب
              final titleTextColor = bookThemeColor.computeLuminance() > 0.5
                  ? Colors.black87
                  : Colors.white;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // 🌟 1. إلغاء الحدود الخضراء الثابتة وإضافة ظل مشع بلون الكتاب نفسه
                  boxShadow: [
                    BoxShadow(
                      color: bookThemeColor.withOpacity(isDark ? 0.35 : 0.22),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    color: Theme.of(context).cardColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UnitsScreen(book: book),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 🖼️ 2. عرض صورة الغلاف
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  book.coverPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: bookThemeColor.withOpacity(0.15),
                                        child: Icon(
                                          Icons.menu_book_rounded,
                                          size: 50,
                                          color: bookThemeColor,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),

                          // 🏷️ 3. شريط عنوان الكتاب أسفل الغلاف بلون الكتاب المخصص
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(color: bookThemeColor),
                            child: Text(
                              book.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: titleTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
