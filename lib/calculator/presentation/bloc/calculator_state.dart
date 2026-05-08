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
  final List<String> history;
  final bool isScientificMode;

  const CalculatorUpdated({
    required this.expression,
    required this.result,
    this.isResultMode = false,
    this.history = const [],
    this.isScientificMode = false,
  });

  @override
  List<Object> get props => [
    expression,
    result,
    isResultMode, 
    history,
    isScientificMode,
  ];

  CalculatorUpdated copyWith({
    String? expression,
    String? result,
    bool? isResultMode,
    List<String>? history,
    bool? isScientificMode,
  }) {
    return CalculatorUpdated(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isResultMode: isResultMode ?? this.isResultMode,
      history: history ?? this.history,
      isScientificMode: isScientificMode ?? this.isScientificMode,
    );
  }
}
