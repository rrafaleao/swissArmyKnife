import 'package:flutter/material.dart';
import 'package:swiss_army_knife/utils/calculator_operations.dart';
import 'package:swiss_army_knife/widgets/custom_app_bar.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _expression = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operation = '';
  bool _isScientificMode = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '⌫') {
      _backspace();
    } else if (buttonText == '=') {
      _calculate();
    } else if (buttonText == '±') {
      _toggleSign();
    } else if (buttonText == '.') {
      _addDecimal();
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      _setOperation(buttonText);
    } else if (['sin', 'cos', 'tan', 'log', 'ln', '√', 'x²', 'x³', '10^x', 'e^x', '1/x'].contains(buttonText)) {
      _scientificOperation(buttonText);
    } else {
      _appendNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      _expression = '';
      _num1 = 0;
      _num2 = 0;
      _operation = '';
    });
  }

  void _backspace() {
    setState(() {
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = '0';
      }
    });
  }

  void _appendNumber(String number) {
    setState(() {
      if (_output == '0') {
        _output = number;
      } else {
        _output += number;
      }
    });
  }

  void _addDecimal() {
    setState(() {
      if (!_output.contains('.')) {
        _output += '.';
      }
    });
  }

  void _toggleSign() {
    setState(() {
      if (_output != '0') {
        if (_output.startsWith('-')) {
          _output = _output.substring(1);
        } else {
          _output = '-' + _output;
        }
      }
    });
  }

  void _setOperation(String operation) {
    setState(() {
      _num1 = double.parse(_output);
      _operation = operation;
      _expression = '$_num1 $operation ';
      _output = '0';
    });
  }

  void _scientificOperation(String operation) {
    double number = double.parse(_output);
    double result = performScientificOperation(number, operation);
    
    setState(() {
      _expression = '$operation($_output)';
      _output = result.toString();
    });
  }

  void _calculate() {
    setState(() {
      _num2 = double.parse(_output);
      _expression += _num2.toString();
      
      double result = performOperation(_num1, _num2, _operation);
      
      _output = result.toString();
      if (_output.endsWith('.0')) {
        _output = _output.substring(0, _output.length - 2);
      }
      
      _expression += ' = $_output';
      _num1 = result;
      _operation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Calculadora'),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _output,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Modo Científico'),
                        value: _isScientificMode,
                        onChanged: (value) {
                          setState(() {
                            _isScientificMode = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: _isScientificMode ? 5 : 4,
                    children: _isScientificMode ? _buildScientificButtons() : _buildBasicButtons(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBasicButtons() {
    List<String> buttons = [
      'C', '⌫', '±', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '.', '=',
    ];

    return buttons.map((String text) {
      return Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(text),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildScientificButtons() {
    List<String> buttons = [
      'C', '⌫', '±', '÷', 'sin',
      '7', '8', '9', '×', 'cos',
      '4', '5', '6', '-', 'tan',
      '1', '2', '3', '+', 'log',
      '0', '.', '=', '√', 'x²',
      'x³', '10^x', 'e^x', '1/x', 'ln',
    ];

    return buttons.map((String text) {
      return Container(
        margin: const EdgeInsets.all(2),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(text),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(8),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: text.length > 2 ? 14 : 16),
          ),
        ),
      );
    }).toList();
  }

  Color _getButtonColor(String buttonText) {
    if (buttonText == 'C' || buttonText == '⌫') {
      return Colors.red;
    } else if (buttonText == '=') {
      return Colors.green;
    } else if (['+', '-', '×', '÷', '±'].contains(buttonText)) {
      return Colors.orange;
    } else if ([
      'sin', 'cos', 'tan', 'log', 'ln', 
      '√', 'x²', 'x³', '10^x', 'e^x', '1/x'
    ].contains(buttonText)) {
      return Colors.purple;
    } else {
      return Colors.blue;
    }
  }
}