import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:owner_app/resources/color_data.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../provider/provider.dart';
import '../../resources/cache_image_network.dart';
import '../../resources/categoryItem.dart';
import '../../resources/constant.dart';
import '../../resources/global_widget.dart';
import '../../resources/shimmer_loading.dart';

class Expense extends StatefulWidget {
  const Expense({
    Key? key,
  }) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _globalWidget = GlobalWidget();
  Timer? _timerDummy;
  final _shimmerLoading = ShimmerLoading();
  bool _loading = true;
  String search = '';
  TextEditingController _shopSearch = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  int currentPage = 1;

  int selectedCategoryIndex = 0;
  String idCate = '0';
  var qrstr = "let's Scan it";


  void _getData() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerDummy = Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    _shopSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    var p = Provider.of<Funcprovider>(context);
    final double boxImageSize1 = (MediaQuery.of(context).size.width / 3);
    print('---------------------------------');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: const Text(
          'Expense',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // create search text field in the app bar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[100]!,
                    width: 1.0,
                  )),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            height: kToolbarHeight,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _shopSearch,
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    onChanged: (textValue) {
                      setState(() {
                        search = textValue;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: 'Search Shops',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.grey[500],
                        onPressed: () {},
                      ),
                      suffixIcon: (search == '')
                          ? null
                          : GestureDetector(
                          onTap: () {
                            setState(() {
                              _shopSearch = TextEditingController(text: '');

                              search = '';
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[500])),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.qr_code_2, color: Colors.black),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: 'Click search', toastLength: Toast.LENGTH_SHORT);
                    }),

              ],
            ),
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                    msg: 'Click message', toastLength: Toast.LENGTH_SHORT);
              },
              child: const Icon(Icons.email, color: BLACK77)),
          IconButton(
              icon: _globalWidget.customNotifIcon(
                  count: 8, notifColor: BLACK77, notifSize: 24, labelSize: 14),
              //icon: _globalWidget.customNotifIcon2(8, _color1),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: 'Click notification', toastLength: Toast.LENGTH_SHORT);
              }),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: p.getPassengerData(isRefresh: true,search,currentPage,idCate),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: SmartRefresher(
                      controller: p.refreshShop,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await p.getPassengerData(
                          isRefresh: true, search,currentPage, idCate,);
                        if (result) {
                          p.refreshShop.refreshCompleted();

                        } else {
                          p.refreshShop.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await p.getPassengerData(search, currentPage,idCate,);
                        currentPage++;
                        if (result) {
                          p.refreshShop.loadComplete();
                        } else {
                          p.refreshShop.loadFailed();
                        }
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        // key: _listKey,
                        // physics: AlwaysScrollableScrollPhysics (),
                        itemBuilder: (context, index) {
                          return _buildItem(boxImageSize, index);
                        },
                        itemCount: p.passengers.length,

                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                      ),
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }


              }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanQr();
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff53e78b), Color(0xff14be77)],
              ),
            ),
            child: const Icon(Icons.add)),
      ),

    );
  }
  Future <void>scanQr()async{
    try{
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Skip', true, ScanMode.QR).then((value){
        setState(() {
          qrstr=value;
        });
      });
    }catch(e){
      setState(() {
        qrstr='unable to read this';
      });
    }
  }

  Widget _buildLastSearchCard(index, boxImageSize) {
    var p = Provider.of<Funcprovider>(context);

    return SizedBox(
      width: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize + 10,
                      height: boxImageSize + 10,
                      url: p.popShopsDa[index]['image'])),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.popShopsDa[index]['name'],
                          style: const TextStyle(
                              fontSize: 12,
                              color: BLACK77,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          IconDataSolid(
                              int.parse(p.popShopsDa[index]['icon_name'])),
                          color: HexColor.fromHex(p.popShopsDa[index]['color']),
                          size: 15,
                        ),
                      ],
                    ),
                    Text('${p.popShopsDa[index]['address']}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text('${p.popShopsDa[index]['phone']}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          _globalWidget.createRatingBar(
                              rating: double.parse(
                                  '${p.popShopsDa[index]['rate']['rate']}'),
                              size: 12),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(boxImageSize, index) {
    var p = Provider.of<Funcprovider>(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 6, 12, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius:50,
          backgroundImage: NetworkImage(p.passengers[index]['image']),
        ),
        title:  Text(
          p.passengers[index]['name'],
          style: const TextStyle(
              fontSize: 13, color: color2),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Icon(Icons.location_on,
                      color: SOFT_GREY, size: 12),
                  Flexible(
                    child: Text(
                        ' ${p.passengers[index]['address']}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 11, color: SOFT_GREY)),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                  'Phone: ${p.passengers[index]['phone']}',
                  style: const TextStyle(
                      fontSize: 11, color: SOFT_GREY)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  _globalWidget.createRatingBar(
                      rating: double.parse(
                          '${p.passengers[index]['rate']['rate']}'),
                      size: 12),
                  Text(
                      '   (${p.passengers[index]['rate']['count']})'),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(onPressed: () {  }, icon: Icon(Icons.delete,color: Colors.red,),
          
        ),
      )
    );
  }

  void showPopupDeleteFavorite(index, boxImageSize, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No', style: TextStyle(color: SOFT_BLUE)));
    Widget continueButton = TextButton(
        onPressed: () {
          delete(Uri.parse(
              'https://ibtikarsoft.net/mapapi/shop.php?lang=ar&shop=$id'));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Expense()));
        },
        child: const Text('Yes', style: TextStyle(color: SOFT_BLUE)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Delete Shops',
        style: TextStyle(fontSize: 18),
      ),
      content: const Text('Are you sure to delete this item from your Shops ?',
          style: TextStyle(fontSize: 13, color: BLACK77)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future refreshData() async {
    setState(() {
      _loading = true;
      _getData();
    });
  }
}
