import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:universal_io/io.dart' as IO;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FuncImage with ChangeNotifier {
  // List<Marker> mark = [];

  List<DropdownMenuItem<String>> owner = [];

  File? image;
  final picker = ImagePicker();
  File? selectedFile;




  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void askPermissionCamera() {
    requestPermission(Permission.camera).then(onStatusRequestedCamera);
  }

  void askPermissionStorage() {
    requestPermission(Permission.storage).then(onStatusRequested);
  }

  void askPermissionPhotos() {
    requestPermission(Permission.photos).then(onStatusRequested);
  }

  void onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isIOS) {
        openAppSettings();
      } else {
        if(status == PermissionStatus.permanentlyDenied){
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.gallery);
    }
  }

  void onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (IO.Platform.isIOS) {
        openAppSettings();
      } else {
        if(status == PermissionStatus.permanentlyDenied){
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.camera);
    }
  }

  void getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if(image != null){
      File? cropped = await ImageCropper.cropImage(
          sourcePath: image!.path,
          aspectRatio: const CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          cropStyle:CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarColor: Colors.white,
            toolbarTitle: 'Edit Images',
            statusBarColor: Color(0xFF0181cc),
            activeControlsWidgetColor: Color(0xFF515151),
            cropFrameColor: Colors.white,
            cropGridColor: Colors.white,
            toolbarWidgetColor: Color(0xFF515151),
            backgroundColor: Colors.white,
          )
      );
      if(cropped!=null){
        if(selectedFile!=null && selectedFile!.existsSync()){
          selectedFile!.deleteSync();
        }
        selectedFile = cropped;
      }

      // delete image camera
      if(source.toString()=='ImageSource.camera' && image!.existsSync()){
        image!.deleteSync();
      }

      image = null;
    }
    notifyListeners();
  }


//   Future getImage(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
// // Pick an image
//     final XFile? image = await _picker.pickImage(source: source);
// //TO convert Xfile into file
//     file = File(image!.path);
//     notifyListeners();
//
// //print(‘Image picked’);
//     return file;
//   }


  uploadShop(
      Map<String, String> data,
      File file,
      ) async {
    var request = MultipartRequest(
        'POST', Uri.parse("https://ibtikarsoft.net/mapapi/shop_add.php"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

  uploadOwner(
      Map<String, String> data,
      File file,
      ) async {
    var request = MultipartRequest(
        'POST', Uri.parse("https://ibtikarsoft.net/mapapi/owners_add.php"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

}
