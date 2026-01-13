import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class NumberFormattersDemo extends StatefulWidget {
  const NumberFormattersDemo({super.key});

  @override
  State<NumberFormattersDemo> createState() => _NumberFormattersDemoState();
}

class _NumberFormattersDemoState extends State<NumberFormattersDemo> {
  final _controller = TextEditingController(text: '1234.5678');
  String _result = '';

  void _update() {
    final input = double.tryParse(_controller.text) ?? 0;
    final intVal = int.tryParse(_controller.text.replaceAll('.', '')) ?? 0;

    setState(() {
      _result =
          '''
Input: $input

1. Currency: ${SmartNumberFormat.currency(input)}
2. Currency (Custom): ${SmartNumberFormat.currency(input, symbol: '€', symbolPosition: 'after')}
3. Percentage: ${SmartNumberFormat.percentage(input / 100)}
4. Compact: ${SmartNumberFormat.compact(input)}
5. Compact (Long): ${SmartNumberFormat.compactLong(input)}
6. File Size ($intVal bytes): ${SmartNumberFormat.fileSize(intVal)}
7. Decimal (2 digits): ${SmartNumberFormat.decimal(input, decimalDigits: 2)}
8. With Separator: ${SmartNumberFormat.withSeparator(input)}
9. Ordinal (${input.toInt()}): ${SmartNumberFormat.ordinal(input.toInt())}
''';
    });
  }

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Formatters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => _update(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Formatted Results:',
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
                _result,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
