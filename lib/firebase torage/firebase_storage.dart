import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
String imageUrl = "";
Future<String> uploadPic({required File imagefile}) async {
  Reference reference = _storage.ref().child(imagefile.path);
  UploadTask uploadTask = reference.putFile(imagefile);
  await uploadTask.whenComplete(() async {
    try {
      imageUrl = await reference.getDownloadURL();
    } catch (e) {
      print(e);
    }
  });
  print("imageurl");
  print(imageUrl);
  return imageUrl;
}
