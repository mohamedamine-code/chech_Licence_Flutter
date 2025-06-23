import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendLicenseData(
  String name,
  String expiryDate,
  String fcmToken,
) async {
  final url = Uri.parse('http://192.168.0.56:3000/notify');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'expiryDate': expiryDate,
        'fcmToken': fcmToken,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Server response: ${response.body}');
    } else {
      print('❌ Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    print('⚠️ Exception occurred: $e');
  }
}
