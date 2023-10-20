import 'package:lazy/lazy.dart';
import 'package:test/test.dart';

void main() {
  test('empty input', () {
    var lexer = Lexer('');
    expect(lexer.read(), []);
  });

  test('random numbers', () {
    var lexer = Lexer('123 456 789');
    expect(
        lexer.read(),
        equals([
          Token(TokenKind.number, '123'),
          Token(TokenKind.number, '456'),
          Token(TokenKind.number, '789')
        ]));
  });

  test('random identifiers', () {
    var lexer = Lexer('foo bar baz');
    expect(
        lexer.read(),
        equals([
          Token(TokenKind.ident, 'foo'),
          Token(TokenKind.ident, 'bar'),
          Token(TokenKind.ident, 'baz'),
        ]));
  });

  test('some operators and parentheses', () {
    var lexer = Lexer('+ -(*) /');
    expect(
        lexer.read(),
        equals([
          Token(TokenKind.plus),
          Token(TokenKind.minus),
          Token(TokenKind.leftParen),
          Token(TokenKind.asterisk),
          Token(TokenKind.rightParen),
          Token(TokenKind.slash),
        ]));
  });
}
