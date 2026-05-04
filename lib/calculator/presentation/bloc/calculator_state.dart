part of 'calculator_bloc.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

final class CalculatorInitial extends CalculatorState {}

final class CalculatorUpdated extends CalculatorState {
  final String expression;
  final String result;
  final bool isResultMode;

  const CalculatorUpdated({
    required this.expression,
    required this.result,
    this.isResultMode = false,
  });

  @override
  List<Object> get props => [
    expression,
    result,
    isResultMode, 
  ];

  CalculatorUpdated copyWith({
    String? expression,
    String? result,
    bool? isResultMode,
  }) {
    return CalculatorUpdated(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isResultMode: isResultMode ?? this.isResultMode,
    );
  }
}
