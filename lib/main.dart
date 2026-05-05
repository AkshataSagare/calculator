import 'package:calculator/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:calculator/calculator/presentation/screens/calculator_screen.dart';
import 'package:calculator/calculator/presentation/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => CalculatorBloc(SharedPreferencesService())..add(LoadData()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}
