
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchBorrowObjectList() async {

  final response = await http.get(Uri.parse('https://13.232.61.146/loggedin/BorrowObject/list'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}
