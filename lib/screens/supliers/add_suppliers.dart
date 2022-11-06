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
import 'suppliers.dart';

class addSuppliers_Screen extends StatefulWidget {
  const addSuppliers_Screen({Key? key}) : super(key: key);

  @override
  _addSuppliers_ScreenState createState() => _addSuppliers_ScreenState();
}

class _addSuppliers_ScreenState extends State<addSuppliers_Screen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController f_nameController = TextEditingController();
  TextEditingController l_nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController servicetypeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whats_phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context,listen: false);
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
                  color:  const Color(0xffFD8F11).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>supplier_screen()));
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    color: const Color(0xffda6317),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor:white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.only(
            top: 20),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top:15, right: 10, bottom: 10),
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
                      'New Suppliers',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        buttonIcon: true,
                        controller: locationController,
                        type: TextInputType.text,
                        // validate: (value) {
                        //   if (value == null) {
                        //     return 'please Location';
                        //   }
                        //   return null;
                        // },
                        suffix: Icons.add_location_alt_rounded,
                        suffixPressed: () {},
                        label: 'Location ',
                        prefix: Icons.location_on),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: f_nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your first name';
                          }
                          return null;
                        },
                        label: 'your firstname',
                        prefix: Icons.person),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: l_nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your last name';
                          }
                          return null;
                        },
                        label: 'your lastname',
                        prefix: Icons.person),
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
                                        minimumYear: 2015,
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
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Enter phone ';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: whats_phoneController,
                        type: TextInputType.phone,
                        label: ' WhatsUp phone',
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      child: defaultFormField(
                          controller: noteController,
                          type: TextInputType.multiline,
                          label: ' Notes',
                          prefix: Icons.note_add_outlined),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            p.uploadSuppliers({

                              'f_name': f_nameController.text,
                              'l_name': l_nameController.text,
                              'address': locationController.text,
                              'lat': '${p.lat}',
                              'long': '${p.long}',
                              'notes': noteController.text,
                              'phone': phoneController.text,
                              'whatsapp_phone': whats_phoneController.text,
                              'data': '$_dateTime',
                            }, p.selectedFile!);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Form Submitted')));
                          }
                        },
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
    var p = Provider.of<Funcprovider>(context,listen: false);

    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          p.askPermissionCamera();
        },
        child: const Text('Camera', style: TextStyle(color: Colors.black)));
    Widget continueButton = TextButton(
        onPressed: () {
          if (kIsWeb) {
            p.getImage(ImageSource.gallery);
          } else {
            if (IO.Platform.isAndroid) {
              p.askPermissionPhotos();
            } else {
              p.askPermissionStorage();
            }
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
      content: const Text('image',
          style: TextStyle(fontSize: 13, color: Colors.black)),
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
