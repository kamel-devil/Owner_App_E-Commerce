
import 'package:flutter/material.dart';
import '../resources/constant.dart';
import '../resources/global_widget.dart';
import 'signin2.dart';

class SigninListPage extends StatefulWidget {
  @override
  _SigninListPageState createState() => _SigninListPageState();
}

class _SigninListPageState extends State<SigninListPage> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _globalWidget.globalAppBar(),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          children: [
            const Text('Sign In Screen', style: TextStyle(
              fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
            )),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  const Flexible(
                    flex:5,
                    child: Text('Sign in screen used for authentication before going to the home page.', style: TextStyle(
                      fontSize: 15, color: BLACK77,letterSpacing: 0.5
                    ))
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                        child: const Icon(Icons.login, size: 50, color: SOFT_BLUE))
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 48),
              child: const Text('Screen List', style: TextStyle(
                  fontSize: 18, color: BLACK21, fontWeight: FontWeight.w500
              )),
            ),
            const SizedBox(height: 18),
            _globalWidget.screenDetailList(context: context, title: 'Sign in 2', page: const Signin2Page()),

          ],
        )
    );
  }
}
