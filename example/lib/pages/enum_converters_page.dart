import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

enum DemoStatus { active, pending, suspended, closed }

class EnumConvertersDemo extends StatefulWidget {
  const EnumConvertersDemo({super.key});

  @override
  State<EnumConvertersDemo> createState() => _EnumConvertersDemoState();
}

class _EnumConvertersDemoState extends State<EnumConvertersDemo> {
  final _controller = TextEditingController();
  String _result = '';

  void _convert() {
    final input = _controller.text;
    setState(() {
      final status = EnumConverter.fromStringOrNull(
        value: input,
        values: DemoStatus.values,
      );

      final statusDefault = EnumConverter.fromString(
        value: input,
        values: DemoStatus.values,
        defaultValue: DemoStatus.active,
      );

      String display = 'Invalid';
      if (status != null) {
        display = EnumConverter.toDisplayName(status);
      }

      _result =
          '''
Input: "$input"

1. fromStringOrNull: $status
2. fromString (default: active): $statusDefault
3. Display Name: $display
4. isValid: ${EnumConverter.isValidValue(value: input, enumValues: DemoStatus.values)}
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enum Converters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Available Enum Values: active, pending, suspended, closed',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Enum String',
                hintText: 'e.g. pending',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _convert(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _result.isEmpty ? 'Waiting for input...' : _result,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
