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
  prefix,
}
