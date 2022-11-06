import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String _email = '';

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
                TextEditingController emailController =
                    TextEditingController(text: map['email']);
                return Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                            width: 320,
                            child: Text(
                              "What's your email?",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SizedBox(
                                height: 100,
                                width: 320,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter Email',
                                      hintText: 'Email'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (x) {
                                    validateEmail(x);
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _email = value.toString();
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
                                      p.updateProfileEmail(_email).whenComplete(
                                          () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage())));
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

  validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter mail';
    }

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.toString())) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}
