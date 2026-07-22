// هذا الكلاس يمثل الكتاب الرئيسي ويحتوي على غلافه وقائمة الوحدات التابعة له List<UnitModel>

import 'unit_model.dart';

class BookModel {
  final String id;
  final String title;
  final String color; // 👈 1. إضافة متغير اللون
  final String coverPath;
  final List<UnitModel> units;

  BookModel({
    required this.id,
    required this.title,
    required this.color, // 👈 2. إضافته إلى المُنشئ (Constructor)
    required this.coverPath,
    required this.units,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final rawUnits = json['units'] as List<dynamic>? ?? [];
    return BookModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      color:
          json['color'] ??
          '#6B0282', // 👈 3. قراءة اللون من الـ JSON (مع لون بنفسجي احترازي)
      coverPath: json['coverPath'] ?? '',
      units: rawUnits
          .map((unit) => UnitModel.fromJson(unit as Map<String, dynamic>))
          .toList(),
    );
  }
}
