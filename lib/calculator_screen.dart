import 'package:flutter/material.dart';
import 'app_colors.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();

  String result = '0';
  String operationLabel = 'Enter two numbers';

  String formatNumber(double value) {
    if (value == value.truncateToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void calculate(String operation) {
    final first = double.tryParse(firstNumberController.text.trim());
    final second = double.tryParse(secondNumberController.text.trim());

    if (first == null ||
        second == null ||
        !first.isFinite ||
        !second.isFinite) {
      setState(() {
        result = 'Invalid input';
        operationLabel = 'Enter two valid numbers';
      });
      return;
    }

    double answer;

    switch (operation) {
      case '+':
        answer = first + second;
        break;
      case '-':
        answer = first - second;
        break;
      case '×':
        answer = first * second;
        break;
      case '÷':
        if (second == 0) {
          setState(() {
            result = 'Cannot divide by zero';
            operationLabel = 'Invalid operation';
          });
          return;
        }
        answer = first / second;
        break;
      default:
        return;
    }

    setState(() {
      result = formatNumber(answer);
      operationLabel =
          '${formatNumber(first)} $operation ${formatNumber(second)}';
    });
  }

  void clearCalculator() {
    firstNumberController.clear();
    secondNumberController.clear();

    setState(() {
      result = '0';
      operationLabel = 'Enter two numbers';
    });
  }

  @override
  void dispose() {
    firstNumberController.dispose();
    secondNumberController.dispose();
    super.dispose();
  }

  Widget buildNumberField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.maroon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.maroon, width: 2),
        ),
      ),
    );
  }

  Widget buildOperationButton({
    required String symbol,
    required String operation,
    required Color color,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () => calculate(operation),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 60),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            symbol,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calculator'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8C9CF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: 460,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.calculate,
                              size: 48,
                              color: AppColors.maroon,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'CALCULATOR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: AppColors.maroon,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                buildNumberField(
                                  controller: firstNumberController,
                                  label: 'First Number',
                                  hint: 'Enter the first number',
                                  icon: Icons.looks_one,
                                ),
                                const SizedBox(height: 12),
                                buildNumberField(
                                  controller: secondNumberController,
                                  label: 'Second Number',
                                  hint: 'Enter the second number',
                                  icon: Icons.looks_two,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    buildOperationButton(
                                      symbol: '+',
                                      operation: '+',
                                      color: Colors.green.shade700,
                                    ),
                                    buildOperationButton(
                                      symbol: '−',
                                      operation: '-',
                                      color: Colors.orange.shade800,
                                    ),
                                    buildOperationButton(
                                      symbol: '×',
                                      operation: '×',
                                      color: Colors.blueGrey.shade700,
                                    ),
                                    buildOperationButton(
                                      symbol: '÷',
                                      operation: '÷',
                                      color: AppColors.maroonSoft,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.maroon, AppColors.maroonSoft],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.maroon.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                operationLabel,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'RESULT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                result,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: clearCalculator,
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            'Clear',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.maroon,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(
                                color: AppColors.maroon, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Created by: Jamaillah Santi\nSection: CCE 106-3450',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}