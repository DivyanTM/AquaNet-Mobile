class SensorRecord {
  final double ph;
  final double temperature;
  final double turbidity;
  final double conductivity;
  final DateTime timestamp;

  SensorRecord({
    required this.ph,
    required this.temperature,
    required this.turbidity,
    required this.conductivity,
    required this.timestamp,
  });

  factory SensorRecord.fromJson(Map<String, dynamic> json) {
    return SensorRecord(
      ph: (json['ph'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
      turbidity: (json['turbidity'] as num).toDouble(),
      conductivity: (json['conductivity'] as num).toDouble(),
      timestamp: DateTime.parse(json['createdAt']),
    );
  }
}
