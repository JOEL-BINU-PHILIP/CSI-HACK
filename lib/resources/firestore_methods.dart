import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class FireStoreMethods {
  Future<String> uploadImage(Uint8List imageBytes) async {
    String res = 'Some error occurred';
    try {
      // Encode image bytes to base64
      String base64Image = base64Encode(imageBytes);

      // Make HTTP POST request to your endpoint
      var response = await http.post(
        Uri.parse('https://karthiksagar.us-east-1.modelbit.com/v1/final_model/latest'),
        body: jsonEncode({'data': base64Image}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Parse JSON response
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Access the value of the "data" key
      String responseData = jsonResponse['data'];

      // Return the extracted data
      return responseData;
    } catch (e) {
      print(e.toString());
      return res;
    }
  }
}

