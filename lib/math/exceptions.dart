class ParseException implements Exception {
  final String message;

  ParseException(this.message);
}

class VisitorException implements Exception {
  final String message;

  VisitorException(this.message);
}

class InterpretException implements Exception {
  final String message;

  static InterpretException mismatch(String node, String got) =>
      InterpretException('Expected type number for $node; got $got');

  InterpretException(this.message);
}
