import 'package:flutter/material.dart';
import 'package:aquanet_mobile/pages/chart_page.dart';

class SensorBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color textcolor;

  const SensorBox({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              param: title,
              value: value.replaceAll(RegExp(r'[^0-9.]'), ''),
              icon: icon,
            ),
          ),
        );
      },
      child: Container(
        width: 170,
        height: 100,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black87),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    color: textcolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
