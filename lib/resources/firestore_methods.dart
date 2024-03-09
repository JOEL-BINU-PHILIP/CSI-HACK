import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:csi_hackathon/models/post_model.dart';
// import 'package:csi_hackathon/resources/storage_methods.dart';
// import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FireStoreMethods {
  String result = 'result';
  Future<String> uploadImage(Uint8List imageBytes) async {
    // Encode image bytes to base64
    String res = 'some Error occured';
    try {
      String base64Image = base64Encode(imageBytes);
      print(base64Image);
      // Make HTTP POST request
      var response = await http.post(
        Uri.parse(
            'https://karthiksagar.us-east-1.modelbit.com/v1/final_model/latest'),
        body: jsonEncode({'data': base64Image}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Handle response here
      print("========================================${response.body}");
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Access the value of the "response" key
      String botResponse = jsonResponse['response'];
      // Print or return the bot response
      print("Bot response: $botResponse");
      res = "success";
      print(res);
      return botResponse;
    } catch (e) {
      print(e.toString());
      return res;
    }
  }
}