import 'package:flutter/material.dart';
import 'package:swiss_army_knife/screens/home_screen.dart';
import 'package:swiss_army_knife/screens/unit_converter.dart';
import 'package:swiss_army_knife/screens/measurement_converter.dart';
import 'package:swiss_army_knife/screens/text_tools.dart';
import 'package:swiss_army_knife/screens/calculator.dart';
import 'package:swiss_army_knife/screens/password_generator.dart';
import 'package:swiss_army_knife/screens/currency_converter.dart';
import 'package:swiss_army_knife/screens/date_time_tools.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.build_circle_outlined, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Swiss Army Knife',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Multifuncional Tools',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, Icons.home, 'Página Inicial', () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            }),
            _buildDrawerItem(context, Icons.swap_horiz, 'Conversor de Unidades', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitConverter()));
            }),
            _buildDrawerItem(context, Icons.straighten, 'Conversor de Medidas', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MeasurementConverter()));
            }),
            _buildDrawerItem(context, Icons.text_fields, 'Ferramentas de Texto', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TextTools()));
            }),
            _buildDrawerItem(context, Icons.calculate, 'Calculadora', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CalculatorScreen()));
            }),
            _buildDrawerItem(context, Icons.lock, 'Gerador de Senhas', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordGenerator()));
            }),
            _buildDrawerItem(context, Icons.currency_exchange, 'Conversor de Moedas', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CurrencyConverter()));
            }),
            _buildDrawerItem(context, Icons.access_time, 'Ferramentas de Data e Hora', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DateTimeTools()));
            }),
            const Divider(),
            _buildDrawerItem(context, Icons.info, 'Sobre', () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Swiss Army Knife App',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.build_circle_outlined, size: 40),
                children: [
                  const Text('Um aplicativo multifuncional com diversas ferramentas úteis em um só lugar.'),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}