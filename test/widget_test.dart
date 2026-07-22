import 'package:flutter_test/flutter_test.dart';
import 'package:the_best_books_app/models/book_model.dart';

void main() {
  test(
    'BookModel keeps a details path and empty units when content is loaded separately',
    () {
      final book = BookModel.fromJson({
        'id': 'book_01',
        'title': 'Test Book',
        'color': '#F97316',
        'coverPath': 'assets/images/book_covers/test.png',
        'detailsPath': 'assets/json/books/book_01.json',
      });

      expect(book.id, 'book_01');
      expect(book.detailsPath, 'assets/json/books/book_01.json');
      expect(book.units, isEmpty);
    },
  );
}
