import 'lexer.dart' show TokenKind;

sealed class Node {
  String type();
}

sealed class Expression extends Node {}

class Number implements Expression {
  final double value;

  Number(this.value);

  @override
  String type() => 'number';

  @override
  String toString() => value.toString();
}

class Identifier implements Expression {
  final String value;

  Identifier(this.value);

  @override
  String type() => 'identifier';

  @override
  String toString() => value.toString();
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

class Prefix implements Expression {
  final Operator prefix;
  final Expression expr;

  Prefix(this.prefix, this.expr);

  @override
  String type() => 'prefix';

  @override
  String toString() => '$prefix$expr';
}

class Infix implements Expression {
  final Expression left;
  final Operator operator;
  final Expression right;

  Infix(this.left, this.operator, this.right);

  @override
  String type() => 'infix';

  @override
  String toString() => '$left $operator $right';
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
