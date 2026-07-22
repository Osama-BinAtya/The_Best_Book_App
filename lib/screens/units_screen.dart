import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../main.dart';
import '../services/local_data_service.dart';
import '../utils/string_extensions.dart';
import 'lesson_screen.dart';

class UnitsScreen extends StatefulWidget {
  final BookModel book;

  const UnitsScreen({super.key, required this.book});

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  late Future<BookModel> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = LocalDataService().loadBookDetails(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = widget.book.color.toColor();
    final bool isLightBg = cardColor.computeLuminance() > 0.5;
    final Color textColor = isLightBg ? const Color(0xFF0F172A) : Colors.white;
    final Color subtextColor = isLightBg ? Colors.black54 : Colors.white70;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.book.title),
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
      body: FutureBuilder<BookModel>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          final loadedBook = snapshot.data ?? widget.book;
          if (loadedBook.units.isEmpty) {
            return Center(
              child: Text(
                'No units found',
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: loadedBook.units.length,
            itemBuilder: (context, index) {
              final unit = loadedBook.units[index];
              return Card(
                color: cardColor,
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
                    backgroundColor: textColor.withOpacity(0.15),
                    child: Text(
                      '${unit.order}',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    unit.title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    '${unit.pages.length} Pages',
                    style: TextStyle(color: subtextColor),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: textColor,
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
          );
        },
      ),
    );
  }
}
