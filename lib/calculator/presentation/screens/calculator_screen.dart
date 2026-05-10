import 'package:calculator/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:calculator/core/utils/buttons.dart';
import 'package:calculator/core/utils/scientific_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          expression,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isResultMode ? 24 : 36,
                            fontWeight: isResultMode
                                ? FontWeight.normal
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          result,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isResultMode ? 36 : 30,
                            fontWeight: isResultMode
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              flex: 3,
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  bool isScientificMode = false;
                  bool isResultMode = false;

                  if (state is CalculatorUpdated) {
                    isScientificMode = state.isScientificMode;
                    isResultMode = state.isResultMode;
                  }

                  return Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isScientificMode ? 70 : 0,
                        curve: Curves.easeInOut,
                        child: isScientificMode
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: ScientificButtons
                                    .leftScientificButtons
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: Colors.grey[900],
                                              side: BorderSide.none,
                                              shape: const CircleBorder(),
                                            ),
                                            onPressed: () {
                                              if (e == '√') {
                                                context.
                                                  read<CalculatorBloc>().add(ButtonPressed('√('));
                                              }
                                              else {
                                                context.
                                                  read<CalculatorBloc>().add(ButtonPressed(e));
                                              }
                                            },
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color: Colors.orange,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const SizedBox(),
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: isScientificMode ? 80 : 0,
                              curve: Curves.easeInOut,
                              child: isScientificMode
                                  ? Row(
                                      children: ScientificButtons
                                          .topScientificButtons
                                          .map(
                                            (e) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                  ),
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  padding: const EdgeInsets.all(
                                                    24,
                                                  ),
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (e == 'sin') {
                                                  context.
                                                  read<CalculatorBloc>().add(ButtonPressed('sin('));
                                                  }
                                                  else if (e == 'cos') {
                                                    context.
                                                  read<CalculatorBloc>().add(ButtonPressed('cos('));
                                                  }

                                                  else if (e == 'tan') {
                                                    context.
                                                  read<CalculatorBloc>().add(ButtonPressed('tan('));
                                                  }

                                                  else if (e == 'log') {
                                                    context.
                                                  read<CalculatorBloc>().add(ButtonPressed('log('));
                                                  }

                                                  else if (e == 'ln') {
                                                    context.
                                                  read<CalculatorBloc>().add(ButtonPressed('ln('));
                                                  }
                                                },
                                                child: Text(
                                                  e,
                                                  style: const TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : const SizedBox(),
                            ),

                            Expanded(
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(
                                  begin: 1,
                                  end: isScientificMode ? 0.92 : 1,
                                ),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: Buttons.buttons.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 1.1,
                                      ),
                                  itemBuilder: (context, index) {
                                    final e = Buttons.buttons[index];
                                    return OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor:
                                            Buttons.topRowButtons.contains(e)
                                            ? Colors.grey
                                            : Buttons.operators.contains(e)
                                            ? Colors.orange[800]
                                            : Colors.grey[900],
                                        side: BorderSide.none,
                                        shape: const CircleBorder(),
                                      ),
                                      onPressed: (isResultMode && e == 'DEL')
                                          ? null
                                          : () {
                                              if (e == 'C') {
                                                context
                                                    .read<CalculatorBloc>()
                                                    .add(ClearPressed());
                                              } else if (e == '=') {
                                                context
                                                    .read<CalculatorBloc>()
                                                    .add(EqualsPressed());
                                              } else if (e == 'fx') {
                                                context
                                                    .read<CalculatorBloc>()
                                                    .add(
                                                      ToggleScientificMode(),
                                                    );
                                              } else if (e == 'DEL') {
                                                context
                                                    .read<CalculatorBloc>()
                                                    .add(DeletePressed());
                                              } else {
                                                context
                                                    .read<CalculatorBloc>()
                                                    .add(ButtonPressed(e));
                                              }
                                            },
                                      child: e == 'DEL'
                                          ? const Icon(
                                              Icons.backspace_outlined,
                                              color: Colors.white,
                                            )
                                          : Text(
                                              e,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
