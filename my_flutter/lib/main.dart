import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/decision_service.dart';
import 'screens/home_screen.dart';

void main() => runApp(const TieBreakerAPP());
class TieBreakerAPP extends StatelessWidget {
  const TieBreakerAPP({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: impliment build

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DecisionService()),
    ],
    child: MaterialApp(
      title: 'TieBreakerAPP',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurpleAccent),
      home: const HomeScreen()
    ),

    );
  }

}
