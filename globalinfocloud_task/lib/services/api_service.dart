import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, String>> getCityState(String pinCode) async {
    final response = await http.get(
      Uri.parse('http://www.postalpincode.in/api/pincode/$pinCode'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Status'] == 'Success') {
        return {
          'city': data['PostOffice'][0]['District'],
          'state': data['PostOffice'][0]['State'],
        };
      } else {
        throw Exception('Invalid Pin Code');
      }
    } else {
      throw Exception('Failed to load city and state');
    }
  }
}
