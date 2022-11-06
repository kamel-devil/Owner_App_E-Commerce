import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:owner_app/screens/shops/shop.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';
import '../../resources/cache_image_network.dart';
import '../../resources/color_data.dart';
import '../../resources/constant.dart';
import '../../resources/global_widget.dart';
import '../../resources/shimmer_loading.dart';
import '../home_admin.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'shops.dart';

class Shops1 extends StatefulWidget {
  const Shops1({
    Key? key,
  }) : super(key: key);

  @override
  State<Shops1> createState() => _Shops1State();
}

class _Shops1State extends State<Shops1> {
  final _globalWidget = GlobalWidget();
  TextEditingController _etSearch = TextEditingController();
  Timer? _timerDummy;
  final _shimmerLoading = ShimmerLoading();
  bool _loading = true;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<int> verticalData = [];
  List<int> horizontalData = [];
  final int increment = 5;
  bool isLoadingVertical = false;
  bool isLoadingHorizontal = false;

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
    _loadMoreVertical();
    _loadMoreHorizontal();
    super.initState();
  }

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));

    verticalData.addAll(
        List.generate(increment, (index) => verticalData.length + index));

    setState(() {
      isLoadingVertical = false;
    });
  }

  Future _loadMoreHorizontal() async {
    setState(() {
      isLoadingHorizontal = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));

    horizontalData.addAll(
        List.generate(increment, (index) => horizontalData.length + index));

    setState(() {
      isLoadingHorizontal = false;
    });
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    _etSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);
    var p = Provider.of<Funcprovider>(context);
    final double boxImageSize1 = (MediaQuery.of(context).size.width / 3);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => homeAdmin()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          title: const Text(
            'Shops List',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
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
              child: TextFormField(
                controller: _etSearch,
                textAlignVertical: TextAlignVertical.bottom,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                onChanged: (textValue) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: 'Search Shops',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  suffixIcon: (_etSearch.text == '')
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _etSearch = TextEditingController(text: '');
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey[500])),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.grey[200]!)),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
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
                    count: 8,
                    notifColor: BLACK77,
                    notifSize: 24,
                    labelSize: 14),
                //icon: _globalWidget.customNotifIcon2(8, _color1),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Click notification',
                      toastLength: Toast.LENGTH_SHORT);
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Popular Shops',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: 'Click last search',
                              toastLength: Toast.LENGTH_SHORT);
                        },
                        child: const Text('view all',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: PRIMARY_COLOR),
                            textAlign: TextAlign.end),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: p.dataPopShops('0'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && p.popShopsDa.isNotEmpty) {
                        return Container(
                            margin: const EdgeInsets.only(top: 16),
                            height: boxImageSize1 * 1.90,
                            child: LazyLoadScrollView(
                              isLoading: isLoadingHorizontal,
                              scrollDirection: Axis.horizontal,
                              onEndOfPage: () => _loadMoreHorizontal(),
                              child: Scrollbar(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: horizontalData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildLastSearchCard(
                                        index, boxImageSize1);
                                  },
                                ),
                              ),
                            ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            // FutureBuilder(
            //     future: p.getPassengerData(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData && p.passengers.isNotEmpty) {
            //         return RefreshIndicator(
            //             onRefresh: refreshData,
            //             child: (_loading == true)
            //                 ? _shimmerLoading.buildShimmerContent()
            //                 : SizedBox(
            //                     height: 700,
            //                     child: LazyLoadScrollView(
            //                       isLoading: isLoadingHorizontal,
            //                       scrollDirection: Axis.horizontal,
            //                       onEndOfPage: () => _loadMoreHorizontal(),
            //                       child: Scrollbar(
            //                         child: ListView.builder(
            //                             shrinkWrap: true,
            //                             key: _listKey,
            //                             itemCount: verticalData.length,
            //                             physics: NeverScrollableScrollPhysics(),
            //
            //                             // physics:
            //                             //     const AlwaysScrollableScrollPhysics(),
            //                             itemBuilder: (context, index) {
            //                               return _buildItem(
            //                                   boxImageSize, index);
            //                             }),
            //                       ),
            //                     ),
            //                   ));
            //       } else {
            //         return Container();
            //       }
            //     })
          ]),
        ));
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
                              int.parse(p.passengers[index]['icon_name'])),
                          color: HexColor.fromHex(p.passengers[index]['color']),
                          size: 15,
                        ),
                      ],
                    ),
                    Text('${p.popShopsDa[index]['address']}',
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
                              rating:
                                  double.parse('${p.passengers[index]['rate']}'),
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
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => shop(
                            lat: double.parse(p.shopDa['lat']),
                            long: double.parse(p.shopDa['long']),
                            name: p.shopDa['name'],
                            Address: p.shopDa['address'],
                            image: p.shopDa['image'],
                            gallery: p.shopDa['gallery'],
                            rate: p.shopDa['rate'],
                            phone: p.shopDa['phone'],
                            reviews: p.shopDa['reviews'],
                            id: p.shopDa['id'],
                          )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: buildCacheNetworkImage(
                            width: boxImageSize,
                            height: boxImageSize,
                            url: p.passengers[index]['image'])),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                p.passengers[index]['name'],
                                style: const TextStyle(
                                    fontSize: 13, color: color2),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(
                                IconDataSolid(
                                    int.parse(p.passengers[index]['icon_name'])),
                                color:
                                    HexColor.fromHex(p.passengers[index]['color']),
                                size: 15,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: SOFT_GREY, size: 12),
                                Text(' ${p.passengers[index]['address']}',
                                    style: const TextStyle(
                                        fontSize: 11, color: SOFT_GREY))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text('Phone: ${p.passengers[index]['phone']}',
                                style: const TextStyle(
                                    fontSize: 11, color: SOFT_GREY)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                _globalWidget.createRatingBar(
                                    rating: double.parse(
                                        '${p.passengers[index]['rate']}'),
                                    size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showPopupDeleteFavorite(
                            index, boxImageSize, p.passengers[index]['id']);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(width: 1, color: Colors.grey[300]!)),
                        child:
                            const Icon(Icons.delete, color: BLACK77, size: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            Fluttertoast.showToast(msg: 'Item has been EDIT');
                          },
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(0, 30)),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                              side: MaterialStateProperty.all(
                                const BorderSide(color: SOFT_BLUE, width: 1.0),
                              )),
                          child: const Text(
                            'EDIT',
                            style: TextStyle(
                                color: SOFT_BLUE,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
              .push(MaterialPageRoute(builder: (context) => Shops()));
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
