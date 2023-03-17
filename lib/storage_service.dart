import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String filepath, String fileName, String folder) async {
    File file = File(filepath);
    try {
      await storage.ref("Files/$folder/$fileName").putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print("Errror happpened");
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('Files').listAll();
    results.items.forEach((firebase_storage.Reference ref) {
      print("found file:$ref");
    });
    return results;
  }

  Future<String> downloadURL(String imageName, String Folder) async {
    String DownloadURL =
        await storage.ref("Files/$Folder/$imageName").getDownloadURL();

    return DownloadURL;
  }
}
