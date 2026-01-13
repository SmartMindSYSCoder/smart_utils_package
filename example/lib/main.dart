import 'package:flutter/material.dart';
import 'package:smart_utils_example/pages/enum_converters_page.dart';
import 'package:smart_utils_example/pages/input_formatters_page.dart';
import 'package:smart_utils_example/pages/input_validators_page.dart';
import 'package:smart_utils_example/pages/number_formatters_page.dart';
import 'package:smart_utils_example/pages/type_converters_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Utils Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Utils Package Demo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            context,
            title: 'Input Formatters',
            subtitle: 'Phone, ID, Credit Card, Vital Signs...',
            icon: Icons.keyboard,
            page: const InputFormattersDemo(),
          ),
          _buildMenuItem(
            context,
            title: 'Input Validators',
            subtitle: 'Form validation, passwords, emails...',
            icon: Icons.check_circle_outline,
            page: const InputValidatorsDemo(),
          ),
          _buildMenuItem(
            context,
            title: 'Type Converters',
            subtitle: 'Safe type conversion (String ↔ Int ↔ Bool...)',
            icon: Icons.swap_horiz,
            page: const TypeConvertersDemo(),
          ),
          _buildMenuItem(
            context,
            title: 'Number Formatters',
            subtitle: 'Currency, Compact, File Size, Ordinals...',
            icon: Icons.numbers,
            page: const NumberFormattersDemo(),
          ),
          _buildMenuItem(
            context,
            title: 'Enum Converters',
            subtitle: 'Enum ↔ String, Display Names...',
            icon: Icons.list_alt,
            page: const EnumConvertersDemo(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
