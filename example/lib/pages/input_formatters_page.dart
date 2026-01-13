import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class InputFormattersDemo extends StatefulWidget {
  const InputFormattersDemo({super.key});

  @override
  State<InputFormattersDemo> createState() => _InputFormattersDemoState();
}

class _InputFormattersDemoState extends State<InputFormattersDemo> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _passportController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _creditCardController = TextEditingController();
  final _cvvController = TextEditingController();
  final _ageController = TextEditingController();
  final _percentageController = TextEditingController();
  final _currencyController = TextEditingController();
  final _usernameController = TextEditingController();
  final _urlController = TextEditingController();
  final _passwordController = TextEditingController();
  final _strictPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Vital signs controllers
  final _temperatureController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _spo2Controller = TextEditingController();
  final _glucoseController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _idNumberController.dispose();
    _passportController.dispose();
    _postalCodeController.dispose();
    _creditCardController.dispose();
    _cvvController.dispose();
    _ageController.dispose();
    _percentageController.dispose();
    _currencyController.dispose();
    _usernameController.dispose();
    _urlController.dispose();
    _passwordController.dispose();
    _strictPasswordController.dispose();
    _confirmPasswordController.dispose();
    _temperatureController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _spo2Controller.dispose();
    _glucoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Formatters Demo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionHeader('Personal Information'),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'John Doe',
              icon: Icons.person,
              formatters: SmartInputFormatters.name(),
              description: 'Letters, spaces, hyphens, apostrophes only',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _ageController,
              label: 'Age',
              hint: '25',
              icon: Icons.cake,
              formatters: SmartInputFormatters.age(),
              keyboardType: TextInputType.number,
              description: 'Digits only, max 3 characters',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Contact Information'),
            _buildTextField(
              controller: _mobileController,
              label: 'Mobile Number',
              hint: '1234567890',
              icon: Icons.phone,
              formatters: SmartInputFormatters.mobile(),
              keyboardType: TextInputType.phone,
              description: 'Digits only, max 15 characters',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'john.doe@example.com',
              icon: Icons.email,
              formatters: SmartInputFormatters.email(),
              keyboardType: TextInputType.emailAddress,
              description: 'Valid email format, no spaces',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Physical Measurements'),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _heightController,
                    label: 'Height (cm)',
                    hint: '175.5',
                    icon: Icons.height,
                    formatters: SmartInputFormatters.vitalSign(
                      allowDecimal: true,
                      maxDigitsBeforeDecimal: 3,
                      maxDigitsAfterDecimal: 2,
                      maxValue: 999.99,
                      maxLength: 6,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    description:
                        'Max 3 digits before, 2 after decimal (e.g., 175.50)',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _weightController,
                    label: 'Weight (kg)',
                    hint: '70.5',
                    icon: Icons.monitor_weight,
                    formatters: SmartInputFormatters.vitalSign(
                      allowDecimal: true,
                      maxDigitsBeforeDecimal: 3,
                      maxDigitsAfterDecimal: 2,
                      maxValue: 999.99,
                      maxLength: 6,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    description:
                        'Max 3 digits before, 2 after decimal (e.g., 70.50)',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Vital Signs'),
            _buildTextField(
              controller: _temperatureController,
              label: 'Temperature (°C)',
              hint: '37.5',
              icon: Icons.thermostat,
              formatters: SmartInputFormatters.vitalSign(
                allowDecimal: true,
                maxDigitsBeforeDecimal: 2,
                maxDigitsAfterDecimal: 1,
                maxValue: 50.0,
                maxLength: 4,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              description: 'Body temperature, max 50°C',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _systolicController,
                    label: 'Systolic BP',
                    hint: '120',
                    icon: Icons.favorite,
                    formatters: SmartInputFormatters.vitalSign(
                      minValue: 40,
                      maxValue: 250,
                      maxLength: 3,
                    ),
                    keyboardType: TextInputType.number,
                    description: 'Range: 40-250 mmHg',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _diastolicController,
                    label: 'Diastolic BP',
                    hint: '80',
                    icon: Icons.favorite_border,
                    formatters: SmartInputFormatters.vitalSign(
                      minValue: 20,
                      maxValue: 150,
                      maxLength: 3,
                    ),
                    keyboardType: TextInputType.number,
                    description: 'Range: 20-150 mmHg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _heartRateController,
              label: 'Heart Rate (bpm)',
              hint: '72',
              icon: Icons.monitor_heart,
              formatters: SmartInputFormatters.vitalSign(
                maxValue: 250,
                maxLength: 3,
              ),
              keyboardType: TextInputType.number,
              description: 'Integer only, max 250 bpm',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _spo2Controller,
                    label: 'SpO2 (%)',
                    hint: '98',
                    icon: Icons.air,
                    formatters: SmartInputFormatters.vitalSign(
                      maxValue: 100,
                      maxLength: 3,
                    ),
                    keyboardType: TextInputType.number,
                    description: 'Oxygen saturation, 0-100',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _glucoseController,
                    label: 'Glucose (mg/dL)',
                    hint: '100',
                    icon: Icons.bloodtype,
                    formatters: SmartInputFormatters.vitalSign(
                      maxValue: 9999,
                      maxLength: 4,
                    ),
                    keyboardType: TextInputType.number,
                    description: 'Blood glucose, 0-9999',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Identification Documents'),
            _buildTextField(
              controller: _idNumberController,
              label: 'National ID Number',
              hint: '1234567890',
              icon: Icons.badge,
              formatters: SmartInputFormatters.idNumber(),
              keyboardType: TextInputType.number,
              description: 'Must start with 1 or 2, digits only',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _passportController,
              label: 'Passport Number',
              hint: 'AB1234567',
              icon: Icons.card_travel,
              formatters: SmartInputFormatters.passport(),
              description: 'Alphanumeric, auto-uppercase',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _postalCodeController,
              label: 'Postal Code',
              hint: '12345',
              icon: Icons.location_on,
              formatters: SmartInputFormatters.postalCode(),
              description: 'Alphanumeric with hyphens',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Payment Information'),
            _buildTextField(
              controller: _creditCardController,
              label: 'Credit Card Number',
              hint: '1234 5678 9012 3456',
              icon: Icons.credit_card,
              formatters: SmartInputFormatters.creditCard(),
              keyboardType: TextInputType.number,
              description: 'Auto-formatted with spaces',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _cvvController,
                    label: 'CVV',
                    hint: '123',
                    icon: Icons.lock,
                    formatters: SmartInputFormatters.cvv(),
                    keyboardType: TextInputType.number,
                    description: '3-4 digits',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _currencyController,
                    label: 'Amount',
                    hint: '99.99',
                    icon: Icons.attach_money,
                    formatters: SmartInputFormatters.currency(),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    description: 'Currency format',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Account Information'),
            _buildTextField(
              controller: _usernameController,
              label: 'Username',
              hint: 'john_doe',
              icon: Icons.account_circle,
              formatters: SmartInputFormatters.username(),
              description: 'Alphanumeric, underscore, hyphen, auto-lowercase',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _urlController,
              label: 'Website URL',
              hint: 'https://example.com',
              icon: Icons.link,
              formatters: SmartInputFormatters.url(),
              keyboardType: TextInputType.url,
              description: 'Valid URL format, no spaces',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Security'),
            _buildTextField(
              controller: _passwordController,
              label: 'Password (Secure)',
              hint: 'Enter secure password',
              icon: Icons.lock,
              formatters: SmartInputFormatters.password(
                maxLength: 10,
                requireUppercase: true,
                requireLowercase: true,
                requireNumbers: true,
                requireSpecialChars: true,
              ),
              obscureText: true,
              description:
                  'Min 8 chars, uppercase, lowercase, number, special char, no spaces',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _strictPasswordController,
              label: 'Strict Password (English/Nums/Specials)',
              hint: 'No spaces or other langs',
              icon: Icons.lock_clock,
              formatters: SmartInputFormatters.password(
                maxLength: 50,
                strict: true,
                allowSpaces: false,
              ),
              obscureText: true,
              description: 'English, numbers, special chars only. No spaces.',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Re-enter password',
              icon: Icons.lock_outline,
              formatters: SmartInputFormatters.password(maxLength: 10),
              obscureText: true,
              description: 'Must match the password above',
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Other'),
            _buildTextField(
              controller: _percentageController,
              label: 'Percentage',
              hint: '75.5',
              icon: Icons.percent,
              formatters: SmartInputFormatters.percentage(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              description: '0-100, max 2 decimal places',
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.check_circle),
              label: const Text('Submit Form'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _clearForm,
              icon: const Icon(Icons.clear),
              label: const Text('Clear All'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required List<TextInputFormatter> formatters,
    String? description,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                      });
                    },
                  )
                : null,
          ),
          inputFormatters: formatters,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: (_) => setState(() {}),
        ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show a dialog with all the values
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDataRow('Name', _nameController.text),
                _buildDataRow('Age', _ageController.text),
                _buildDataRow('Mobile', _mobileController.text),
                _buildDataRow('Email', _emailController.text),
                _buildDataRow('Height', _heightController.text),
                _buildDataRow('Weight', _weightController.text),
                _buildDataRow('Temperature', _temperatureController.text),
                _buildDataRow('Systolic BP', _systolicController.text),
                _buildDataRow('Diastolic BP', _diastolicController.text),
                _buildDataRow('Heart Rate', _heartRateController.text),
                _buildDataRow('SpO2', _spo2Controller.text),
                _buildDataRow('Glucose', _glucoseController.text),
                _buildDataRow('ID Number', _idNumberController.text),
                _buildDataRow('Passport', _passportController.text),
                _buildDataRow('Postal Code', _postalCodeController.text),
                _buildDataRow('Credit Card', _creditCardController.text),
                _buildDataRow('CVV', _cvvController.text),
                _buildDataRow('Currency', _currencyController.text),
                _buildDataRow('Username', _usernameController.text),
                _buildDataRow('URL', _urlController.text),
                _buildDataRow(
                  'Password',
                  _passwordController.text.isNotEmpty ? '********' : '',
                ),
                _buildDataRow(
                  'Strict Password',
                  _strictPasswordController.text.isNotEmpty ? '********' : '',
                ),
                _buildDataRow(
                  'Confirm Password',
                  _confirmPasswordController.text.isNotEmpty ? '********' : '',
                ),
                _buildDataRow('Percentage', _percentageController.text),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDataRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _clearForm() {
    setState(() {
      _mobileController.clear();
      _emailController.clear();
      _nameController.clear();
      _heightController.clear();
      _weightController.clear();
      _idNumberController.clear();
      _passportController.clear();
      _postalCodeController.clear();
      _creditCardController.clear();
      _cvvController.clear();
      _ageController.clear();
      _percentageController.clear();
      _currencyController.clear();
      _usernameController.clear();
      _urlController.clear();
      _passwordController.clear();
      _strictPasswordController.clear();
      _confirmPasswordController.clear();
      _temperatureController.clear();
      _systolicController.clear();
      _diastolicController.clear();
      _heartRateController.clear();
      _spo2Controller.clear();
      _glucoseController.clear();
    });
  }
}
