import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceDetailsPage extends StatefulWidget {
  final Device device;
  final VoidCallback onUpdate;

  const DeviceDetailsPage({
    super.key,
    required this.device,
    required this.onUpdate,
  });

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsPageState();
}

class _DeviceDetailsPageState extends State<DeviceDetailsPage> {
  late double _level;

  @override
  void initState() {
    super.initState();
    _level = widget.device.level;
  }

  IconData _icon(String type) {
    switch (type) {
      case "Light":
        return Icons.lightbulb;
      case "Fan":
        return Icons.toys;
      case "AC":
        return Icons.ac_unit;
      case "Camera":
        return Icons.videocam;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.device;

    return Scaffold(
      appBar: AppBar(
        title: Text(d.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Icon(_icon(d.type), size: 100, color: d.isOn ? Colors.indigo : Colors.grey),
            const SizedBox(height: 20),

            Text("Status: ${d.isOn ? 'ON' : 'OFF'}",
                style: TextStyle(color: d.isOn ? Colors.green : Colors.red, fontSize: 18)),

            const SizedBox(height: 20),

            if (d.type != "Camera")
              Slider(
                value: _level,
                min: 0,
                max: 100,
                onChanged: (v) {
                  setState(() {
                    _level = v;
                    d.level = v;
                  });
                  widget.onUpdate();
                },
              ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  d.isOn = !d.isOn;
                });
                widget.onUpdate();
              },
              child: Text(d.isOn ? "TURN OFF" : "TURN ON"),
            )
          ],
        ),
      ),
    );
  }
}
