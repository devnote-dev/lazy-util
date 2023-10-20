import 'commands/main.dart';

export 'math/lexer.dart';

Future<int> run(List<String> args) => MainCommand().run(args) as Future<int>;
