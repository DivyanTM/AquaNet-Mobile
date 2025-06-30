import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aquanet_mobile/config/url_config.dart' as urlConfig;

class DataService {
  Map<String, dynamic> latestData = {};
  List<dynamic> history = [];
  List<dynamic> lastFew = [];

  final String baseUrl = urlConfig.url;

  Future<Map<String, dynamic>> fetchLatest() async {
    final url = Uri.parse('$baseUrl/sensor/latest');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final decoded = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        latestData = decoded;
        print("Latest data : $latestData");
        return decoded;
      } else {
        throw Exception(decoded['message'] ?? 'Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  Future<List<dynamic>> fetchAll() async {
    final url = Uri.parse('$baseUrl/sensor/all');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final decoded = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        if (decoded is List) {
          history = decoded;
          print("History : $history");
          return decoded;
        } else {
          throw Exception('Expected a list but got something else');
        }
      } else {
        throw Exception(decoded['message'] ?? 'Failed to fetch data');
      }
    } catch (err) {
      throw Exception('Network Error: $err');
    }
  }

  Future<List<dynamic>> getLastFew() async {
    final url = Uri.parse('$baseUrl/sensor/few');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      final decoded = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        if (decoded is List) {
          lastFew = decoded;
          print("Last Few : $lastFew");
          return decoded;
        } else {
          throw Exception('Expected a list but got something else');
        }
      } else {
        throw Exception(decoded['message'] ?? 'Failed to fetch data');
      }
    } catch (err) {
      throw Exception('Network Error: $err');
    }
  }

  int calculateWaterQualityScore({
    required double ph,
    required double temperature,
    required double conductivity,
    required double turbidity,
  }) {
    double score = 0;

    if (ph >= 6.5 && ph <= 8.5) {
      score += 25;
    } else {
      score += 25 - ((ph < 6.5) ? (6.5 - ph) * 5 : (ph - 8.5) * 5).clamp(0, 25);
    }

    if (temperature >= 20 && temperature <= 30) {
      score += 25;
    } else {
      score +=
          25 -
          ((temperature < 20)
                  ? (20 - temperature) * 2.5
                  : (temperature - 30) * 2.5)
              .clamp(0, 25);
    }

    if (conductivity <= 500) {
      score += 25;
    } else {
      score += (25 - ((conductivity - 500) / 20)).clamp(0, 25);
    }

    if (turbidity <= 5) {
      score += 25;
    } else {
      score += (25 - ((turbidity - 5) * 3)).clamp(0, 25);
    }

    return score.round().clamp(0, 100);
  }
}
