import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class ApiService {
  Future<Map<String, dynamic>> getAffirmation() async {
    try {
      final response = await get(
        Uri.parse(
          'https://affirmations-api-by-apirobots.p.rapidapi.com/v1/affirmations/random',
        ),
        headers: {
          'x-rapidapi-key':
              'f821d1ea07msh04c20445d0a3c18p11087djsnd4c65fdfd14a',
          'x-rapidapi-host': 'affirmations-api-by-apirobots.p.rapidapi.com',
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
  
        return json;
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('ApiService: ${e.toString()}');
      rethrow;
    }
  }
}
