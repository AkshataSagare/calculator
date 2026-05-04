import 'package:math_expressions/math_expressions.dart';

String calculateResult(String expression) {
  try {
    if (expression.isEmpty) return "0";

    String finalExpression = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100');

    finalExpression = finalExpression.replaceFirst(RegExp(r'[+\-*/]$'), '');

    ExpressionParser parser = GrammarParser();
    Expression exp = parser.parse(finalExpression);

    ContextModel contextModel = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, contextModel);
      if (result % 1 == 0) {
      return result.toInt().toString();
    }
    return result.toString();
  } catch (e) {
    return "Error";
  }
}