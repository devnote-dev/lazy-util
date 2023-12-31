import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lazy/lazy.dart';

Future<Never> main(List<String> args) async {
  try {
    exit(await run(args));
  } on UsageException catch (e) {
    print(e.message);
    exit(1);
  }
}
