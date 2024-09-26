import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> uploadData(String path, Uint8List data) async {
  try {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final metadata = SettableMetadata(contentType: mime(path));
    final result = await storageRef.putData(data, metadata);
    print(path);
    inspect(result);
    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> uploadImage(
    String fileName, File imageFile, String folder) async {
  try {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$folder/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    final upload = await uploadTask;
    String imageUrl = await upload.ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    return "";
  }
}
