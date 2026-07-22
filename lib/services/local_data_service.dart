import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/book_model.dart';

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
      print("Error loading local JSON curriculum: $error");
      return [];
    }
  }
}
