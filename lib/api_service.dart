import 'dart:developer';
import 'dart:ffi';

import 'package:green_cart/models/barcodeDetails.dart';
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

  Future<BarcodeDetails> getBarcode(int barcode, String user_id) async {
    try {
      // int? barcode = int.tryParse(barcode);
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.barcodeEndpoint);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': user_id,
            'barcode': barcode,
          }));
      // var data = jsonDecode(response.body.toString());

      if (response.statusCode == 201) {
        // if (barcode != null){
        // String _barcode = barcodeDetailsToJson(response.body as BarcodeDetails);
        return BarcodeDetails.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        // } else {
        //   log('Invalid barcode: $barcode');
        // }
      } else {
        log('Failed to load barcode details: ${response.statusCode}');
        throw Exception('Failed to create album.');
        // return null;
      }
    } catch (e) {
      log('Error: $e');
      // return null;
    }
    // return null;
    throw Exception('Failed to create album.');
  }

  Future<int> addUser(
      String? id, String? name, String? email, String? imageUrl) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint);
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': id,
            'name': name,
            'email': email,
            'image_url': imageUrl,
          }));
      if (response.statusCode == 200) {
        log('User added: ${response.statusCode}');
        return 200;
      } else {
        log('Failed to add user: ${response.statusCode}');
        return 400;
      }
    } catch (e) {
      log('Error: $e');
      return 400;
    }
  }
}
