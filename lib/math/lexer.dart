import 'package:lazy/math/reader.dart';

enum TokenKind {
  number,
  ident,
  operator,
  leftParen,
  rightParen,
  illegal,
}

extension on TokenKind {
  String format() {
    return switch (this) {
      TokenKind.number => 'number',
      TokenKind.ident => 'ident',
      TokenKind.operator => 'operator',
      TokenKind.leftParen => 'leftParen',
      TokenKind.rightParen => 'rightParen',
      TokenKind.illegal => 'illegal',
    };
  }
}

class Token {
  TokenKind kind;
  String? value;

  Token(this.kind, [this.value]);

  @override
  String toString() {
    final buffer = StringBuffer('Token(')..write(kind.format());
    if (value != null) {
      buffer.write(', ');
      if (kind == TokenKind.ident) buffer.write('"');
      buffer.write(value);
      if (kind == TokenKind.ident) buffer.write('"');
    }
    buffer.write(')');

    return buffer.toString();
  }
}

class Lexer {
  // '*' | '+' | '-' | '/'
  final operators = const [42, 43, 45, 47];

  late Reader reader;

  Lexer(String input) {
    reader = Reader(input);
  }

  List<Token> read() {
    final tokens = <Token>[];

    while (reader.remaining()) {
      var next = reader.next();

      // '\n' && ' '
      if (next == 10 || next == 32) continue;
      if (next >= 48 && next <= 57) {
        tokens.add(_readNumber(reader.pos));
        continue;
      }

      if (next >= 65 && next <= 90 || next >= 97 && next <= 122) {
        tokens.add(_readIdent(reader.pos));
        continue;
      }

      if (operators.contains(next)) {
        tokens.add(Token(TokenKind.operator, reader.currentString));
        continue;
      }

      if (next == 40) {
        tokens.add(Token(TokenKind.leftParen));
        continue;
      }

      if (next == 41) {
        tokens.add(Token(TokenKind.rightParen));
        continue;
      }
      if (next == 0) break;

      tokens.add(Token(TokenKind.illegal, reader.currentString));
    }

    return tokens;
  }

  Token _readNumber(int start) {
    var stop = start + 1;

    while (reader.remaining()) {
      var next = reader.next();
      if (next >= 48 && next <= 57) continue;

      stop = reader.pos;
      reader.previous();
      break;
    }

    return Token(TokenKind.number, reader.getRange(start, stop));
  }

  Token _readIdent(int start) {
    var stop = start + 1;

    while (reader.remaining()) {
      var next = reader.next();
      if (next >= 65 && next <= 90 || next >= 97 && next <= 122) continue;

      stop = reader.pos;
      reader.previous();
      break;
    }

    return Token(TokenKind.ident, reader.getRange(start, stop));
  }
}
