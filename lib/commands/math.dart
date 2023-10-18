import 'package:args/command_runner.dart';

class MathCommand extends Command<int> {
  @override
  final name = 'math';

  @override
  final description = 'Evaluates mathematical expressions';

  @override
  int run() {
    print(argResults?.arguments);

    return 0;
  }
}
