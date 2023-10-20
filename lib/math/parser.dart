import 'lexer.dart';
import 'node.dart';

class Parser {
  final List<Token> input;
  int _pos = -1;

  Parser(this.input);

  List<Statement> parse() {
    final stmts = <Statement>[];

    while (_remaining()) {
      stmts.add(_parseStatement(_next()));
    }

    return stmts;
  }

  Statement _parseStatement(Token token) {
    return switch (token.kind) {
      TokenKind.illegal => throw ParseError("Illegal token '$token' found"),
      _ => _parseExpressionStatement(token),
    };
  }

  Statement _parseExpressionStatement(Token token) {
    return Statement(); // TODO!
  }

  Token _next() => input[++_pos];
  // void _previous() => --_pos;
  bool _remaining() => _pos + 1 < input.length;
}

class ParseError extends Error {
  final String message;

  ParseError(this.message) : super();
}
