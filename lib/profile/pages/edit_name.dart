import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';


// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  String _f_name = '';
  String _l_name = '';
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

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
              TextEditingController fNameController =
              TextEditingController(text: map['f_name']);
              TextEditingController lNameController =
              TextEditingController(text: map['l_name']);
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                        width: 330,
                        child: Text(
                          "What's Your Name?",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                            child: SizedBox(
                                height: 100,
                                width: 150,
                                child:  TextFormField(
                                  controller: fNameController,
                                  decoration:
                                  const InputDecoration(labelText: 'Enter First Name', hintText: 'First Name'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a First name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _f_name = value.toString();
                                    });
                                  },
                                ))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                            child: SizedBox(
                                height: 100,
                                width: 150,
                                child: TextFormField(
                                  controller: lNameController,
                                  decoration:
                                  const InputDecoration(labelText: 'Enter Last Name', hintText: 'Last Name'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a last name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _l_name = value.toString();
                                    });
                                  },
                                )))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 330,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  _formKey.currentState?.save();
                                  p.updateProfileName(_f_name, _l_name).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())));
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            )))
                  ],
                ),
              );

            }else{
              return CircularProgressIndicator();
            }
          }
        ));
  }
}
