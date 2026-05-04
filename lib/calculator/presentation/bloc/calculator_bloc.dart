import 'package:bloc/bloc.dart';

import '../../../core/calculator_logic.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorUpdated(expression: '', result: '0')) {

    on<ButtonPressed>((event, emit) {
      final updatedExpression = (state as CalculatorUpdated).expression + event.button;
      emit((state as CalculatorUpdated).copyWith(expression: updatedExpression));
    });

    on<ClearPressed>((event, emit) {
      emit((state as CalculatorUpdated).copyWith(expression: '', result: '0'));
    });

    on<EqualsPressed>((event, emit) {
      final expression = (state as CalculatorUpdated).expression;

       final result = calculateResult(expression);

      emit((state as CalculatorUpdated).copyWith(result: result));
    });

    on<DeletePressed>((event, emit) {
      final expression = (state as CalculatorUpdated).expression;
      if (expression.isNotEmpty) {
        final updatedExpression = expression.substring(0, expression.length - 1);
        emit((state as CalculatorUpdated).copyWith(expression: updatedExpression));
      }
    });
  }
}
