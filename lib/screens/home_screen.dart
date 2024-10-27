import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDeviceOn = false;
  double _energyConsumption = 0.0;
  Timer? _dataTimer;

  @override
  void initState() {
    super.initState();
    // Initialize the periodic timer when device is turned on
    _startEnergyUpdate();
  }

  @override
  void dispose() {
    _dataTimer?.cancel();
    super.dispose();
  }

  void _toggleDevicePower() {
    setState(() {
      _isDeviceOn = !_isDeviceOn;
    });

    if (_isDeviceOn) {
      _startEnergyUpdate();
    } else {
      _dataTimer?.cancel(); // Stop energy consumption update when device is off
    }
  }

  void _startEnergyUpdate() {
    // Ensure any existing timer is canceled before starting a new one
    _dataTimer?.cancel();

    _dataTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_isDeviceOn) {
        setState(() {
          _energyConsumption = (_energyConsumption + 0.5) % 100; // Mock data
        });
      }
    });
  }

  void _setTimer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Set Timer"),
        content: const Text("Timer set for 1 hour."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stromleser',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Energy Monitoring and Device Control',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Device Control Section
            Card(
              color: Colors.deepPurple[700],
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text(
                      'Device Control',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon:
                              Icon(_isDeviceOn ? Icons.power_off : Icons.power),
                          label: Text(_isDeviceOn ? 'Turn Off' : 'Turn On'),
                          onPressed: _toggleDevicePower,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.timer),
                          label: const Text('Timer'),
                          onPressed: _setTimer,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Energy Data Section
            Expanded(
              child: Card(
                color: Colors.deepPurple[800],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Energy Consumption',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${_energyConsumption.toStringAsFixed(1)} kWh',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Updated: ${DateTime.now().toLocal().toString().split(' ')[1]}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
