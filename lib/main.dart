import 'package:flutter/material.dart';
import 'core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(AppWidget());
}
