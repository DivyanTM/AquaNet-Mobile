import 'package:flutter/material.dart';

class SummaryContent extends StatefulWidget {
  const SummaryContent({super.key});

  @override
  State<SummaryContent> createState() => _SummaryContentState();
}

class _SummaryContentState extends State<SummaryContent> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Row(
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
        SizedBox(height: 30),
        // Divider(),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                "Average",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(width: 30),
              Text(
                "21°C",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                "Range",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(width: 30),
              Text(
                "20°C - 30°C",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
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
