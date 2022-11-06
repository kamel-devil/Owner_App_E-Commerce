import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);

  @override
  EditPhoneFormPageState createState() {
    return EditPhoneFormPageState();
  }
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _phone = 011111111111;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
        appBar: buildAppBar(context),
        body: FutureBuilder(
            future: p.profile(),
            builder: (context, snapshot) {
              if (snapshot.hasData && p.dataProfile.isNotEmpty) {
                final map = snapshot.data as Map;
                TextEditingController phoneController =
                    TextEditingController(text: map['phone']);
                return Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                            width: 320,
                            child: Text(
                              "What's Your Phone Number?",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SizedBox(
                                height: 100,
                                width: 320,
                                child: TextFormField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                      hintText: 'Phone',
                                      labelText: 'Enter Phone'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Phone';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _phone = int.parse(value.toString());
                                    });
                                  },
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 320,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false otherwise.
                                      _formKey.currentState?.save();
                                      p.updateProfilePhone('$_phone').whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())));
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                )))
                      ]),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
