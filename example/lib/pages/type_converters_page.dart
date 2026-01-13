import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class TypeConvertersDemo extends StatefulWidget {
  const TypeConvertersDemo({super.key});

  @override
  State<TypeConvertersDemo> createState() => _TypeConvertersDemoState();
}

class _TypeConvertersDemoState extends State<TypeConvertersDemo> {
  final _controller = TextEditingController();
  String _result = '';
  String _selectedType = 'Int';

  void _convert() {
    final input = _controller.text;
    setState(() {
      switch (_selectedType) {
        case 'Int':
          final val = TypeConverter.toIntOrNull(input);
          final def = TypeConverter.toInt(input, defaultValue: 0);
          _result = 'Nullable: $val\nNon-Nullable (default 0): $def';
          break;
        case 'Double':
          final val = TypeConverter.toDoubleOrNull(input);
          final def = TypeConverter.toDouble(input, defaultValue: 0.0);
          _result = 'Nullable: $val\nNon-Nullable (default 0.0): $def';
          break;
        case 'Bool':
          final val = TypeConverter.toBoolOrNull(input);
          final def = TypeConverter.toBool(input, defaultValue: false);
          _result = 'Nullable: $val\nNon-Nullable (default false): $def';
          break;
        case 'DateTime':
          final val = TypeConverter.toDateTimeOrNull(input);
          final def = TypeConverter.toDateTime(input);
          _result = 'Nullable: $val\nNon-Nullable (default now): $def';
          break;
        case 'List':
          final val = TypeConverter.toListOrNull<dynamic>(input);
          final def = TypeConverter.toList<dynamic>(input);
          _result = 'Nullable: $val\nNon-Nullable (default []): $def';
          break;
        case 'Map':
          final val = TypeConverter.toMapOrNull(input);
          final def = TypeConverter.toMap(input);
          _result = 'Nullable: $val\nNon-Nullable (default {}): $def';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Type Converters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: [
                'Int',
                'Double',
                'Bool',
                'DateTime',
                'List',
                'Map',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() {
                _selectedType = v!;
                _convert();
              }),
              decoration: const InputDecoration(labelText: 'Target Type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Input Value',
                hintText: 'Enter value to convert...',
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
