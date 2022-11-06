import 'package:flutter/material.dart';
import 'package:owner_app/profile/user1.dart';
import 'package:provider/provider.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../main.dart';
import '../provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>User1Page()));
         },),
        title: Text(translation(context).settings),
      ),
      body: Center(
          child: DropdownButton<Language>(
        iconSize: 30,
        hint: Text(translation(context).changeLanguage),
        onChanged: (Language? language) async {
          if (language != null) {
            Locale _locale = await setLocale(language.languageCode);
            MyApp.setLocale(context, _locale);
          }
        },
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
            .toList(),
      )),
    );
  }
}
