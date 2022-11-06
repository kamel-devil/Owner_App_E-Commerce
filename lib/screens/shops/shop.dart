import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../resources/cache_image_network.dart';
import '../../resources/constant.dart';
import '../../resources/reusable_widget.dart';

class shop extends StatelessWidget {
  shop( {Key? key,
    required this.lat,
    required this.long,
    required this.name,
    required this.Address,
    required this.image,
    required this.gallery,
    required this.phone,
    required this.reviews,
    required this.rate,
    required this.id,
  }) : super(key: key);
  double lat;
  double long;
  String name;
  String Address;
  String phone;
  String image;
  List gallery;
  List reviews;
  int rate;
  String id;

  final _reusableWidget = ReusableWidget();

  final int _currentImageSlider = 0;

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        image)),
              ),
            ),
            Card(
              elevation: 2,
              child: SizedBox(
                width: double.infinity,
                height: 156,

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Preferred Merchants',
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.info_outline,
                                  size: 20, color: BLACK77)),
                        ],
                      ),
                    ),
                    Row(children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  image)),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         'Preferred Merchants',
                            //       ),
                            //       GestureDetector(
                            //           onTap: () {},
                            //           child: Icon(Icons.info_outline,
                            //               size: 20, color: BLACK77)),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child:  Text(name,style: const TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child:  Column(
                                children: [
                                  Text(
                                    Address,
                                  ),
                                  Text(phone),

                                ],
                              ),
                            ),

                            const SizedBox(height: 8),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children:  [
                                  const Icon(Icons.star, color: Colors.orange, size: 15),
                                  const SizedBox(width: 2),
                                  Text(
                                    '$rate',
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.location_pin,
                                      color: ASSENT_COLOR, size: 15),
                                  const SizedBox(width: 2),
                                  const Text(
                                    '0.7 miles',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ),const SizedBox(height: 5,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(Icons.local_offer_outlined,
                        color: ASSENT_COLOR, size: 16),
                    SizedBox(width: 4),
                    Text('Check for available coupons'),
                    Spacer(),
                    Text(
                      'See Coupons',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildHomeBanner(),
            // _createLastSearch1(),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gallery',
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
                Container(
                    margin: const EdgeInsets.only(top: 16),
                    height: boxImageSize * 1.15,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: gallery.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildLastSearchCard(index, boxImageSize,context);
                      },
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('  popular shops',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {

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
            Selector<Funcprovider,Future>(
                selector: (context, pro) => pro.Servicessh(id),
                builder: (context, value, child) {
                  return FutureBuilder(
                      future: value,
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          final map= snapshot.data as List;
                          return GridView.count(
                            padding: const EdgeInsets.all(12),
                            primary: false,
                            childAspectRatio: 4 / 1.6,
                            shrinkWrap: true,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            crossAxisCount: 2,
                            children: List.generate(map.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => shop(
                                  //       id:  map[index]['id'],
                                  //     )));
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 2,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10)),
                                            child: buildCacheNetworkImage(
                                                width: (MediaQuery.of(context).size.width /
                                                    2) *
                                                    (1.6 / 4) -
                                                    12 -
                                                    1,
                                                height: (MediaQuery.of(context).size.width /
                                                    2) *
                                                    (1.6 / 4) -
                                                    12 -
                                                    1,
                                                url: map[index]['image'])),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(map[index]['name'],
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 4),
                                                Text(
                                                    '${map[index]['rate']} Rate',
                                                    style: const TextStyle(
                                                        fontSize: 9, color: Color(0xFF37474f)))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }),
                          );


                        }else{
                          return const CircularProgressIndicator();
                        }
                      });
                }),


            _createProductReview()
          ],
        ),
      ),
    );
  }

  // Widget _createLastSearch1() {
  //   return Column(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text('Services',
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //             GestureDetector(
  //               onTap: () {},
  //               child: const Text('view all',
  //                   style: TextStyle(
  //                       fontSize: 13,
  //                       fontWeight: FontWeight.bold,
  //                       color: PRIMARY_COLOR),
  //                   textAlign: TextAlign.end),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildHomeBanner() {
    return Stack(
      children: [
        CarouselSlider(
          items: gallery
              .map((item) => GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Click banner ${item.id}',
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: buildCacheNetworkImage(
                      width: 0, height: 0, url: item)))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 2,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 300),
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {}),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: gallery.map((item) {
              int index = gallery.indexOf(item);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: _currentImageSlider == index ? 10 : 5,
                height: _currentImageSlider == index ? 10 : 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


  Widget _buildLastSearchCard(index, boxImageSize, BuildContext context) {
    return SizedBox(
      width: boxImageSize + 20,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {

          },
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content:SizedBox(
                          height: 400,
                          width:600,
                          child:  CarouselSlider(
                            items: gallery
                                .map((item) => GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: 'Click banner ${item.id}',
                                      toastLength: Toast.LENGTH_SHORT);
                                },
                                child: Image.network(item,fit: BoxFit.contain,
                                    )))
                                .toList(),
                            options: CarouselOptions(
                                aspectRatio: 1,
                                viewportFraction: 1.0,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 6),
                                autoPlayAnimationDuration: const Duration(milliseconds: 300),
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {}),
                          ),
                        )



                      );

                    },
                  );
                },
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child:
                    buildCacheNetworkImage(
                        width: boxImageSize + 10,
                        height: boxImageSize + 10,
                        url: gallery[index])),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.only(top:5),
              //       ),
              //       Container(
              //         margin: const EdgeInsets.only(top:5),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _createProductReview() {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Review'),
                GestureDetector(
                  onTap: () {},
                  child: const Text('View All'),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                _reusableWidget.createRatingBar(rating: 2, size: 12),
                const Text('??????????????????',
                    style: TextStyle(fontSize: 11, color: SOFT_GREY))
              ],
            ),
            Column(
                children: List.generate(4, (index) {
              return Column(
                children: [
                  Divider(
                    height: 32,
                    color: Colors.grey[400],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(reviews[index]['user'],
                      style:
                          const TextStyle(fontSize: 13, color: SOFT_GREY)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${reviews[index]['rate']}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(reviews[index]['review'])
                    ],
                  )
                ],
              );
            })),
          ],
        ));
  }

  // Widget _createAppBar() {
  //   return SizedBox(
  //     height: 80,
  //     child: AnimatedBuilder(
  //       animation: _topColorAnimationController,
  //       builder: (context, child) => AppBar(
  //         automaticallyImplyLeading: false,
  //         backgroundColor: _appBarColor.value,
  //         systemOverlayStyle: _appBarSystemOverlayStyle,
  //         elevation: 0,
  //         title: TextButton(
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                 (Set<MaterialState> states) => topSearchColor,
  //               ),
  //               overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(3.0),
  //               )),
  //             ),
  //             onPressed: () {
  //               Fluttertoast.showToast(
  //                   msg: 'Click search', toastLength: Toast.LENGTH_SHORT);
  //             },
  //             child: Row(
  //               children: [
  //                 const SizedBox(width: 8),
  //                 Icon(
  //                   Icons.search,
  //                   color: Colors.grey[500],
  //                   size: 18,
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Text(
  //                   'Search product',
  //                   style: TextStyle(
  //                       color: Colors.grey[500],
  //                       fontWeight: FontWeight.normal),
  //                 )
  //               ],
  //             )),
  //         actions: [
  //           GestureDetector(
  //               onTap: () {
  //                 Fluttertoast.showToast(
  //                     msg: 'Click message', toastLength: Toast.LENGTH_SHORT);
  //               },
  //               child: Icon(Icons.email, color: topIconColor)),
  //           IconButton(
  //               icon: Icon(Icons.notifications, color:topIconColor),
  //               onPressed: () {
  //                 Fluttertoast.showToast(
  //                     msg: 'Click notification',
  //                     toastLength: Toast.LENGTH_SHORT);
  //               }),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
