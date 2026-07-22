// هذا الكلاس يمثل الكتاب الرئيسي ويحتوي على غلافه وقائمة الوحدات التابعة له List<UnitModel>

import 'unit_model.dart';

class BookModel {
  final String id;
  final String title;
  final String color;
  final String coverPath;
  final String? detailsPath;
  final List<UnitModel> units;

  BookModel({
    required this.id,
    required this.title,
    required this.color,
    required this.coverPath,
    this.detailsPath,
    this.units = const [],
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final rawUnits = json['units'] as List<dynamic>? ?? [];
    return BookModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      color: json['color'] ?? '#6B0282',
      coverPath: json['coverPath'] ?? '',
      detailsPath: json['detailsPath'] as String?,
      units: rawUnits
          .map((unit) => UnitModel.fromJson(unit as Map<String, dynamic>))
          .toList(),
    );
  }
}
