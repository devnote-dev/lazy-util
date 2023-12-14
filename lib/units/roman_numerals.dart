String toNumeral(int number) {
  return switch (number) {
    >= 1000 => 'M' * (number ~/ 1000) + toNumeral(number % 1000),
    >= 500 => 'D' * (number ~/ 500) + toNumeral(number % 500),
    >= 100 => 'C' * (number ~/ 100) + toNumeral(number % 100),
    >= 50 => 'L' * (number ~/ 50) + toNumeral(number % 50),
    >= 10 => 'X' * (number ~/ 10) + toNumeral(number % 10),
    >= 5 => 'V' * (number ~/ 5) + toNumeral(number % 5),
    == 4 => 'IV${toNumeral(number - 4)}',
    == 3 => 'III${toNumeral(number - 3)}',
    == 2 => 'II${toNumeral(number - 2)}',
    == 1 => 'I${toNumeral(number - 1)}',
    == 0 => '',
    _ => throw ArgumentError('Invalid integer: $number'),
  };
}
