import 'exceptions.dart' show VisitorException;
import 'node.dart';
import '../units/bytes.dart';

class Visitor {
  final List<Statement> _input;
  int _pos = -1;

  Visitor(this._input);

  List<Statement> visit() {
    final stmts = <Statement>[];

    while (_remaining()) {
      var stmt = _next() as ExpressionStatement;
      stmts.add(ExpressionStatement(_visitExpression(stmt.expr)));
    }

    return stmts;
  }

  Expression _visitExpression(Expression expr) => switch (expr) {
        Number ex => _visitNumber(ex),
        Identifier ex => _visitIdentifier(ex),
        Prefix ex => _visitPrefix(ex),
        Infix ex => _visitInfix(ex),
        _ => throw 'unreachable',
      };

  Expression _visitNumber(Number expr) {
    var peek = _peek();
    if (peek is Identifier) {
      ++_pos;
      var value = _visitIdentifier(peek as Identifier);

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
    var value = _visitExpression(expr.expr);

    return Prefix(expr.prefix, value);
  }

  Expression _visitInfix(Infix expr) {
    var left = _visitExpression(expr.left);
    var right = _visitExpression(expr.right);

    return Infix(left, expr.operator, right);
  }

  Statement _next() => _input[++_pos];
  Statement? _peek() => _remaining() ? _input[_pos + 1] : null;
  bool _remaining() => _pos + 1 < _input.length;
}
