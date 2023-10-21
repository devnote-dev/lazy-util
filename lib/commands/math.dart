import 'package:args/command_runner.dart';

import '../math/lexer.dart';
import '../math/parser.dart';

class MathCommand extends Command<int> {
  @override
  final name = 'math';

  @override
  final description = 'Evaluates mathematical expressions';

  @override
  int run() {
    if (argResults!.arguments.isEmpty) {
      print('No arguments provided.');
      return 1;
    }

    final lexer = Lexer(argResults!.arguments.join());
    final tokens = lexer.read();
    print(tokens);

    final parser = Parser(tokens);
    try {
      print(parser.parse());
    } on ParseException catch (e) {
      print('Error: ${e.message}');
      return 1;
    }

    return 0;
  }
}
