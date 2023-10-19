import 'package:lazy/math/reader.dart';

enum TokenKind {
  number,
  operator,
  metric,
  leftParen,
  rightParen,
  illegal,
}

extension on TokenKind {
  String format() {
    return switch (this) {
      TokenKind.number => 'number',
      TokenKind.operator => 'operator',
      TokenKind.metric => 'metric',
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
    if (value != null) buffer.writeAll([', ', value]);
    buffer.write(')');

    return buffer.toString();
  }
}

class Lexer {
  late Reader reader;

  Lexer(String input) {
    reader = Reader(input);
  }

  List<Token> read() {
    final tokens = <Token>[];

    while (true) {
      if (!reader.remaining()) break;
      var next = reader.next()!;

      // '\n' && ' '
      if (next == 10 || next == 32) continue;
      if (next >= 48 && next <= 57) {
        tokens.add(_readNumber(reader.pos));
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
      var next = reader.next()!;
      if (next >= 48 && next <= 57) continue;

      stop = reader.pos;
      reader.previous();
      break;
    }

    return Token(TokenKind.number, reader.getRange(start, stop));
  }
}
