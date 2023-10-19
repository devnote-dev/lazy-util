import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import '../commands/math.dart';

class MainCommand extends CommandRunner<int> {
  MainCommand() : super('lazy', 'Lazy utility commands') {
    addCommand(MathCommand());
  }

  @override
  Future<int> runCommand(ArgResults topLevelResults) async {
    return await super.runCommand(topLevelResults) ?? 0;
  }
}
