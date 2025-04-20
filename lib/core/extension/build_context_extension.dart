import 'package:flutter/material.dart';
import 'package:fluttertuner/feature/config/config.dart';
import 'package:fluttertuner/feature/config/dependency.dart';

extension BuildContextExtension on BuildContext {
  T dep<T extends Dependency>() => di.get<T>();
}
