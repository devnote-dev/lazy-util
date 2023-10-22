class ParseException implements Exception {
  final String message;

  ParseException(this.message);
}

class VisitorException implements Exception {
  final String message;

  VisitorException(this.message);
}
