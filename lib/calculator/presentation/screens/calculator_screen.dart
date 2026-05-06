import 'package:calculator/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:calculator/core/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  List<String> history = [];

                  if (state is CalculatorUpdated) {
                    history = state.history;
                  }

                  return ListView.builder(
                    reverse: true,
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final item = history[history.length - 1 - index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        child: Text(
                          item,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                String expression = '';
                String result = '0';
                bool isResultMode = false;

                if (state is CalculatorUpdated) {
                  expression = state.expression;
                  result = state.result;
                  isResultMode = state.isResultMode;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        expression,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isResultMode ? 20 : 40,
                          fontWeight: isResultMode
                              ? FontWeight.normal
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        result,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isResultMode ? 40 : 24,
                          fontWeight: isResultMode
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            BlocBuilder<CalculatorBloc, CalculatorState>(
              builder: (context, state) {
                bool isResultMode = false;

                if (state is CalculatorUpdated) {
                  isResultMode = state.isResultMode;
                }
                return Wrap(
                  children: Buttons.buttons.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.22,
                            80,
                          ),
                          backgroundColor: Buttons.topRowButtons.contains(e)
                              ? Colors.grey
                              : Buttons.operators.contains(e)
                              ? Colors.orange[800]
                              : Colors.grey[900],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed:
                            (isResultMode && e == 'DEL')
                            ? null
                            : () {
                                if (e == 'C') {
                                  context.read<CalculatorBloc>().add(
                                    ClearPressed(),
                                  );
                                } else if (e == '=') {
                                  context.read<CalculatorBloc>().add(
                                    EqualsPressed(),
                                  );
                                } else if (e == 'DEL') {
                                  context.read<CalculatorBloc>().add(
                                    DeletePressed(),
                                  );
                                } else {
                                  context.read<CalculatorBloc>().add(
                                    ButtonPressed(e),
                                  );
                                }
                              },
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
