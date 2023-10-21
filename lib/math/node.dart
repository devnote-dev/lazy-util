import 'lexer.dart' show TokenKind;

sealed class Node {}

class Statement extends Node {}

class Expression extends Node {}

class ExpressionStatement extends Statement {
  final Expression expr;

  ExpressionStatement(this.expr);

  @override
  String toString() => expr.toString();
}

class Number extends Expression {
  final double value;

  Number(this.value);

  @override
  String toString() => 'Number($value)';
}

class Identifier extends Expression {
  final String value;

  Identifier(this.value);

  @override
  String toString() => 'Identifier($value)';
}

enum Operator {
  add,
  subtract,
  multiply,
  divide,
  tilde;

  static Operator parse(TokenKind kind) => switch (kind) {
        TokenKind.plus => add,
        TokenKind.minus => subtract,
        TokenKind.asterisk => multiply,
        TokenKind.slash => divide,
        _ => throw ArgumentError('Invalid operator: $kind'),
      };

  @override
  String toString() => switch (this) {
        add => '+',
        subtract => '-',
        multiply => '*',
        divide => '/',
        tilde => '~',
      };
}

class Prefix extends Expression {
  final Operator prefix;
  final Expression expr;

  Prefix(this.prefix, this.expr);

  @override
  String toString() => 'Prefix($prefix$expr)';
}

class Infix extends Expression {
  final Expression left;
  final Operator operator;
  final Expression right;

  Infix(this.left, this.operator, this.right);

  @override
  String toString() => 'Infix($left $operator $right)';
}

enum Precedence {
  lowest,
  // equals,
  lessGreater,
  sum,
  product,
  prefix;

  static Precedence parse(TokenKind kind) => switch (kind) {
        TokenKind.plus || TokenKind.minus => sum,
        TokenKind.asterisk || TokenKind.slash => product,
        _ => lowest,
      };

  bool operator >=(Precedence other) => index >= other.index;
}
