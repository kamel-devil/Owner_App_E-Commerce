import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:owner_app/screens/products/products.dart';
import 'package:owner_app/screens/supliers/suppliers.dart';
import 'package:provider/provider.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../components/sales_model.dart';
import '../profile/user1.dart';
import '../provider/provider.dart';
import '../resources/global_widget.dart';
import 'shops/shops.dart';


class homeAdmin extends StatefulWidget {
  @override
  State<homeAdmin> createState() => _homeAdminState();
}

class _homeAdminState extends State<homeAdmin> {
  final _globalWidget = GlobalWidget();

  late var _series;
  late PageController _pageController;

  List data=[['2014',5,38],['2015',12,15]];
  final List<Sales> _smartphoneData = [
    Sales("2014", 5),
    Sales("2015", 12),
    Sales("2016", 14),
    Sales("2017", 17),
    Sales("2018", 8),
    Sales("2019", 11),
    Sales("2020", 26),
  ];

  final List<Sales> _refrigeratorData = [
    Sales("2014", 30),
    Sales("2015", 15),
    Sales("2016", 18),
    Sales("2017", 27),
    Sales("2018", 18),
    Sales("2019", 9),
    Sales("2020", 37),
  ];

  late final FirebaseMessaging _fbm;
  late NotificationModel _notificationModel;

  // final List<Sales> _tvData = [
  //   Sales("2014", 80),
  //   Sales("2015", 170),
  //   Sales("2016", 160),
  //   Sales("2017", 220),
  //   Sales("2018", 120),
  //   Sales("2019", 150),
  //   Sales("2020", 310),
  // ];
  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print(token);
    });

  }
  @override
  void initState() {
    getToken();
    notificationConfigure();
    _series = [
      charts.Series(
          id: "SmartPhone",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          data: _smartphoneData
      ),
      charts.Series(
          id: "Refrigerator",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          data: _refrigeratorData
      ),
      // charts.Series(
      //     id: "TV",
      //     domainFn: (Sales sales, _) => sales.year,
      //     measureFn: (Sales sales, _) => sales.sale,
      //     data: _tvData
      // )
    ];
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Statistics',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),

        // leading:
        //
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(Icons.arrow_back_ios_new_outlined),color: Colors.black,),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => (User1Page())));
            },
            icon: const Icon(Icons.person),
            color: Colors.black,
          ),
        ],
      ),
      drawer: Drawer(
          // backgroundColor: Colors.black,
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Ashish Rawat"),
            accountEmail: Text("ashishrawat2911@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("A", style: TextStyle(fontSize: 40.0)),
            ),
          ),
          ListTile(
            title: const Text('Shops'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Shops()));
            },
          ),
          ListTile(
            title: const Text('product'),
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return Dialog(
                      // The background color
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            // The loading indicator
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 15,
                            ),
                            // Some text
                            Text('Loading...')
                          ],
                        ),
                      ),
                    );
                  });

              p.getCurrentLocation().whenComplete(() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  const Products()));
              });
            },
          ),
          ListTile(
            title: const Text('suplaiers'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  supplier_screen()));
            },
          ),
          ListTile(
            title: const Text('Customer'),
            onTap: () {
            },
          ),
        ],
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _globalWidget.createDetailWidget(
                title: 'Bar Charts 1 (Simple Bar Charts)'.tr,
                desc: 'This is the example of simple bar charts'.tr),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 400,
                child: charts.BarChart(
                    _series,
                    barGroupingType: charts.BarGroupingType.grouped,
                    behaviors: [
                      charts.SeriesLegend(
                        // By default, if the position of the chart is on the left or right of
                        // the chart, [horizontalFirst] is set to false. This means that the
                        // legend entries will grow as new rows first instead of a new column.
                        horizontalFirst: false,
                        // By setting this value to 2, the legend entries will grow up to two
                        // rows before adding a new column.
                        desiredMaxRows: 2,
                        // This defines the padding around each legend entry.
                        cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                        // Render the legend entry text with custom styles.
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.Color(r: 127, g: 63, b: 191),
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ]
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 0),
            //   child: Row(
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.home),color: Colors.black,),
            //
            //     ],
            //   ),
            // )
            ElevatedButton(onPressed:()=>sendPushMessage( 'karem lifta100000000000', 'kom lafaty'), child: Text('Send Notification'))
          ],
        ),
      ),
      //   bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.react,
      //   backgroundColor: Colors.white,
      //   items: [
      //     TabItem(icon: IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.home),color: Colors.black,), title: 'Nav 4'),
      //     TabItem(icon:    IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.line_weight_outlined),color: Colors.black,), title: 'Nav 4'),
      //   ],
      //   initialActiveIndex: 0,//optional, default as 0
      //   onTap: (int i){
      //     _tapNav(i);
      //   },
      // ),
    );

  }
  void sendPushMessage( String body, String title) async {
    try {
      await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAhzusOio:APA91bFBGlUzJUTWVU9i3NgWpOshC4In29ls1s53kHlLCPUIjgpVNBkltSYOoDGWMdFu1wIc6W-2wEbfyfiI6O2rCLma5Ns-F0iM-zDgvWQHlyZiv9qA00X5NoKHGR5p-KvGN2CoMLMf',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": 'ch0flJS3SOWVULmAplBrkb:APA91bExSHYbkL6r1rg3y2sHCTWLYpRtSG5iGJppEx1ubiMlc1zdlIDDn80klelw219cWTHJizFBTRPgH58udvVxfVT0ztAORchZoG74CHQ95jOg6rtwgEuXH1s0647sdhGr7-bRbbPn',
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
  void notificationConfigure() async {
    _fbm = FirebaseMessaging.instance;
    NotificationSettings setting = await _fbm.requestPermission(
      alert: true,
      sound: true,
      badge: true,
      provisional: false,
    );
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((message) {
        NotificationModel notificationModel = NotificationModel(
          title: message.notification!.title,
          body: message.notification!.body,
          dateTilte: message.data['title'],
          dateBody: message.data['body'],
        );
        setState(() {
          _notificationModel = notificationModel;
        });
        showSimpleNotification(
          Text(
            _notificationModel.title!,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(_notificationModel.body!),
          leading: const Icon(
            Icons.notifications_active,
            size: 30,
          ),
          background:Colors.black,
        );
      });
    }
  }

}
class NotificationModel {

  String? title ;
  String?  body ;
  String? dateTilte ;
  String? dateBody ;

  NotificationModel({this.title, this.body, this.dateTilte, this.dateBody});

}
