import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:lazy/lazy.dart';

Future<void> main(List<String> args) async {
  try {
    await run(args);
  } on UsageException catch (e) {
    print(e.message);
    exit(1);
  }

  exit(0);
}
