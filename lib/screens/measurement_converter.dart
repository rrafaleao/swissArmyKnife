import 'package:flutter/material.dart';
import 'package:swiss_army_knife/utils/unit_conversions.dart';
import 'package:swiss_army_knife/widgets/custom_app_bar.dart';

class MeasurementConverter extends StatefulWidget {
  const MeasurementConverter({super.key});

  @override
  _MeasurementConverterState createState() => _MeasurementConverterState();
}

class _MeasurementConverterState extends State<MeasurementConverter> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedFromSystem = 'Metric';
  String _selectedToSystem = 'Imperial';
  String _selectedMeasurement = 'Length';
  String _result = '';

  final List<String> _measurements = ['Length', 'Weight', 'Volume', 'Temperature'];
  final List<String> _systems = ['Metric', 'Imperial'];

  final Map<String, Map<String, String>> _defaultUnits = {
    'Length': {'Metric': 'Meters', 'Imperial': 'Feet'},
    'Weight': {'Metric': 'Kilograms', 'Imperial': 'Pounds'},
    'Volume': {'Metric': 'Liters', 'Imperial': 'Gallons'},
    'Temperature': {'Metric': 'Celsius', 'Imperial': 'Fahrenheit'},
  };

  final Map<String, Map<String, List<String>>> _availableUnits = {
    'Length': {
      'Metric': ['Meters', 'Kilometers', 'Centimeters', 'Millimeters'],
      'Imperial': ['Miles', 'Yards', 'Feet', 'Inches']
    },
    'Weight': {
      'Metric': ['Grams', 'Kilograms', 'Milligrams'],
      'Imperial': ['Pounds', 'Ounces']
    },
    'Volume': {
      'Metric': ['Liters', 'Milliliters'],
      'Imperial': ['Gallons', 'Quarts', 'Pints', 'Cups']
    },
    'Temperature': {
      'Metric': ['Celsius'],
      'Imperial': ['Fahrenheit']
    },
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
      
      // Obter unidades padrão para os sistemas selecionados
      String fromUnit = _defaultUnits[_selectedMeasurement]![_selectedFromSystem]!;
      String toUnit = _defaultUnits[_selectedMeasurement]![_selectedToSystem]!;
      
      double convertedValue = convertUnit(inputValue, fromUnit, toUnit, _selectedMeasurement);
      
      setState(() {
        _result = convertedValue.toStringAsFixed(4);
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
      appBar: CustomAppBar(title: 'Conversor de Sistemas de Medida'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedMeasurement,
              items: _measurements.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMeasurement = newValue!;
                  _convert();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tipo de Medida',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFromSystem,
                    items: _systems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedFromSystem = newValue!;
                        _convert();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Sistema de Origem',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: const OutlineInputBorder(),
                      suffixText: _defaultUnits[_selectedMeasurement]![_selectedFromSystem],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Icon(Icons.arrow_downward, size: 30, color: Colors.blue),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedToSystem,
              items: _systems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedToSystem = newValue!;
                  _convert();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Sistema de Destino',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: $_result ${_defaultUnits[_selectedMeasurement]![_selectedToSystem]}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Unidades Disponíveis:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sistema Métrico:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ..._availableUnits[_selectedMeasurement]!['Metric']!.map((unit) => Text('• $unit')).toList(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sistema Imperial:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ..._availableUnits[_selectedMeasurement]!['Imperial']!.map((unit) => Text('• $unit')).toList(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}