import 'package:math_expressions/math_expressions.dart';

String calculateResult(String expression) {
  try {
    if (expression.isEmpty) {
      return "0";
    }

    String finalExpression = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100')
        .replaceAll('π', '3.14159265359');

    finalExpression = finalExpression.replaceAll('√(', 'sqrt(');

    finalExpression = finalExpression.replaceFirst(RegExp(r'[+\-*/^]$'), '');

    finalExpression = _handleFactorial(finalExpression);

    int openBrackets = '('.allMatches(finalExpression).length;
    int closeBrackets = ')'.allMatches(finalExpression).length;
    if (openBrackets > closeBrackets) {
      finalExpression += ')' * (openBrackets - closeBrackets);
    }
    finalExpression = _handleTrigFunctions(finalExpression);
    finalExpression = _handleLogFunction(finalExpression);

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

int factorial(int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n - 1);
}

String _handleFactorial(String expression) {
  RegExp regExp = RegExp(r'(\d+)!');

  return expression.replaceAllMapped(regExp, (match) {
    int number = int.parse(match.group(1)!);

    return factorial(number).toString();
  });
}

String _handleTrigFunctions(
  String expression,
) {

  expression = expression.replaceAllMapped(
    RegExp(r'sin\(([^)]+)\)'),
    (match) =>
        'sin((${match.group(1)}) * (3.14159265359 / 180))',
  );

  expression = expression.replaceAllMapped(
    RegExp(r'cos\(([^)]+)\)'),
    (match) =>
        'cos((${match.group(1)}) * (3.14159265359 / 180))',
  );

  expression = expression.replaceAllMapped(
    RegExp(r'tan\(([^)]+)\)'),
    (match) =>
        'tan((${match.group(1)}) * (3.14159265359 / 180))',
  );

  return expression;
}

String _handleLogFunction(
  String expression,
) {

  expression = expression.replaceAllMapped(
    RegExp(r'log\(([^)]+)\)'),
    (match) =>
        '(ln(${match.group(1)}) / ln(10))',
  );

  return expression;
}
