import 'exceptions.dart' show ParseException;
import 'lexer.dart';
import 'node.dart';

class Parser {
  final List<Token> input;
  int _pos = 0;

  Parser(this.input);

  List<Expression> parse() {
    final exprs = <Expression>[];

    while (_remaining()) {
      exprs.add(_parseExpression(Precedence.lowest));
    }

    return exprs;
  }

  Expression _parseExpression(Precedence prec) {
    var left = _parsePrefixFn(_current);
    if (left == null) {
      throw ParseException('Cannot parse prefix for type $_current');
    }

    while (true) {
      var peek = _peek();
      // if (peek == null) throw ParseException('Unexpected End of File');
      if (peek == null) break;
      if (prec >= Precedence.parse(peek.kind)) break;

      var infix = _parseInfixFn(peek, left!);
      if (infix == null) break;
      left = infix;
    }

    return left!;
  }

  Expression? _parsePrefixFn(Token token) => switch (token.kind) {
        TokenKind.number => _parseNumber(token),
        TokenKind.ident => Identifier(token.value!),
        TokenKind.minus => _parsePrefix(token),
        TokenKind.leftParen => _parseGroupedExpression(),
        TokenKind.illegal => throw ParseException(token.value!),
        _ => null,
      };

  Expression _parsePrefix(Token token) {
    var op = Operator.parse(token.kind);
    ++_pos;
    var expr = _parseExpression(Precedence.prefix);

    return Prefix(op, expr);
  }

  Expression? _parseInfixFn(Token token, Expression expr) =>
      switch (token.kind) {
        TokenKind.plus ||
        TokenKind.minus ||
        TokenKind.asterisk ||
        TokenKind.slash =>
          _parseInfix(expr),
        TokenKind.leftParen => _parseGroupedExpression(),
        _ => null,
      };

  Expression _parseInfix(Expression left) {
    var op = Operator.parse(_next().kind);
    ++_pos;
    var prec = Precedence.parse(_current.kind);
    var right = _parseExpression(prec);

    return Infix(left, op, right);
  }

  Expression _parseGroupedExpression() {
    ++_pos;
    var expr = _parseExpression(Precedence.lowest);
    _expectNext(TokenKind.rightParen);

    return expr;
  }

  Expression _parseNumber(Token token) {
    var value = double.parse(token.value!);
    var peek = _peek();

    if (peek != null && peek.kind == TokenKind.ident) {
      ++_pos;
      return Infix(Number(value), Operator.multiply, Identifier(peek.value!));
    }

    return Number(value);
  }

  void _expectNext(TokenKind kind) {
    var token = _next();
    if (token.kind != kind) {
      throw ParseException('Expected token $kind; got ${token.kind}');
    }
  }

  Token get _current => input[_pos];
  Token _next() => input[++_pos];
  Token? _peek() => _remaining() ? input[_pos + 1] : null;
  bool _remaining() => _pos + 1 < input.length;
}
