import 'exceptions.dart' show VisitorException;
import 'node.dart';
import '../units/bytes.dart';

class Visitor {
  final List<Node> _input;
  int _pos = -1;

  Visitor(this._input);

  List<Node> visit() {
    final nodes = <Node>[];

    while (_remaining()) {
      nodes.add(_visit(_next()));
    }

    return nodes;
  }

  Node _visit(Node expr) => switch (expr) {
        Number ex => _visitNumber(ex),
        Identifier ex => _visitIdentifier(ex),
        Prefix ex => _visitPrefix(ex),
        Infix ex => _visitInfix(ex),
      };

  Node _visitNumber(Number expr) {
    var peek = _peek();
    if (peek is Identifier) {
      ++_pos;
      var value = _visitIdentifier(peek);

      return Infix(expr, Operator.multiply, value);
    } else {
      return expr;
    }
  }

  Node _visitIdentifier(Identifier expr) {
    var size = ByteSize.parse(expr.value);
    if (size == null) {
      throw VisitorException('Undefined variable: ${expr.value}');
    }

    return expr;
  }

  Node _visitPrefix(Prefix expr) {
    var value = _visit(expr.expr);

    return Prefix(expr.prefix, value);
  }

  Node _visitInfix(Infix expr) {
    var left = _visit(expr.left);
    var right = _visit(expr.right);

    return Infix(left, expr.operator, right);
  }

  Node _next() => _input[++_pos];
  Node? _peek() => _remaining() ? _input[_pos + 1] : null;
  bool _remaining() => _pos + 1 < _input.length;
}
