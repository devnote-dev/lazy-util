import 'lexer.dart' show TokenKind;

sealed class Node {}

class Statement extends Node {}

class Expression extends Node {}

class ExpressionStatement extends Statement {
  final Expression expr;

  ExpressionStatement(this.expr);
}

class Number extends Expression {
  final double value;

  Number(this.value);
}

class Identifier extends Expression {
  final String value;

  Identifier(this.value);
}

enum PrefixKind {
  minus,
  tilde;

  static PrefixKind parse(TokenKind kind) {
    return switch (kind) {
      TokenKind.minus => minus,
      // TokenKind.tilde => tilde,
      _ => throw ArgumentError('Invalid prefix operator: $kind'),
    };
  }
}

class Prefix extends Expression {
  final PrefixKind prefix;
  final Expression expr;

  Prefix(this.prefix, this.expr);
}

enum OperatorKind {
  add,
  subtract,
  multiply,
  divide;

  static OperatorKind parse(String value) {
    return switch (value) {
      '+' => add,
      '-' => subtract,
      '*' => multiply,
      '/' => divide,
      _ => throw ArgumentError('Invalid operator: $value'),
    };
  }
}

class Operator extends Expression {
  final Expression left;
  final OperatorKind kind;
  final Expression right;

  Operator(this.left, this.kind, this.right);
}

enum Precedence {
  lowest,
  // equals,
  lessGreater,
  sum,
  product,
  prefix;

  static Precedence parse(TokenKind kind) {
    return switch (kind) {
      TokenKind.plus || TokenKind.minus => sum,
      TokenKind.asterisk || TokenKind.slash => product,
      _ => lowest,
    };
  }

  bool operator >=(Precedence other) {
    return this >= other;
  }
}
