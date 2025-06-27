import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class SupervisorHealthIndicator extends StatefulWidget {
  const SupervisorHealthIndicator({super.key});

  @override
  State<SupervisorHealthIndicator> createState() => _SupervisorHealthIndicatorState();
}

class _SupervisorHealthIndicatorState extends State<SupervisorHealthIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heartRateAnimation;
  int heartRate = 72;
  double bloodSugar = 110;
  String healthCondition = 'Good';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _heartRateAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Simulate changing data
    _simulateData();
  }

  void _simulateData() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;
      setState(() {
        heartRate = 65 + Random().nextInt(30); // 65-95
        bloodSugar = 90 + Random().nextDouble() * 40; // 90-130
        healthCondition = (heartRate < 80 && bloodSugar < 120) ? 'Good' : (heartRate < 90 ? 'Moderate' : 'Alert');
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Color get healthColor {
    switch (healthCondition) {
      case 'Good':
        return Colors.green;
      case 'Moderate':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Supervisor Icon
        Icon(Icons.supervisor_account, size: 48, color: Color(0xff5D83DD)),
        const SizedBox(height: 8),
        // Heart Rate
        ScaleTransition(
          scale: _heartRateAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              const SizedBox(width: 4),
              Text('$heartRate bpm', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Blood Sugar
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 60,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue[100],
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: (bloodSugar / 150) * 60, // max 150
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Text('${bloodSugar.toStringAsFixed(0)} mg/dL', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        // Health Condition
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: healthColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(healthCondition, style: TextStyle(fontSize: 13, color: healthColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
} 