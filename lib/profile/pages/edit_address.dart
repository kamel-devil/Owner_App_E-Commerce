import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../map/tools/map.dart';
import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _address = '';

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder(
          future: p.profile(),
            builder: (context, snapshot) {
              if(snapshot.hasData&&p.dataProfile.isNotEmpty){
                final map=snapshot.data as Map;
                TextEditingController addressController =
                TextEditingController(text:p.address?? map['address']);

                return  Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                            width: 350,
                            child: Text(
                              "What type of passenger\nare you?",
                              style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                                height: 250,
                                width: 350,
                                child: TextFormField(
                                  // Handles Form Validation

                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length > 200) {
                                      return 'Please describe yourself but keep it under 200 characters.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _address = value.toString();
                                    });
                                  },

                                  controller: addressController,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration:  InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          p
                                              .getCurrentLocation()
                                              .whenComplete(() {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const Map1()));
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.edit_location_sharp),
                                      ),
                                      alignLabelWithHint: true,
                                      contentPadding:
                                      EdgeInsets.fromLTRB(10, 15, 10, 100),
                                      hintMaxLines: 3,
                                      hintText:
                                      'Address'),
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 350,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      _formKey.currentState?.save();
                                      p.updateProfileAddress(_address).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())));
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                )))
                      ]),
                );

              }else{
                return CircularProgressIndicator();
              }
            }        ));
  }
}
