import 'package:farmy/constants.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future<dynamic> upload(File imageFile) async {
    final params = {
      "api_key": API_KEY,
    };
    final Uri uri = Uri.https(
        "detect.roboflow.com", "/plant_disease_classifier3/1", params);

    // open a bytestream
    /*var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));*/
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    // print(response.statusCode);

    // Check if the response status code is OK (200) before decoding
    if (response.statusCode == 200) {
      var jsonValue = await http.Response.fromStream(response);
      var jsonData = jsonDecode(jsonValue.body);
      return jsonData["predictions"][0]["class"];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }
}
