import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');
final _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
