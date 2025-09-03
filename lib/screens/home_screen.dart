import 'package:flutter/material.dart';
import 'package:swiss_army_knife/widgets/custom_drawer.dart';
import 'package:swiss_army_knife/widgets/custom_app_bar.dart';
import 'unit_converter.dart';
import 'measurement_converter.dart';
import 'text_tools.dart';
import 'calculator.dart';
import 'password_generator.dart';
import 'currency_converter.dart';
import 'date_time_tools.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Swiss Army Knife'),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.build_circle_outlined,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Swiss Army Knife App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Seu aplicativo multifuncional com todas as ferramentas essenciais em um só lugar!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildToolCard(
                      context,
                      Icons.swap_horiz,
                      'Conversor de Unidades',
                      Colors.blue,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitConverter())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.straighten,
                      'Conversor de Medidas',
                      Colors.green,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MeasurementConverter())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.text_fields,
                      'Ferramentas de Texto',
                      Colors.orange,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TextTools())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.calculate,
                      'Calculadora',
                      Colors.purple,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CalculatorScreen())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.lock,
                      'Gerador de Senhas',
                      Colors.red,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordGenerator())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.currency_exchange,
                      'Conversor de Moedas',
                      Colors.teal,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CurrencyConverter())),
                    ),
                    _buildToolCard(
                      context,
                      Icons.access_time,
                      'Data e Hora',
                      Colors.indigo,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DateTimeTools())),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, IconData icon, String title, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}