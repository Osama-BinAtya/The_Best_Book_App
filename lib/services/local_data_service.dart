import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';
import '../models/page_model.dart';
import '../models/unit_model.dart';

class LocalDataService {
  static final LocalDataService _instance = LocalDataService._internal();
  factory LocalDataService() => _instance;
  LocalDataService._internal();

  Future<List<BookModel>> loadCurriculum() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/curriculum.json',
      );
      final Map<String, dynamic> decodedData = json.decode(jsonString);
      final List<dynamic> booksList = decodedData['books'] ?? [];

      return booksList
          .map(
            (bookJson) => BookModel.fromJson(bookJson as Map<String, dynamic>),
          )
          .toList();
    } catch (error) {
      print('Error loading local JSON curriculum: $error');
      return [];
    }
  }

  Future<BookModel> loadBookDetails(BookModel book) async {
    if (book.detailsPath == null || book.detailsPath!.isEmpty) {
      return book;
    }

    try {
      final String jsonString = await rootBundle.loadString(book.detailsPath!);
      final Map<String, dynamic> decodedData = json.decode(jsonString);
      final List<dynamic> unitsList = decodedData['units'] ?? [];

      final loadedUnits = <UnitModel>[];
      for (final unitJson in unitsList) {
        final unitMap = unitJson as Map<String, dynamic>;
        final String? filePath = unitMap['file'] as String?;

        if (filePath != null && filePath.isNotEmpty) {
          final String unitJsonString = await rootBundle.loadString(filePath);
          final Map<String, dynamic> unitData = json.decode(unitJsonString);
          loadedUnits.add(
            UnitModel(
              id: unitData['id'] ?? unitMap['id'] ?? '',
              title: unitData['title'] ?? unitMap['title'] ?? '',
              order: unitData['order'] ?? unitMap['order'] ?? 0,
              filePath: filePath,
              pages: (unitData['pages'] as List<dynamic>? ?? [])
                  .map(
                    (page) => PageModel.fromJson(page as Map<String, dynamic>),
                  )
                  .toList(),
            ),
          );
        } else {
          loadedUnits.add(UnitModel.fromJson(unitMap));
        }
      }

      return BookModel(
        id: book.id,
        title: book.title,
        color: book.color,
        coverPath: book.coverPath,
        detailsPath: book.detailsPath,
        units: loadedUnits,
      );
    } catch (error) {
      print('Error loading book details for ${book.id}: $error');
      return book;
    }
  }
}
