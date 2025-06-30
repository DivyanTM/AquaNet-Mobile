import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HistoryTile extends StatelessWidget {
  final String title;
  final String ph;
  final String temperature;
  final String conductivity;
  final String turbidity;
  final String datetime;

  const HistoryTile({
    super.key,
    required this.title,
    required this.ph,
    required this.temperature,
    required this.conductivity,
    required this.turbidity,
    required this.datetime,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        "${datetime}",
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      children: [
        Row(
          children: [
            Icon(FeatherIcons.thermometer),
            SizedBox(width: 5),
            Text(
              "Temperature : ",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
            ),
            Text(
              temperature,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.science_outlined),
            SizedBox(width: 5),
            Text("Ph : ", style: TextStyle(fontFamily: 'Roboto', fontSize: 15)),
            Text(
              ph,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(FeatherIcons.droplet),
            SizedBox(width: 5),
            Text(
              "Turbidity : ",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
            ),
            Text(
              turbidity,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(FeatherIcons.zap),
            SizedBox(width: 5),
            Text(
              "Conductivity : ",
              style: TextStyle(fontFamily: 'Roboto', fontSize: 15),
            ),
            Text(
              conductivity,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
