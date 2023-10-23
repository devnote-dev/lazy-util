import 'exceptions.dart';
import 'node.dart';

class Interpreter {
  // Map<String, Expression> _scope;

  // Interpreter(this._scope);

  Expression interpret(List<Expression> exprs) {
    late Expression result;

    for (final expr in exprs) {
      result = _interpret(expr);
    }

    return result;
  }

  Expression _interpret(Expression expr) => switch (expr) {
        Prefix ex => _interpretPrefix(ex),
        Infix ex => _interpretInfix(ex),
        _ => expr,
      };

  Expression _interpretPrefix(Prefix expr) {
    var value = _interpret(expr.expr);
    if (value is! Number) {
      throw InterpretException.mismatch('prefix', value.type());
    }

    var result = switch (expr.prefix) {
      Operator.subtract => Number(-value.value),
      _ => throw 'unreachable',
    };

    return result;
  }

  Expression _interpretInfix(Infix expr) {
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
