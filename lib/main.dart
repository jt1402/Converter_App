import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CurrencyConverterApp(),
  ));
}

class CurrencyConverterApp extends StatefulWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  _CurrencyConverterAppState createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  double amount = 0.0;
  String amountCurrency = 'USD';
  String targetCurrency = 'KRW';
  String result = '';
  Map<String, double> conversionRates = {
    'USD': 1.0,
    'GBP': 0.81,
    'RUB': 79,
    'CNH': 7.01,
    'UZS': 11440.0,
    'EUR': 0.93,
    'KRW': 1323.43,
  };
  double exampleConversionRate =
  1323.43; // Initial example rate, change it to the appropriate value

  final amountFocusNode = FocusNode(); // Create a focus node for the amount text field

  void convertCurrency() {
    double amountConversionRate = conversionRates[amountCurrency]!;
    double targetConversionRate = conversionRates[targetCurrency]!;
    double resultValue =
        (amount / amountConversionRate) * targetConversionRate;
    String resultText = resultValue.toStringAsFixed(2);
    setState(() {
      result = '$amount $amountCurrency = $resultText $targetCurrency';
    });

    // Hide the keyboard by unfocusing the text field
    amountFocusNode.unfocus();
  }

  void updateExampleConversionRate() {
    double selectedConversionRate = conversionRates[targetCurrency]!;
    double amountConversionRate = conversionRates[amountCurrency]!;
    double targetValue = (1 / amountConversionRate) * selectedConversionRate;
    setState(() {
      exampleConversionRate = targetValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Converter'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/image.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Enter amount:',
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: amountFocusNode, // Assign the focus node to the text field
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (value) {
                          setState(() {
                            amount = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    DropdownButton<String>(
                      value: amountCurrency,
                      onChanged: (value) {
                        setState(() {
                          amountCurrency = value!;
                          result = '';
                          updateExampleConversionRate();
                        });
                      },
                      items: conversionRates.keys.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select target currency:',
                  style: TextStyle(fontSize: 18.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: targetCurrency,
                      onChanged: (value) {
                        setState(() {
                          targetCurrency = value!;
                          result = '';
                          updateExampleConversionRate();
                        });
                      },
                      items: conversionRates.keys.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      '1 $amountCurrency = ${exampleConversionRate.toStringAsFixed(5)} $targetCurrency',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: convertCurrency,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 18.0),
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 16.0),
                if (result.isNotEmpty)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              result,
                              style: const TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
