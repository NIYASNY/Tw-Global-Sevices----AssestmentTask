import 'dart:convert';

import 'package:http/http.dart' as http;

class ImageService {
  static const String apikey = '43430374-567e4be09acb5f2a72a39357f';
  static const String baseUrl = 'https://pixabay.com/api/';


  Future<List<Map<String, dynamic>>> getImages() async {
    final response = await http.get(Uri.parse("$baseUrl?key=$apikey"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['hits']);
    } else {
      throw Exception("Failed to load images");
    }
  }
}
