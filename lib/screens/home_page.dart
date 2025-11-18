import 'package:flutter/material.dart';
import '../models/device.dart';
import '../screens/device_details_page.dart';
import '../widgets/add_device_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Device> _devices = [
    Device(name: "Living Room Light", type: "Light", room: "Living Room", isOn: true),
    Device(name: "Bedroom Fan", type: "Fan", room: "Bedroom"),
    Device(name: "Kitchen AC", type: "AC", room: "Kitchen"),
    Device(name: "Door Camera", type: "Camera", room: "Entrance", isOn: true),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Dashboard"),
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
          )
        ],
      ),

      // MAIN BODY
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85, // FIXED to avoid overflow
        ),
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final d = _devices[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeviceDetailsPage(
                    device: d,
                    onUpdate: () => setState(() {}),
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _icon(d.type),
                      size: 35,
                      color: d.isOn ? Colors.indigo : Colors.grey,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      d.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    Text(
                      d.room,
                      style: const TextStyle(fontSize: 12),
                    ),

                    Switch(
                      value: d.isOn,
                      onChanged: (v) {
                        setState(() {
                          d.isOn = v;
                        });
                      },
                    ),

                    Text(
                      d.isOn ? "ON" : "OFF",
                      style: TextStyle(
                        color: d.isOn ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // ADD DEVICE BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddDeviceDialog(
              onAdd: (device) {
                setState(() {
                  _devices.add(device);
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
