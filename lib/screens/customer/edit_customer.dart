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
import 'customer.dart';

class EditCustomer_Screen extends StatefulWidget {
  EditCustomer_Screen({required this.id});
  String id;

  @override
  _EditCustomer_ScreenState createState() => _EditCustomer_ScreenState();
}

class _EditCustomer_ScreenState extends State<EditCustomer_Screen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String f_name = 'Null';
  String l_name = 'Null';
  String location = 'Null';
  String phone = 'Null';
  String whats_phone = 'Null';
  String note = 'Null';

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

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Customer_Screen()));
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
          child: FutureBuilder(
            future: p.editCustomer(id: widget.id),
            builder: (context, snapshot) {
              final map=snapshot.data as Map;
              TextEditingController f_nameController = TextEditingController(text: map['f_name']??'Null');
              TextEditingController l_nameController = TextEditingController(text: map['f_name']??'Null');
              TextEditingController noteController = TextEditingController(text: map['notes']??'Null');
              TextEditingController phoneController = TextEditingController(text: map['phone']??'Null');
              TextEditingController whats_phoneController = TextEditingController(text: map['whatsapp_phone']??'Null');
              TextEditingController locationController = TextEditingController(text: map['address']??'Null');
              DateTime _dateTime = DateTime.now();
              return Card(
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
                                  ?  CircleAvatar(
                                radius: 83,
                                backgroundColor: Color(0xff14be77),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: ResizeImage(
                                      NetworkImage(map['image']),
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
                          'Edit Customer',
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            buttonIcon: true,
                            controller: locationController,
                            save: (value) {
                              setState(() {
                                location = value.toString();
                              });
                            },
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
                            save: (value) {
                              setState(() {
                                f_name = value.toString();
                              });
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
                            save: (value) {
                              setState(() {
                                l_name = value.toString();
                              });
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
                            save: (value) {
                              setState(() {
                                phone = value.toString();
                              });
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
                            save: (value) {
                              setState(() {
                                whats_phone = value.toString();
                              });
                            },
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: defaultFormField(
                              controller: noteController,
                              type: TextInputType.multiline,
                              label: ' Notes',
                              save: (value) {
                                setState(() {
                                  note = value.toString();
                                });
                              },
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
                                formkey.currentState?.save();

                                p.updateCustomer(
                                    data: {
                                      'f_name': f_name,
                                      'l_name': l_name,
                                      'notes': note,
                                      'phone': phone,
                                      'whatsapp_phone': whats_phone,
                                      'address':location,
                                    },
                                    file: p.selectedFile != null ? p.selectedFile!.path : map['image'],
                                    id: widget.id).whenComplete(() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Customer_Screen())));

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Form Submitted')));
                              }
                            },
                            text: 'UpDate',
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
              );
            }
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
