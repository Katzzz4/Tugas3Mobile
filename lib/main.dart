import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorBMIApp());
}

class KalkulatorBMIApp extends StatelessWidget {
  const KalkulatorBMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalkulator BMI",
      debugShowCheckedModeBanner: false,
      home: const KalkulatorBMIScreen(),
    );
  }
}

class KalkulatorBMIScreen extends StatefulWidget {
  const KalkulatorBMIScreen({super.key});

  @override
  State<KalkulatorBMIScreen> createState() => _KalkulatorBMIScreenState();
}

class _KalkulatorBMIScreenState extends State<KalkulatorBMIScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _genderController = TextEditingController();

  double? _bmiResult;
  String? _bmiInterpretation = "Silahkan masukkan data anda!";
  String? _generInterpretation = "";
  Color _resultColor = Colors.white;

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCm = double.tryParse(_heightController.text) ?? 0;
    final String gender = _genderController.text.toLowerCase() ?? "";

    setState(() {
      if (gender == "l"){
        if (weight > 0 && heightInCm > 0) {
          final double heightInM = heightInCm / 100;
          final double bmi = weight / (heightInM * heightInM);
          _bmiResult = bmi;
          if (bmi < 18.5) {
            _bmiInterpretation = "Kekurangan berat badan";
            _resultColor = Colors.yellow;
          } else if (bmi < 25) {
            _bmiInterpretation = "Berat badan normal";
            _resultColor = Colors.green;
          } else if (bmi < 30) {
            _bmiInterpretation = "Kelebihan berat badan";
            _resultColor = Colors.orange;
          } else {
            _bmiInterpretation = "Obesitas";
            _resultColor = Colors.red;
          }
        } else {
          _bmiResult = null;
          _bmiInterpretation = "Silahkan masukkan data yang valid!";
        }
      }else if (gender == "p"){
        if (weight > 0 && heightInCm > 0) {
          final double heightInM = heightInCm / 100;
          final double bmi = weight / (heightInM * heightInM);
          _bmiResult = bmi;
          if (bmi < 17) {
            _bmiInterpretation = "Kekurangan berat badan";
            _resultColor = Colors.yellow;
          } else if (bmi < 23.9) {
            _bmiInterpretation = "Berat badan normal";
            _resultColor = Colors.green;
          } else if (bmi < 27) {
            _bmiInterpretation = "Kelebihan berat badan";
            _resultColor = Colors.orange;
          } else {
            _bmiInterpretation = "Obesitas";
            _resultColor = Colors.red;
          }
        } else {
          _bmiResult = null;
          _bmiInterpretation = "Silahkan masukkan data yang valid!";
        }
      }else{
        _generInterpretation = "Jenis kelamin tidak valid!";
      }    
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _genderController.clear();
      _bmiResult = null;
      _bmiInterpretation = "Silahkan masukkan data anda!";
      _generInterpretation = "";
      _resultColor = Colors.white;
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator BMI",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[500]!, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          labelText: "Berat Badan (kg)",
                          icon: Icon(Icons.monitor_weight, color: Colors.indigo),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          labelText: "Tinggi Badan (cm)",
                          icon: Icon(Icons.height, color: Colors.indigo),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _genderController.text = "L";
                              });
                            },
                            icon: Icon(Icons.male),
                            label: Text("Laki-laki"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _genderController.text == "L" 
                                  ? Colors.indigo 
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _genderController.text = "P";
                              });
                            },
                            icon: Icon(Icons.female),
                            label: Text("Perempuan"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _genderController.text == "P" 
                                  ? Colors.indigo 
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _calculateBMI,
                    icon: Icon(Icons.calculate),
                    label: Text("Hitung BMI"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetFields,
                    icon: Icon(Icons.refresh),
                    label: Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Card(
                elevation: 5,
                color: _resultColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Hasil BMI",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _bmiResult?.toStringAsFixed(1) ?? "--",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _bmiInterpretation ?? "",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _generInterpretation ?? "",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}