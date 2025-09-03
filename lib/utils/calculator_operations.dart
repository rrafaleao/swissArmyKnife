import 'dart:math';

double performOperation(double num1, double num2, String operation) {
  switch (operation) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    case '×':
      return num1 * num2;
    case '÷':
      if (num2 == 0) {
        throw Exception('Divisão por zero não é permitida');
      }
      return num1 / num2;
    default:
      return num2;
  }
}

double performScientificOperation(double number, String operation) {
  switch (operation) {
    case 'sin':
      return sin(number * pi / 180); // Converte para radianos
    case 'cos':
      return cos(number * pi / 180);
    case 'tan':
      return tan(number * pi / 180);
    case 'log':
      return log(number) / ln10;
    case 'ln':
      return log(number);
    case '√':
      return sqrt(number);
    case 'x²':
      return number * number;
    case 'x³':
      return number * number * number;
    case '10^x':
      return pow(10, number).toDouble();
    case 'e^x':
      return exp(number);
    case '1/x':
      if (number == 0) {
        throw Exception('Divisão por zero não é permitida');
      }
      return 1 / number;
    default:
      return number;
  }
}