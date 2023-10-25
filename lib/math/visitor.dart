import 'exceptions.dart' show VisitorException;
import 'node.dart';
import '../units/bytes.dart';

class Visitor {
  final List<Expression> _input;
  int _pos = -1;

  Visitor(this._input);

  List<Expression> visit() {
    final exprs = <Expression>[];

    while (_remaining()) {
      exprs.add(_visit(_next()));
    }

    return exprs;
  }

  Expression _visit(Expression expr) => switch (expr) {
        Number ex => _visitNumber(ex),
        Identifier ex => _visitIdentifier(ex),
        Prefix ex => _visitPrefix(ex),
        Infix ex => _visitInfix(ex),
      };

  Expression _visitNumber(Number expr) {
    var peek = _peek();
    if (peek is Identifier) {
      ++_pos;
      var value = _visitIdentifier(peek);

      return Infix(expr, Operator.multiply, value);
    } else {
      return expr;
    }
  }

  Expression _visitIdentifier(Identifier expr) {
    var size = ByteSize.parse(expr.value);
    if (size == null) {
      throw VisitorException('Undefined variable: ${expr.value}');
    }

    return expr;
  }

  Expression _visitPrefix(Prefix expr) {
    var value = _visit(expr.expr);

    return Prefix(expr.prefix, value);
  }

  Expression _visitInfix(Infix expr) {
    var left = _visit(expr.left);
    var right = _visit(expr.right);

    return Infix(left, expr.operator, right);
  }

  Expression _next() => _input[++_pos];
  Expression? _peek() => _remaining() ? _input[_pos + 1] : null;
  bool _remaining() => _pos + 1 < _input.length;
}
