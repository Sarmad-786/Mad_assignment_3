class Device {
  String name;
  String type;
  String room;
  bool isOn;
  double level;

  Device({
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.level = 50.0,
  });
}
