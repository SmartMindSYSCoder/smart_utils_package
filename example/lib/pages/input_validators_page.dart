import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class InputValidatorsDemo extends StatefulWidget {
  const InputValidatorsDemo({super.key});

  @override
  State<InputValidatorsDemo> createState() => _InputValidatorsDemoState();
}

class _InputValidatorsDemoState extends State<InputValidatorsDemo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Validators Demo')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Note: fields validate on interaction'),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Required Field'),
              validator: SmartInputValidators.required('Required Field'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Email Validator'),
              validator: SmartInputValidators.email(required: true),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile Validator (10 digits)',
              ),
              validator: SmartInputValidators.mobile(
                required: true,
                minLength: 10,
                maxLength: 10,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password (Complex)',
              ),
              obscureText: true,
              validator: SmartInputValidators.password(
                required: true,
                minLength: 8,
                requireUppercase: true,
                requireNumbers: true,
                requireSpecialChars: true,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Custom Validator (Must contain "flutter")',
              ),
              validator: SmartInputValidators.custom(
                customValidator: (val) {
                  if (val != null && !val.toLowerCase().contains('flutter')) {
                    return 'Must contain "flutter"';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('All valid!')));
                }
              },
              child: const Text('Validate All'),
            ),
          ],
        ),
      ),
    );
  }
}
