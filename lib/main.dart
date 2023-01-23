import 'package:flutter/material.dart';
import 'package:flutter_practice/select.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'count.dart';
import 'todo.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

void main() {
  runApp(const ProviderScope(child: Select()));
}
