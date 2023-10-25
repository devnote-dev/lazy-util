import 'package:args/command_runner.dart';

import '../math/exceptions.dart';
import '../math/interpreter.dart';
import '../math/lexer.dart';
import '../math/parser.dart';
import '../math/visitor.dart';

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
    final parser = Parser(tokens);

    try {
      var nodes = parser.parse();
      nodes = Visitor(nodes).visit();
      print(Interpreter().interpret(nodes));
    } on MathException catch (e) {
      print('Error: ${e.message}');
      return 1;
    }

    return 0;
  }
}
