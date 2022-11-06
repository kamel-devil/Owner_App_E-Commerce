import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:owner_app/provider/provider.dart';
import 'package:owner_app/screens/supliers/editsupplier.dart';


import 'package:provider/provider.dart';

import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'register/signin2.dart';
import 'screens/cards_design.dart';
import 'screens/customer/customer.dart';
import 'screens/supliers/suppliers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) => {setLocale(locale)});
  //   super.didChangeDependencies();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Funcprovider>(
      create: (context) => Funcprovider()
        ..checkInternet()
        ..getCheckLocation()
        ..getToken(),

    child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          home:Consumer<Funcprovider>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getLogin(),
                builder: (context, snapshot) {

                  if (snapshot.data == true) {
                    // value.changeLang(_locale!);
                    return   MakeDashboardItems();
                  } else {
                    return Signin2Page();
                  }
                },

              );
            },
          ),
          // home:supplier_screen(),
        ),
      ),
    );
  }
}
