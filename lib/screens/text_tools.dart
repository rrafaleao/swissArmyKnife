import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:swiss_army_knife/utils/text_utilities.dart';
import 'package:swiss_army_knife/widgets/custom_app_bar.dart'; 

class TextTools extends StatefulWidget {
  const TextTools({super.key});

  @override
  _TextToolsState createState() => _TextToolsState();
}

class _TextToolsState extends State<TextTools> {
  final TextEditingController _inputController = TextEditingController();
  String _processedText = '';
  int _charCount = 0;
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_updateCounts);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _updateCounts() {
    setState(() {
      _charCount = _inputController.text.length;
      _wordCount = countWords(_inputController.text);
    });
  }

  void _processText(String operation) {
    String result = '';
    
    switch (operation) {
      case 'uppercase':
        result = toUpperCase(_inputController.text);
        break;
      case 'lowercase':
        result = toLowerCase(_inputController.text);
        break;
      case 'reverse':
        result = reverseText(_inputController.text);
        break;
      case 'removeSpaces':
        result = removeExtraSpaces(_inputController.text);
        break;
      case 'capitalize':
        result = capitalizeWords(_inputController.text);
        break;
      default:
        result = _inputController.text;
    }
    
    setState(() {
      _processedText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ferramentas de Texto'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _inputController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Digite seu texto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Caracteres: $_charCount'),
                Text('Palavras: $_wordCount'),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _processText('uppercase'),
                  child: const Text('MAIÚSCULAS'),
                ),
                ElevatedButton(
                  onPressed: () => _processText('lowercase'),
                  child: const Text('minúsculas'),
                ),
                ElevatedButton(
                  onPressed: () => _processText('reverse'),
                  child: const Text('Inverter'),
                ),
                ElevatedButton(
                  onPressed: () => _processText('removeSpaces'),
                  child: const Text('Remover Espaços'),
                ),
                ElevatedButton(
                  onPressed: () => _processText('capitalize'),
                  child: const Text('Capitalizar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Texto Processado:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SelectableText(
                _processedText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_processedText.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: _processedText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Texto copiado para a área de transferência!')),
                  );
                }
              },
              child: const Text('Copiar Texto Processado'),
            ),
          ],
        ),
      ),
    );
  }
}