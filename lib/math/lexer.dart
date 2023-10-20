enum TokenKind {
  number,
  ident,
  operator,
  leftParen,
  rightParen,
  illegal;

  @override
  String toString() {
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
  final TokenKind kind;
  final String? value;

  Token(this.kind, [this.value]);

  @override
  bool operator ==(Object other) {
    if (other is! Token) return false;
    return kind == other.kind && value == other.value;
  }

  @override
  int get hashCode => kind.hashCode ^ value.hashCode;

  @override
  String toString() {
    final buffer = StringBuffer('Token(')..write(kind);

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

  late final List<int> _input;
  int _pos = -1;

  Lexer(String input) {
    _input = input.runes.toList()..add(0);
  }

  List<Token> read() {
    final tokens = <Token>[];

    while (_remaining()) {
      var next = _next();

      // '\n' && ' '
      if (next == 10 || next == 32) continue;
      if (next >= 48 && next <= 57) {
        tokens.add(_readNumber(_pos));
        continue;
      }

      if (next >= 65 && next <= 90 || next >= 97 && next <= 122) {
        tokens.add(_readIdent(_pos));
        continue;
      }

      if (operators.contains(next)) {
        tokens.add(Token(TokenKind.operator, _currentString()));
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

      tokens.add(Token(TokenKind.illegal, _currentString()));
    }

    return tokens;
  }

  int _next() => _input[++_pos];
  void _previous() => --_pos;
  bool _remaining() => _pos + 1 < _input.length;

  String _currentString() => String.fromCharCode(_input[_pos]);
  String _getRange(int start, int stop) =>
      String.fromCharCodes(_input.sublist(start, stop));

  Token _readNumber(int start) {
    var stop = start + 1;

    while (_remaining()) {
      var next = _next();
      if (next >= 48 && next <= 57) continue;

      stop = _pos;
      _previous();
      break;
    }

    return Token(TokenKind.number, _getRange(start, stop));
  }

  Token _readIdent(int start) {
    var stop = start + 1;

    while (_remaining()) {
      var next = _next();
      if (next >= 65 && next <= 90 || next >= 97 && next <= 122) continue;

      stop = _pos;
      _previous();
      break;
    }

    return Token(TokenKind.ident, _getRange(start, stop));
  }
}
