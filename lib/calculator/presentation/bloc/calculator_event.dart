part of 'calculator_bloc.dart';

sealed class CalculatorEvent {}

final class ButtonPressed extends CalculatorEvent {
  final String button;

  ButtonPressed(this.button);
}

final class ClearPressed extends CalculatorEvent {}

final class EqualsPressed extends CalculatorEvent {}

final class DeletePressed extends CalculatorEvent {}

final class LoadData extends CalculatorEvent {}

final class ToggleScientificMode extends CalculatorEvent {}