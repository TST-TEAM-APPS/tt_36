import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:tt_36/models/affirmation.dart';

class ApiService {
  Future<String> getAffirmation({required String category}) async {
    try {
      final response = await get(
        Uri.parse(
          'https://affirmations-api-by-apirobots.p.rapidapi.com/v1/affirmations/categories/$category/random',
        ),
        headers: {
          'x-rapidapi-key':
              'f821d1ea07msh04c20445d0a3c18p11087djsnd4c65fdfd14a',
          'x-rapidapi-host': 'affirmations-api-by-apirobots.p.rapidapi.com',
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json['text'] as String;
        return data;
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('ApiService: ${e.toString()}');
      rethrow;
    }
  }
}
