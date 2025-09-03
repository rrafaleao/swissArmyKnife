import 'package:flutter/material.dart';
import 'dart:math';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _password = '';
  int _length = 12;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;
  double _strength = 0.0;
  String _strengthText = '';

  final String _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  final String _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String _numbers = '0123456789';
  final String _symbols = '!@#\$%^&*()_-+={}[]|;:<>,.?/';

  @override
  void initState() {
    super.initState();
    _generatePassword();
  }

  void _generatePassword() {
    String charPool = '';
    
    if (_includeLowercase) charPool += _lowercase;
    if (_includeUppercase) charPool += _uppercase;
    if (_includeNumbers) charPool += _numbers;
    if (_includeSymbols) charPool += _symbols;
    
    if (charPool.isEmpty) {
      setState(() {
        _password = 'Selecione pelo menos uma opção';
        _strength = 0.0;
        _strengthText = 'Muito Fraca';
      });
      return;
    }
    
    final random = Random.secure();
    String generatedPassword = '';
    
    for (int i = 0; i < _length; i++) {
      int randomIndex = random.nextInt(charPool.length);
      generatedPassword += charPool[randomIndex];
    }
    
    _calculateStrength(generatedPassword);
    
    setState(() {
      _password = generatedPassword;
    });
  }

  void _calculateStrength(String password) {
    // Cálculo simples de força da senha
    int poolSize = 0;
    if (_includeLowercase) poolSize += 26;
    if (_includeUppercase) poolSize += 26;
    if (_includeNumbers) poolSize += 10;
    if (_includeSymbols) poolSize += 30; // Aproximadamente
    
    double entropy = password.length * log(poolSize) / ln2;
    
    setState(() {
      _strength = entropy / 100; // Normalizado para 0-1
      
      if (entropy < 28) {
        _strengthText = 'Muito Fraca';
      } else if (entropy < 36) {
        _strengthText = 'Fraca';
      } else if (entropy < 60) {
        _strengthText = 'Moderada';
      } else if (entropy < 128) {
        _strengthText = 'Forte';
      } else {
        _strengthText = 'Muito Forte';
      }
    });
  }

  Color _getStrengthColor() {
    if (_strength < 0.3) return Colors.red;
    if (_strength < 0.6) return Colors.orange;
    if (_strength < 0.8) return Colors.yellow;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gerador de Senhas'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Senha Gerada:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                _password,
                style: const TextStyle(fontSize: 20, letterSpacing: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Comprimento: $_length'),
                      Slider(
                        value: _length.toDouble(),
                        min: 4,
                        max: 32,
                        divisions: 28,
                        onChanged: (value) {
                          setState(() {
                            _length = value.toInt();
                            _generatePassword();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _generatePassword,
                  child: const Text('Gerar Nova'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Opções:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              children: [
                FilterChip(
                  label: const Text('Maiúsculas'),
                  selected: _includeUppercase,
                  onSelected: (value) {
                    setState(() {
                      _includeUppercase = value;
                      _generatePassword();
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Minúsculas'),
                  selected: _includeLowercase,
                  onSelected: (value) {
                    setState(() {
                      _includeLowercase = value;
                      _generatePassword();
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Números'),
                  selected: _includeNumbers,
                  onSelected: (value) {
                    setState(() {
                      _includeNumbers = value;
                      _generatePassword();
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Símbolos'),
                  selected: _includeSymbols,
                  onSelected: (value) {
                    setState(() {
                      _includeSymbols = value;
                      _generatePassword();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Força da Senha:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _strength,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getStrengthColor()),
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            Text(
              _strengthText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getStrengthColor(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_password.isNotEmpty && _password != 'Selecione pelo menos uma opção') {
                    Clipboard.setData(ClipboardData(text: _password));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Senha copiada para a área de transferência!')),
                    );
                  }
                },
                child: const Text('Copiar Senha'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}