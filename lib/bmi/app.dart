import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/result.dart';
import 'package:flutter_practice/bmi/top.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) {
          final routes = <String, WidgetBuilder>{
            Result.routeName: (context) => const Result(),
          };
          final builder = routes[settings.name]!;
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
        home: const Top());
  }
}
