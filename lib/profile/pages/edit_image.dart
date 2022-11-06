import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 60.0,right: 60.0),
            child: const SizedBox(
                width: 330,
                child: Text(
                  "Upload a photo of yourself:",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          p.selectedFile == null
              ? Padding(
                padding: const EdgeInsets.only(top: 50.0,left: 125.0,),
                child: CircleAvatar(
                    radius: 83,
                    backgroundColor: const Color(0xff14be77),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: ResizeImage(
                          NetworkImage(p.dataProfile['image']),
                          width: 120,
                          height: 120),
                    ),
                  ),
              )
              : Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 125.0,),
                child: CircleAvatar(
                    radius: 83,
                    backgroundColor: const Color(0xff14be77),
                    child: CircleAvatar(
                      radius: 80,
                      // child: ClipRect(
                      //   child: Image.file(p.file!),
                      // ),
                      //  backgroundImage:FileImage(p.file!),
                      backgroundImage: ResizeImage(FileImage(p.selectedFile!),
                          width: 120, height: 120),
                    ),
                  ),
              ),
          Padding(
            padding: const EdgeInsets.only(top: 170.0,left: 240.0,),
            child: IconButton(
                onPressed: () {
                  showPopupDeleteFavorite(context);
                },
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xffFD8F11),
                  ),
                )),
          ),
          Padding(
              padding: const EdgeInsets.only(top:300,left: 45),
              child: SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    p.updateProfileWithImage(p.selectedFile != null ? p.selectedFile!.path :p.dataProfile['image'],).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())));
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void showPopupDeleteFavorite(BuildContext context) {
    var p = Provider.of<Funcprovider>(context, listen: false);

    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          p.askPermissionCamera();
        },
        child: const Text('Camera', style: TextStyle(color: Colors.black)));
    Widget continueButton = TextButton(
        onPressed: () {
          if (Platform.isAndroid) {
            p.askPermissionPhotos();
          } else {
            p.askPermissionStorage();
          }
        },
        child: const Text('Gallery', style: TextStyle(color: Colors.black)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'image',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
