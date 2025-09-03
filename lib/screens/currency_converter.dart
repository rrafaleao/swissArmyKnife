import 'package:flutter/material.dart';
import 'package:swiss_army_knife/utils/currency_converter.dart' as currency_utils;

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _convertedAmount = '';
  String _exchangeRate = '';

  final List<String> _currencies = [
    'USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 
    'BRL', 'MXN', 'INR', 'RUB', 'KRW', 'TRY', 'SAR', 'AED'
  ];

  @override
  void initState() {
    super.initState();
    _amountController.text = '1.00';
    _convertCurrency();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convertCurrency() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _convertedAmount = '';
        _exchangeRate = '';
      });
      return;
    }

    try {
      double amount = double.parse(_amountController.text);
      Map<String, dynamic> result = currency_utils.convertCurrency(amount, _fromCurrency, _toCurrency);
      
      setState(() {
        _convertedAmount = result['convertedAmount'].toStringAsFixed(2);
        _exchangeRate = '1 $_fromCurrency = ${result['rate'].toStringAsFixed(4)} $_toCurrency';
      });
    } catch (e) {
      setState(() {
        _convertedAmount = 'Erro na conversão';
        _exchangeRate = 'Não foi possível calcular a taxa de câmbio';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Conversor de Moedas'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: const OutlineInputBorder(),
                      suffixText: _fromCurrency,
                    ),
                    onChanged: (value) => _convertCurrency(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                        _convertCurrency();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'De',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Icon(Icons.arrow_downward, size: 30, color: Colors.blue),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _toCurrency,
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _toCurrency = newValue!;
                  _convertCurrency();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Para',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _exchangeRate,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              '$_convertedAmount $_toCurrency',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Nota: As taxas de câmbio são valores fixos para demonstração.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}