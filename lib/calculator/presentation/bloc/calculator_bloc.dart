import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/calculator_logic.dart';
import '../../../core/utils/buttons.dart';
import '../services/shared_preferences.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final SharedPreferencesService sharedPreferences;

  CalculatorBloc(this.sharedPreferences)
    : super(
        CalculatorUpdated(expression: '', result: '0', isResultMode: false, isScientificMode: false),
      ) {
    on<ButtonPressed>((event, emit) {
      String updatedExpression;
      if ((state as CalculatorUpdated).isResultMode) {
        if (Buttons.operators.contains(event.button)) {
          updatedExpression =
              (state as CalculatorUpdated).result + event.button;
        } else {
          updatedExpression = event.button;
        }
      } else {
        updatedExpression =
            (state as CalculatorUpdated).expression + event.button;
      }
      final result = calculateResult(updatedExpression);
      if (Buttons.operators.contains(event.button) &&
          (state as CalculatorUpdated).expression.isNotEmpty &&
          Buttons.operators.contains(
            (state as CalculatorUpdated)
                .expression[(state as CalculatorUpdated).expression.length - 1],
          )) {
        return;
      }
      emit(
        (state as CalculatorUpdated).copyWith(
          expression: updatedExpression,
          result: result,
          isResultMode: false,
        ),
      );
    });

    on<ClearPressed>((event, emit) {
      if ((state as CalculatorUpdated).expression.isNotEmpty) {
        emit(
          (state as CalculatorUpdated).copyWith(
            expression: '',
            result: '0',
            isResultMode: false,
          ),
        );
      } else {
        emit(
          (state as CalculatorUpdated).copyWith(
            expression: '',
            result: '0',
            isResultMode: false,
            history: [],
          ),
        );
        sharedPreferences.clearData();
      }
    });

    on<EqualsPressed>((event, emit) {
      final expression = (state as CalculatorUpdated).expression;

      final addHistory = List<String>.from((state as CalculatorUpdated).history)
        ..add('$expression = ${calculateResult(expression)}');
      sharedPreferences.saveData(addHistory);

      final result = calculateResult(expression);

      emit(
        (state as CalculatorUpdated).copyWith(
          result: result,
          isResultMode: true,
          history: addHistory,
        ),
      );
    });

    on<DeletePressed>((event, emit) {
      final expression = (state as CalculatorUpdated).expression;
      if (expression.isNotEmpty) {
        final updatedExpression = expression.substring(
          0,
          expression.length - 1,
        );
        final result = updatedExpression.isEmpty ? '0' : calculateResult(updatedExpression);
        emit(
          (state as CalculatorUpdated).copyWith(
            expression: updatedExpression,
            result: result,
            isResultMode: false,
          ),
        );
      }
    });

    on<LoadData>((event, emit) async {
      final history = await sharedPreferences.getData();
      emit((state as CalculatorUpdated).copyWith(history: history));
    });

    on<ToggleScientificMode>((event, emit) {
      emit(
        (state as CalculatorUpdated).copyWith(
          isScientificMode: !(state as CalculatorUpdated).isScientificMode,
        ),
      );
    });
  }
}
