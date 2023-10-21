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

enum Operator {
  add,
  subtract,
  multiply,
  divide,
  tilde;

  static Operator parse(TokenKind kind) {
    return switch (kind) {
      TokenKind.plus => add,
      TokenKind.minus => subtract,
      TokenKind.asterisk => multiply,
      TokenKind.slash => divide,
      _ => throw ArgumentError('Invalid operator: $kind'),
    };
  }
}

class Prefix extends Expression {
  final Operator prefix;
  final Expression expr;

  Prefix(this.prefix, this.expr);
}

class Infix extends Expression {
  final Expression left;
  final Operator operator;
  final Expression right;

  Infix(this.left, this.operator, this.right);
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
