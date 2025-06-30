import 'package:flutter/material.dart';

class SummaryContent extends StatefulWidget {
  final String average;
  final double min;
  final double max;
  final String param;

  const SummaryContent({
    super.key,
    required this.average,
    required this.min,
    required this.max,
    required this.param,
  });

  @override
  State<SummaryContent> createState() => _SummaryContentState();
}

class _SummaryContentState extends State<SummaryContent> {
  String unit = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.param == "Temperature") {
        unit = "°C";
      } else if (widget.param == "Turbidity") {
        unit = "NTU";
      } else if (widget.param == "Conductivity") {
        unit = "µS/cm";
      } else {
        unit = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Row(
          children: [
            Text(
              "Summary",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Divider(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const Text(
                "Average",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(width: 30),
              Text(
                "${widget.average} $unit",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const Text(
                "Range",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(width: 30),
              Text(
                "${widget.min} $unit - ${widget.max} $unit",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                "Last Updated",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(width: 30),
              Text(
                "Just Now",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
