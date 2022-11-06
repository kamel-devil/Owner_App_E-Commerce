import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart' as IO;

import '../../components/components.dart';
import '../../provider/provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController servicetypeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  final ImagePicker _picker = ImagePicker();
  File? image;
  List<File> multipleImages = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);
    return Scaffold(
      backgroundColor: whiteOpactity,
      appBar: AppBar(
        leading: SizedBox(
          width: 45,
          height: 45,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: Material(
                  color: const Color(0xffFD8F11).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Products()));
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    color: const Color(0xffda6317),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 15, bottom: 10),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          p.selectedFile == null
                              ? const CircleAvatar(
                                  radius: 83,
                                  backgroundColor: Color(0xff14be77),
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: ResizeImage(
                                        AssetImage(ImageAssets.image),
                                        width: 120,
                                        height: 120),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 83,
                                  backgroundColor: const Color(0xff14be77),
                                  child: CircleAvatar(
                                    radius: 80,
                                    // child: ClipRect(
                                    //   child: Image.file(p.file!),
                                    // ),
                                    //  backgroundImage:FileImage(p.file!),
                                    backgroundImage: ResizeImage(
                                        FileImage(p.selectedFile!),
                                        width: 120,
                                        height: 120),
                                  ),
                                ),
                          IconButton(
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
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'New Service',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        label: 'Name Service',
                        prefix: Icons.person),

                    const SizedBox(
                      height: 15,
                    ),

                    defaultFormField(
                        controller: priceController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter sell_price';
                          }
                          return null;
                        },
                        label: 'sell_price',
                        prefix: Icons.price_change_outlined),
                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      'Categories Type :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showCupertinoModalPopup<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoActionSheet(
                                  actions: [
                                    SizedBox(
                                      height: 180,
                                      child: CupertinoDatePicker(
                                        initialDateTime: _dateTime,
                                        minimumYear: 2018,
                                        maximumYear: DateTime.now().year + 6,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (dateTime) {
                                          setState(() {
                                            _dateTime = dateTime;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    child: const Text('Done'),
                                    onPressed: () {
                                      final value = DateFormat('MMMM dd, yyyy')
                                          .format(_dateTime);
                                      Fluttertoast.showToast(
                                          msg: value,
                                          toastLength: Toast.LENGTH_SHORT);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.calendar_today_rounded),
                          ),
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  label: Text(DateFormat('MMMM dd, yyyy')
                                      .format(_dateTime))),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: locationController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value == null) {
                            return 'please enter description';
                          }
                          return null;
                        },
                        suffixPressed: () {},
                        label: 'Description ',
                        prefix: Icons.description_outlined),
                    const SizedBox(
                      height: 20,
                    ),
                    // ElevatedButton(
                    //     onPressed: () async {
                    //       // XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
                    //       XFile? video=  await _picker.pickVideo(source: ImageSource.gallery);
                    //       setState(() {
                    //         image = File(video!.path);
                    //       });
                    //       print("Video ${image!.path}");
                    //     },
                    //     child: Text("Image Picker")),
                    Center(
                      child: ElevatedButton(
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff14be77))),
                          onPressed: () async {
                            List<XFile>? picked =
                                await _picker.pickMultiImage();
                            setState(() {
                              multipleImages =
                                  picked!.map((e) => File(e.path)).toList();
                            });
                          },
                          child: const Text("Multiple Image Picker")),
                    ),
                    // image == null
                    //     ? const Text("There is No Image")
                    //     : Image.file(
                    //         image!,
                    //         height: 200,
                    //         width: 200,
                    //       )
                    SizedBox(
                      height: 100,
                      child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: multipleImages.length,
                          itemBuilder: (context, index) {
                            return GridTile(
                                child: Image.file(multipleImages[index]));
                          }),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {},
                        text: 'Add',
                        shape: false,
                        width: 120,
                        Iconbutton: Icons.edit,
                        colorIcon: white,
                        Textcolor: Colors.white,
                        isUpperCase: false,
                        radius: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
          if (IO.Platform.isAndroid) {
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
