import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/components.dart';
import '../../resources/cache_image_network.dart';
import '../../resources/color_manager.dart';
import '../../resources/constant.dart';
import '../../resources/data.dart';
import '../../resources/global_function.dart';
import '../../resources/global_widget.dart';
import '../../resources/shimmer_loading.dart';
import '../../widgets/category_item.dart';

class POS extends StatefulWidget {
  @override
  _POSState createState() => _POSState();
}

class _POSState extends State<POS> {
  // initialize global function and global widget
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();
  String search = '';
  TextEditingController _shopSearch = TextEditingController();
  bool _loading = true;
  Timer? _timerDummy;

  Color _color1 = const Color(0xFF515151);

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    _timerDummy?.cancel();
    super.dispose();
  }

  void _getData() {
    // this timer function is just for demo, so after 2 second, the shimmer loading will disappear and show the content
    _timerDummy = Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                    _shopSearch =
                                        TextEditingController(text: '');

                                    search = '';
                                  });
                                },
                                child:
                                    Icon(Icons.close, color: Colors.grey[500])),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey[200]!)),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey[200]!),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.qr_code_2, color: Colors.black),
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: 'Click search',
                            toastLength: Toast.LENGTH_SHORT);
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
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: (_loading == true)
              ? _shimmerLoading.buildShimmerProduct(
                  ((MediaQuery.of(context).size.width) - 24) / 2 - 12)
              : CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: appBgColor,
                    elevation: 0,
                    pinned: true,
                    snap: false,
                    floating: false,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.restart_alt_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCategoryIndex = 0;
                        });
                      },
                    ),
                    title: buildCategory(),
                  ),
                  const SliverToBoxAdapter(
                      child: Text(
                    'All Product',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.625,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return _buildItem(index);
                        },
                        childCount: recipes.length,
                      ),
                    ),
                  ),
                ]),
        ));
  }

  int selectedCategoryIndex = 0;

  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 20, 7, 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              data: categories[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Card(
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
                    width: boxImageSize,
                    height: boxImageSize,
                    url: recipes[index]['image'])),
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    recipes[index]['name'],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _color1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${recipes[index]['price']}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        Text('${recipes[index]['price']} Sale',
                            style:
                                const TextStyle(fontSize: 11, color: SOFT_GREY))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: SOFT_GREY, size: 12),
                        Text(recipes[index]['location'],
                            style:
                                const TextStyle(fontSize: 11, color: SOFT_GREY))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        _globalWidget.createRatingBar(
                            rating: double.parse(recipes[index]['rate']),
                            size: 12),
                        const Text('Review ',
                            style: TextStyle(fontSize: 11, color: SOFT_GREY))
                      ],
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 220,
                    height: 20,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff53e78b), Color(0xff14be77)],
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 20,
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Add to Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future refreshData() async {
    setState(() {
      recipes.clear();
      _loading = true;
      _getData();
    });
  }
}
