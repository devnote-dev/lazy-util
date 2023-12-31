import 'commands/main.dart';

export 'math/exceptions.dart';
export 'math/interpreter.dart';
export 'math/lexer.dart';
export 'math/node.dart';
export 'math/parser.dart';
export 'math/visitor.dart';
export 'units/bytes.dart';

Future<int> run(List<String> args) => MainCommand().run(args) as Future<int>;
