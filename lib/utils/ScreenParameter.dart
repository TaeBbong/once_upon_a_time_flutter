import 'package:once_upon_a_time_app/models/Book.dart';

class ScreenParameter {
  final Book book;
  final int currentPage;
  final List<String> help;

  ScreenParameter(this.book, this.currentPage, this.help);
}
