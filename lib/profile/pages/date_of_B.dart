import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';


// This class handles the Page to edit the Phone Section of the User Profile.
class EditBirthFormPage extends StatefulWidget {
  const EditBirthFormPage({Key? key}) : super(key: key);
  @override
  EditBirthFormPageState createState() {
    return EditBirthFormPageState();
  }
}

class EditBirthFormPageState extends State<EditBirthFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
        appBar: buildAppBar(context),
        body: Center(
          child: Form(
            key: _formKey,
            child:                  Container(
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
                                    minimumYear: 1980,
                                    maximumYear: DateTime.now().year ,
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
                                  p.updateProfileBirth('$_dateTime');
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
          ),
        ));
  }
}
