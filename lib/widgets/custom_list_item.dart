import 'package:flutter/material.dart';

class MinimListItem extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String unit;

  const MinimListItem({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${title} ${unit}",
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        "$date",
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: status == "Good"
              ? Colors.green.withOpacity(0.1)
              : status == "Average"
              ? Colors.orangeAccent.withOpacity(0.1)
              : Colors.redAccent.withOpacity(0.1),
        ),
        child: Text(
          "$status",
          style: TextStyle(
            color: status == "Good"
                ? Colors.green
                : status == "Average"
                ? Colors.orangeAccent
                : Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
