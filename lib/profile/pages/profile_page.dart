import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/display_image_widget.dart';
import 'date_of_B.dart';
import 'edit_address.dart';
import 'edit_email.dart';
import 'edit_image.dart';
import 'edit_name.dart';
import 'edit_phone.dart';
import 'password.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: p.profile(),
        builder: (context, snapshot) {
          if(snapshot.hasData&&p.dataProfile.isNotEmpty){
            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 10,
                ),
                const Center(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(64, 105, 225, 1),
                          ),
                        ))),
                InkWell(
                    onTap: () {
                      navigateSecondPage(const EditImagePage());
                    },
                    child: DisplayImage(
                      imagePath: p.dataProfile['image']??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      onPressed: () {},
                    )),
                buildUserInfoDisplay(
                    '${p.dataProfile['f_name']} ${p.dataProfile['l_name']}'??'name', 'Name', const EditNameFormPage()),
                buildUserInfoDisplay(p.dataProfile['phone']??'0111111111', 'Phone', const EditPhoneFormPage()),
                buildUserInfoDisplay(p.dataProfile['email']??'@hmail.com', 'Email', const EditEmailFormPage()),
                buildUserInfoDisplay(p.dataProfile['dob']??'2022/2/22', 'Birth', const EditBirthFormPage()),
                Expanded(
                  child: buildAbout(p.dataProfile['address']??'Saft_tala'),
                  flex: 4,
                ),
                buildUserInfoDisplay('********', 'Password', const EditPasswordFormPage()),

              ],
            );
          }else{
            return CircularProgressIndicator();
          }


        }
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>

      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(address) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.4,
                                  ),
                                ))))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
