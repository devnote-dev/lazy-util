import 'exceptions.dart';
import 'node.dart';

class Interpreter {
  // Map<String, Node> _scope;

  // Interpreter(this._scope);

  Node interpret(List<Node> nodes) {
    late Node result;

    for (final node in nodes) {
      result = _interpret(node);
    }

    return result;
  }

  Node _interpret(Node expr) => switch (expr) {
        Prefix ex => _interpretPrefix(ex),
        Infix ex => _interpretInfix(ex),
        _ => expr,
      };

  Node _interpretPrefix(Prefix expr) {
    var value = _interpret(expr.expr);
    if (value is! Number) {
      throw InterpretException.mismatch('prefix', value.type());
    }

    return switch (expr.prefix) {
      Operator.subtract => Number(-value.value),
      _ => throw 'unreachable',
    };
  }

  Node _interpretInfix(Infix expr) {
    var left = _interpret(expr.left);
    if (left is! Number) {
      throw InterpretException.mismatch('infix', left.type());
    }

    var right = _interpret(expr.right);
    if (right is! Number) {
      throw InterpretException.mismatch('infix', right.type());
    }

    return switch (expr.operator) {
      Operator.add => Number(left.value + right.value),
      Operator.subtract => Number(left.value - right.value),
      Operator.multiply => Number(left.value * right.value),
      Operator.divide => Number(left.value / right.value),
      _ => throw 'unreachable',
    };
  }
}
