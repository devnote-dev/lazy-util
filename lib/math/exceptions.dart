sealed class MathException implements Exception {
  String get message;
}

final class ParseException implements MathException {
  @override
  final String message;

  ParseException(this.message);
}

final class VisitorException implements MathException {
  @override
  final String message;

  VisitorException(this.message);
}

final class InterpretException implements MathException {
  @override
  final String message;

  static InterpretException mismatch(String node, String got) =>
      InterpretException('Expected type number for $node; got $got');

  InterpretException(this.message);
}
