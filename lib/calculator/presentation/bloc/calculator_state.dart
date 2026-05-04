part of 'calculator_bloc.dart';

sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {}

final class CalculatorUpdated extends CalculatorState {
  final String expression;
  final String result;

  CalculatorUpdated({required this.expression, required this.result});

  CalculatorUpdated copyWith({String? expression, String? result}) {
    return CalculatorUpdated(
      expression: expression ?? this.expression,
      result: result ?? this.result,
    );
  }
}
