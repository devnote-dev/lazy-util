import 'package:args/command_runner.dart';

import '../math/exceptions.dart';
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
    print(tokens);

    final parser = Parser(tokens);
    try {
      final exprs = parser.parse();
      print(Visitor(exprs).visit());
    } on ParseException catch (e) {
      print('Error: ${e.message}');
      return 1;
    } on VisitorException catch (e) {
      print('Error: ${e.message}');
      return 1;
    }

    return 0;
  }
}
