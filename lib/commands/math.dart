import 'package:args/command_runner.dart';

import '../math/lexer.dart';

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
    print(lexer.read());

    return 0;
  }
}
