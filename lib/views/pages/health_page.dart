import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health'),
      ),
      body: Center(
        child: Text('Health Page Content'),
      ),
    );
  }
}