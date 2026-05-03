import 'package:calculator/core/utils/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              children: Buttons.buttons
                  .map(
                    (e) => Padding(
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
                        onPressed: () {},
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
