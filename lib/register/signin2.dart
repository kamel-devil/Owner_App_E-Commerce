import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/home_admin.dart';
import '../provider/provider.dart';
import '../resources/constant.dart';
import '../screens/cards_design.dart';

class Signin2Page extends StatefulWidget {
  const Signin2Page({Key? key}) : super(key: key);

  @override
  _Signin2PageState createState() => _Signin2PageState();
}

class _Signin2PageState extends State<Signin2Page> {
  bool _obscureText = true;
  String userName = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  IconData _iconVisible = Icons.visibility_off;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Platform.isAndroid
              ? SystemUiOverlayStyle.light
              : const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light),
          child: Stack(
            children: <Widget>[
              Container(
                  // margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height / 20, 0, 0),
                  alignment: Alignment.topCenter,
                  child: Image.network(
                    'https://st2.depositphotos.com/1002277/5515/i/950/depositphotos_55150353-stock-photo-admin-cubics.jpg',
                  )),
              ListView(
                children: <Widget>[
                  // create form login
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(32,
                        MediaQuery.of(context).size.height / 3.5 - 72, 32, 0),
                    color: Colors.white,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 40,
                              ),
                              const Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: light,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    labelText: 'Enter username',
                                    hintText: 'username'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a username';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    userName = value.toString();
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600]!)),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underlineColor),
                                    ),
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700]),
                                    suffixIcon: IconButton(
                                        icon: Icon(_iconVisible,
                                            color: Colors.grey[700], size: 20),
                                        onPressed: () {
                                          _toggleObscureText();
                                        }),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      password = value.toString();
                                    });
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: 'Click forgot password',
                                        toastLength: Toast.LENGTH_SHORT);
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) => BLACK21,
                                      ),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState?.save();
                                        p.login(
                                                emailController.text.toString(),
                                                passwordController.text
                                                    .toString())
                                            .then((value) {
                                          if (value['reply']) {
                                            p.saveUserData(
                                              value["image"] ?? '',
                                              value["token"] ?? '',
                                              value["f_name"] ?? '',
                                              value['l_name'] ?? '',
                                              value["shops"] ?? '',
                                              value["shop_id"] ?? '',
                                              value["shop_name"] ?? '',
                                              value["shop_image"] ?? '',
                                            );
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MakeDashboardItems()));
                                            p.saveLogin(true);
                                            p.saveToken(value['token']);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  title: const Text(
                                                    'Error Login',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  content: const Text(
                                                      'Are you sure Loogin ?',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: BLACK77)),
                                                );
                                              },
                                            );
                                          }
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Form Submitted')));
                                      }
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            fontSize: 16, color: light),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // create sign up link
                  Center(
                    child: Wrap(
                      children: <Widget>[
                        const Text('New User? '),
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: 'Click signup',
                                toastLength: Toast.LENGTH_SHORT);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: light, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
