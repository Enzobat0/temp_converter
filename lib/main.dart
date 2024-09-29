import 'package:flutter/material.dart';

void main() {
  runApp(const TempConverter());
}

class TempConverter extends StatelessWidget {
  const TempConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temperature Converter App',
      home: HomeConverter(),
    );
  }
}

class HomeConverter extends StatefulWidget {
  const HomeConverter({super.key});

  @override
  State<HomeConverter> createState() => _HomeConverterState();
}

class _HomeConverterState extends State<HomeConverter> {
  String conversionType = 'F to C'; // default Fahrenheit-to-Celsius
  TextEditingController tempController = TextEditingController(); // Input field
  String result = ''; // Stores the converted temp to display it
  List<String> history = [];

  // Function to handle temperature conversion
  void convertTemperature() {
    double input = double.tryParse(tempController.text) ?? 0.0; // Get input
    double output;

    // Fahrenheit to Celsius
    if (conversionType == 'F to C') {
      output = (input - 32) * 5 / 9;
      setState(() {
        result =
            '${input.toStringAsFixed(2)} °F = ${output.toStringAsFixed(2)} °C';
        history.add(
            'F to C: ${input.toStringAsFixed(2)} => ${output.toStringAsFixed(2)}');
      });
    }
    // Celsius to Fahrenheit
    else {
      output = input * 9 / 5 + 32;
      setState(() {
        result =
            '${input.toStringAsFixed(2)} °C = ${output.toStringAsFixed(2)} °F';
        history.add(
            'C to F: ${input.toStringAsFixed(2)} => ${output.toStringAsFixed(2)}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Temperature Converter",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for temperature
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Temperature to convert'),
            ),

            // Radio buttons to select conversion type
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: conversionType, // groups radios
                  onChanged: (value) {
                    setState(() {
                      conversionType = value!;
                    });
                  },
                  activeColor: Colors.yellow,
                ),
                const Text('F to C'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: conversionType,
                  onChanged: (value) {
                    setState(() {
                      conversionType = value!;
                    });
                  },
                  activeColor: Colors.yellow,
                ),
                const Text('C to F'),
              ],
            ),

            // Button to trigger conversion
            ElevatedButton(
              onPressed: convertTemperature,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text('Convert'),
            ),

            // Display the result
            Text(result),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(history[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
