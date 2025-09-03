import 'package:flutter/material.dart';
import 'package:swiss_army_knife/utils/unit_conversions.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedFromUnit = 'Meters';
  String _selectedToUnit = 'Kilometers';
  String _result = '';

  final List<String> _unitTypes = ['Length', 'Weight', 'Temperature', 'Volume'];
  String _selectedUnitType = 'Length';

  final Map<String, List<String>> _units = {
    'Length': ['Meters', 'Kilometers', 'Centimeters', 'Millimeters', 'Miles', 'Yards', 'Feet', 'Inches'],
    'Weight': ['Grams', 'Kilograms', 'Milligrams', 'Pounds', 'Ounces'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Volume': ['Liters', 'Milliliters', 'Gallons', 'Quarts', 'Pints', 'Cups'],
  };

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    if (_inputController.text.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    try {
      double inputValue = double.parse(_inputController.text);
      double convertedValue = convertUnit(inputValue, _selectedFromUnit, _selectedToUnit, _selectedUnitType);
      
      setState(() {
        _result = convertedValue.toStringAsFixed(6);
      });
    } catch (e) {
      setState(() {
        _result = 'Erro na conversão';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Conversor de Unidades'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedUnitType,
              items: _unitTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUnitType = newValue!;
                  _selectedFromUnit = _units[_selectedUnitType]![0];
                  _selectedToUnit = _units[_selectedUnitType]![1];
                  _convert();
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Valor de entrada',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFromUnit,
                    items: _units[_selectedUnitType]!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFromUnit = newValue!;
                        _convert();
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
            Icon(Icons.arrow_downward, size: 30, color: Colors.blue),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedToUnit,
              items: _units[_selectedUnitType]!.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedToUnit = newValue!;
                  _convert();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Para',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Resultado: $_result',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}