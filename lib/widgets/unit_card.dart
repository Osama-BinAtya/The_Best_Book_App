import 'package:flutter/material.dart';
import 'package:the_best_books_app/utils/string_extensions.dart'; // 👈 استيراد الـ Extension

class UnitCard extends StatelessWidget {
  final String unitNumber;
  final String unitTitle;
  final String bookColorHex;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.unitNumber,
    required this.unitTitle,
    required this.bookColorHex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 💡 تحويل النص إلى لون باستخدام الـ Extension
    final Color cardColor = bookColorHex.toColor();

    // 💡 تحديد لون النص والأيقونات تلقائياً حسب درجة سطوع لون الكتاب
    final bool isLightBg = cardColor.computeLuminance() > 0.5;
    final Color contentColor = isLightBg ? Colors.black87 : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // دائرة رقم الوحدة
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: contentColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      unitNumber,
                      style: TextStyle(
                        color: contentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // عنوان الوحدة
                Expanded(
                  child: Text(
                    unitTitle,
                    style: TextStyle(
                      color: contentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // سهم الدخول
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: contentColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
