import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class SupervisorDetailPage extends StatefulWidget {
  const SupervisorDetailPage({super.key});

  @override
  State<SupervisorDetailPage> createState() => _SupervisorDetailPageState();
}

class _SupervisorDetailPageState extends State<SupervisorDetailPage> with TickerProviderStateMixin {
  int heartRate = 75;
  double bloodSugar = 110;
  int systolicBP = 120;
  int diastolicBP = 80;
  int caloriesBurned = 350;
  double insulinLevel = 12.5;
  Timer? _timer;
  late AnimationController _heartController;
  late AnimationController _sugarController;
  late AnimationController _bpController;
  late AnimationController _caloriesController;
  late AnimationController _insulinController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(vsync: this, duration: Duration(seconds: 1))..repeat(reverse: true);
    _sugarController = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat(reverse: true);
    _bpController = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat(reverse: true);
    _caloriesController = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat(reverse: true);
    _insulinController = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat(reverse: true);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        heartRate = 65 + Random().nextInt(30);
        bloodSugar = 90 + Random().nextDouble() * 40;
        systolicBP = 110 + Random().nextInt(20);
        diastolicBP = 70 + Random().nextInt(15);
        caloriesBurned = 200 + Random().nextInt(400); // 200-600
        insulinLevel = 5 + Random().nextDouble() * 20; // 5-25
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _heartController.dispose();
    _sugarController.dispose();
    _bpController.dispose();
    _caloriesController.dispose();
    _insulinController.dispose();
    super.dispose();
  }

  Widget _metricCard({
    required String title,
    required String value,
    required String explanation,
    required Widget animatedVisual,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            animatedVisual,
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(fontSize: 16, color: Colors.blue[700], fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  Text(explanation, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Medical Status'),
        backgroundColor: Color(0xff5D83DD),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          _metricCard(
            title: 'Heart Rate',
            value: '$heartRate bpm',
            explanation: 'Heart rate is the number of heartbeats per minute. Normal range: 60-100 bpm.',
            animatedVisual: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _heartController, curve: Curves.easeInOut)),
              child: Icon(Icons.favorite, color: Colors.red, size: 40),
            ),
          ),
          _metricCard(
            title: 'Blood Sugar',
            value: '${bloodSugar.toStringAsFixed(0)} mg/dL',
            explanation: 'Blood sugar indicates the amount of glucose in the blood. Normal fasting: 70-130 mg/dL.',
            animatedVisual: AnimatedBuilder(
              animation: _sugarController,
              builder: (context, child) {
                double width = 40 + 20 * _sugarController.value;
                return Container(
                  width: width,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.opacity, color: Colors.white, size: 18),
                  ),
                );
              },
            ),
          ),
          _metricCard(
            title: 'Blood Pressure',
            value: '$systolicBP/$diastolicBP mmHg',
            explanation: 'Blood pressure is the force of blood against artery walls. Normal: ~120/80 mmHg.',
            animatedVisual: AnimatedBuilder(
              animation: _bpController,
              builder: (context, child) {
                double barHeight = 24 + 8 * _bpController.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: Colors.orange[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 4),
                    Icon(Icons.bloodtype, color: Colors.orange[700], size: 18),
                  ],
                );
              },
            ),
          ),
          _metricCard(
            title: 'Calories Burned',
            value: '$caloriesBurned kcal',
            explanation: 'Calories burned is the total energy expended by the body. Typical daily range: 1500-3000 kcal.',
            animatedVisual: AnimatedBuilder(
              animation: _caloriesController,
              builder: (context, child) {
                double flameSize = 28 + 8 * _caloriesController.value;
                return Icon(Icons.local_fire_department, color: Colors.deepOrange, size: flameSize);
              },
            ),
          ),
          _metricCard(
            title: 'Insulin Level',
            value: '${insulinLevel.toStringAsFixed(1)} μIU/mL',
            explanation: 'Insulin is a hormone that regulates blood sugar. Normal fasting: 2-25 μIU/mL.',
            animatedVisual: AnimatedBuilder(
              animation: _insulinController,
              builder: (context, child) {
                double dropHeight = 28 + 8 * _insulinController.value;
                return Icon(Icons.water_drop, color: Colors.teal, size: dropHeight);
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
} 