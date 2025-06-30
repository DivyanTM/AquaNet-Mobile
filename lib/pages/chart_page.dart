import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../models/sensor_record.dart';
import '../services/sensor_data_service.dart';
import '../widgets/line_chart.dart';
import 'package:aquanet_mobile/widgets/summary.dart';
import 'package:aquanet_mobile/widgets/custom_list_item.dart';
import 'package:flutter/services.dart';

class DetailsPage extends StatefulWidget {
  final String param;
  final String value;
  final IconData icon;

  const DetailsPage({
    super.key,
    required this.param,
    required this.value,
    required this.icon,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DataService dataService = DataService();

  Map<String, dynamic> limits = {
    "Temperature": {"min": 20, "max": 30, "margin": 1.0},
    "pH": {"min": 6.5, "max": 8.5, "margin": 0.5},
    "Conductivity": {"min": 300, "max": 800, "margin": 20.0},
    "Turbidity": {"min": 1, "max": 5, "margin": 1.0},
  };

  List<SensorRecord> historyRecords = [];

  Future<void> _fetchHistory() async {
    final List<dynamic> history = await dataService.fetchAll();

    final records = history
        .map((item) => SensorRecord.fromJson(item as Map<String, dynamic>))
        .toList();

    setState(() {
      historyRecords = records;
    });
  }

  List<FlSpot> getSpots(List<SensorRecord> records, String param) {
    return records
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final record = entry.value;

          double? value;
          if (param == "Temperature") {
            value = record.temperature.toDouble();
          } else if (param == "Turbidity") {
            value = record.turbidity.toDouble();
          } else if (param == "pH") {
            value = record.ph.toDouble();
          } else if (param == "Conductivity") {
            value = record.conductivity.toDouble();
          }

          if (value == null || value.isNaN || !value.isFinite) return null;

          return FlSpot(index.toDouble(), value);
        })
        .whereType<FlSpot>()
        .toList(); // removes nulls
  }

  List<FlSpot> getChartData(String param) {
    return historyRecords
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final record = entry.value;

          double value;
          switch (param) {
            case 'temperature':
              value = (record.temperature as num?)?.toDouble() ?? double.nan;
              break;
            case 'ph':
              value = (record.ph as num?)?.toDouble() ?? double.nan;
              break;
            case 'turbidity':
              value = (record.turbidity as num?)?.toDouble() ?? double.nan;
              break;
            case 'conductivity':
              value = (record.conductivity as num?)?.toDouble() ?? double.nan;
              break;
            default:
              value = double.nan;
          }

          return FlSpot(index.toDouble(), value);
        })
        .where((spot) => spot.y.isFinite)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: const Color(0xFFFDFDFB),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    _fetchHistory();
  }

  String formatSimpleDate(String isoString) {
    final dateTime = DateTime.parse(isoString).toLocal();

    final year = dateTime.year;
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    return "$day-$month-$year, $hour12:$minute $amPm";
  }

  String getStatus({
    required double value,
    required double lowerLimit,
    required double upperLimit,
    double margin = 1.0,
  }) {
    if (value >= lowerLimit && value <= upperLimit) {
      return "Good";
    }
    if ((value >= lowerLimit - margin && value < lowerLimit) ||
        (value > upperLimit && value <= upperLimit + margin)) {
      return "Moderate";
    }
    if (value > upperLimit) {
      return "High";
    }
    return "Poor";
  }

  Color getStatusColor(String status) {
    if (status == "Good") {
      return Colors.greenAccent;
    } else if (status == "Moderate") {
      return Colors.orangeAccent;
    }
    return Colors.redAccent;
  }

  double getRecordValue(SensorRecord record, String param) {
    switch (param) {
      case "Temperature":
        return record.temperature;
      case "Turbidity":
        return record.turbidity;
      case "Conductivity":
        return record.conductivity;
      case "pH":
        return record.ph;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartData = getSpots(historyRecords, widget.param);
    print("Generated chart data for ${widget.param}: $chartData");

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),
      backgroundColor: const Color(0xFFFDFDFB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      FeatherIcons.chevronLeft,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.param,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.param == "Temperature"
                              ? FeatherIcons.thermometer
                              : widget.param == "Turbidity"
                              ? FeatherIcons.droplet
                              : widget.param == "Conductivity"
                              ? FeatherIcons.zap
                              : Icons.science_outlined,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.value,
                          style: TextStyle(
                            fontSize: 75,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          // "°C",
                          widget.param == "Temperature"
                              ? "°C"
                              : widget.param == "Turbidity"
                              ? "NTU"
                              : widget.param == "Conductivity"
                              ? "µS/cm"
                              : "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      getStatus(
                        value: double.parse(
                          widget.value.replaceAll(RegExp(r'[^0-9.]'), ''),
                        ),
                        lowerLimit: (limits[widget.param]['min'] as num)
                            .toDouble(),
                        upperLimit: (limits[widget.param]['max'] as num)
                            .toDouble(),
                        margin: limits[widget.param]['margin'],
                      ),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w200,
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Min : ${limits[widget.param]['min']}",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 50),
                        Text(
                          "Max : ${limits[widget.param]['max']}",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SummaryContent(
                      average: widget.value,
                      min: limits[widget.param]['min'].toDouble(),
                      max: limits[widget.param]['max'].toDouble(),
                      param: widget.param,
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      height: 400,
                      child: LineChartWidget(dataPoints: chartData),
                    ),
                    SizedBox(height: 70),
                    Row(
                      children: [
                        Text(
                          "History",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                      itemCount: historyRecords.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // itemBuilder: (context, index) => MinimListItem(
                      //   title: "25",
                      //   status: "Average",
                      //   date: "2025-06-31 13:34 25",
                      //   unit: "°C",
                      // ),
                      itemBuilder: (context, index) {
                        final record = historyRecords[index];
                        final value = getRecordValue(record, widget.param);

                        return MinimListItem(
                          title: "$value",
                          status: getStatus(
                            value: value,
                            lowerLimit: (limits[widget.param]['min'] as num)
                                .toDouble(),
                            upperLimit: (limits[widget.param]['max'] as num)
                                .toDouble(),
                          ),
                          date: formatSimpleDate(
                            record.timestamp.toIso8601String(),
                          ),
                          unit: widget.param == "Temperature"
                              ? "°C"
                              : widget.param == "Turbidity"
                              ? "NTU"
                              : widget.param == "Conductivity"
                              ? "µS/cm"
                              : widget.param == "pH"
                              ? ""
                              : "",
                        );
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
