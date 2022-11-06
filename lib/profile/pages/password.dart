import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/appbar_widget.dart';
import 'profile_page.dart';


// This class handles the Page to edit the Phone Section of the User Profile.
class EditPasswordFormPage extends StatefulWidget {
  const EditPasswordFormPage({Key? key}) : super(key: key);
  @override
  EditPasswordFormPageState createState() {
    return EditPasswordFormPageState();
  }
}

class EditPasswordFormPageState extends State<EditPasswordFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _passKey2 = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  final phoneController = TextEditingController();
  String _new_Password = '';
  String _old_Password = '';

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
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 320,
                    child: Text(
                      "What's Your Phone Number?",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        width: 320,
                        child: Column(
                          children: [
                            TextFormField(
                                key: _passKey,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Password', labelText: 'Enter Old Password'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter password';
                                  } else if (value.length < 8) {
                                    return 'Password should be more than 8 characters';
                                  } else {
                                    return null;
                                  }
                                }),
                            TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Confirm Password',
                                    labelText: 'Enter Confirm Password'),
                                validator: (confirmPassword) {
                                  if (confirmPassword != null && confirmPassword.isEmpty) {
                                    return 'Enter confirm password';
                                  }
                                  var password = _passKey.currentState?.value;
                                  if (confirmPassword != null &&
                                      confirmPassword.compareTo(password) != 0) {
                                    return 'Password mismatch';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _old_Password = value.toString();
                                  });
                                }),

                          ],
                        ),

                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          TextFormField(
                              key: _passKey2,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Password', labelText: 'Enter New Password'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter password';
                                } else if (value.length < 8) {
                                  return 'Password should be more than 8 characters';
                                } else {
                                  return null;
                                }
                              }),
                          TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Confirm Password',
                                  labelText: 'Enter Confirm Password'),
                              validator: (confirmPassword) {
                                if (confirmPassword != null && confirmPassword.isEmpty) {
                                  return 'Enter confirm password';
                                }
                                var password = _passKey.currentState?.value;
                                if (confirmPassword != null &&
                                    confirmPassword.compareTo(password) != 0) {
                                  return 'Password mismatch';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _new_Password = value.toString();
                                });
                              }),

                        ],
                      ),

                    )
                ),

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
                              p.updateProfilePassword(_old_Password,_new_Password).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage())));
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
