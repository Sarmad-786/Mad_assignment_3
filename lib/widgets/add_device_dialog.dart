import 'package:flutter/material.dart';
import '../models/device.dart';

class AddDeviceDialog extends StatefulWidget {
  final Function(Device) onAdd;

  const AddDeviceDialog({super.key, required this.onAdd});

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _roomCtrl = TextEditingController();
  String _type = "Light";
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Device"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: "Device Name"),
          ),
          TextField(
            controller: _roomCtrl,
            decoration: const InputDecoration(labelText: "Room Name"),
          ),
          DropdownButtonFormField(
            value: _type,
            items: const [
              DropdownMenuItem(value: "Light", child: Text("Light")),
              DropdownMenuItem(value: "Fan", child: Text("Fan")),
              DropdownMenuItem(value: "AC", child: Text("AC")),
              DropdownMenuItem(value: "Camera", child: Text("Camera")),
            ],
            onChanged: (v) => _type = v!,
          ),
          Row(
            children: [
              const  Text("Status: "),
              Switch(
                value: _isOn,
                onChanged: (v) => setState(() => _isOn = v),
              )
            ],
          )
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            widget.onAdd(
              Device(name: _nameCtrl.text, type: _type, room: _roomCtrl.text, isOn: _isOn),
            );
            Navigator.pop(context);
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}
