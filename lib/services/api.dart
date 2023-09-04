import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  upload(File imageFile) async {
    final params = {
      "api_key": "1aUytlKd2gJXUZSDSJZO",
    };
    final Uri uri = Uri.https(
        "detect.roboflow.com", "/plant_disease_classifier3/1", params);

    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
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
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      var jsonValue = jsonDecode(value);
      print(jsonValue["predictions"]);
    });
  }
}
