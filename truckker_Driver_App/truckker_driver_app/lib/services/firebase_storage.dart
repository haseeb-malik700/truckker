import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  String kTestString='';
  Future<void> _uploadFile(File input) async {

    await input.writeAsString(kTestString);
    assert(await input.readAsString() == kTestString);
//    final StorageUploadTask uploadTask = ref.putFile(
//      input,
//      StorageMetadata(
//        contentLanguage: 'en',
//        customMetadata: <String, String>{'activity': 'test'},
//      ),
//    );
}