import 'dart:developer';

import 'package:http/http.dart' as http;
import 'constants.dart';

import 'dart:convert'; // Import this for jsonEncode

class ApiService {
  Future<String?> getChat(String text) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.chatEndpoint);
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'user_query': text}));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        log('Failed to load chat: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
