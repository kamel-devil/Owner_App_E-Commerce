import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../profile/pages/edit_address.dart';
import '../../provider/provider.dart';
import '../../screens/cards_design.dart';

class Map1 extends StatefulWidget {
  const Map1({Key? key}) : super(key: key);

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  final PopupController _popupController = PopupController();
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Funcprovider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Map'),
      //   backgroundColor: Colors.black87,
      //   centerTitle: true,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   child: const Icon(Icons.refresh),
      //   onPressed: () {
      //     pointIndex++;
      //     if (pointIndex >= points.length) {
      //       pointIndex = 0;
      //     }
      //     setState(() {
      //       markers[0] = Marker(
      //           point: points[pointIndex],
      //           anchorPos: AnchorPos.align(AnchorAlign.center),
      //           height: 30,
      //           width: 30,
      //           builder: (ctx) => const Icon(Icons.pin_drop));
      //       markers = List.from(markers);
      //     });
      //   },
      // ),
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(
            onPositionChanged: (position, M) {
              pro.getAddressInfo(
                  position.center!.latitude, position.center!.longitude);
            },
            onPointerHover: (event, point) {
              pro.getAddressInfo(point.latitude, point.longitude);
              pro.change(point.latitude, point.longitude);
            },

            center: LatLng(pro.lat!, pro.long!),
            //   center: LatLng(30.0374562, 31.2095052),
            zoom: 18,
            plugins: [
              MarkerClusterPlugin(),
            ],
            // onTap: (_, i) => _popupController.hideAllPopups(),
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 22,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            // MarkerLayerOptions(markers:[
            //   Marker(point: LatLng(pro.lat!,pro.long!), builder:(context)=> Icon(Icons.location_on)),
            // ]),
            MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              disableClusteringAtZoom: 6,
              size: const Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions: const FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: [
                Marker(
                    point: LatLng(pro.lat!, pro.long!),
                    builder: (context) => const Icon(
                          Icons.location_on,
                          size: 35,
                        )),
              ],
              polygonOptions: const PolygonOptions(
                  borderColor: Colors.blueAccent,
                  color: Colors.black12,
                  borderStrokeWidth: 3),
              popupOptions: PopupOptions(
                  popupSnap: PopupSnap.markerTop,
                  popupController: _popupController,
                  popupBuilder: (i, marker) => GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          width: 300,
                          height: 100,
                          color: Colors.transparent,
                          child: Text(
                            pro.address_ar,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      )),
              builder: (context, markers) {
                return FloatingActionButton(
                  onPressed: () {
                    print('///////////////-----------------------**');
                  },
                  child: Text(markers.length.toString()),
                );
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 300,
                height: 100,
                color: Colors.transparent,
                child: Text(
                  pro.address_ar,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFfb7750))),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => EditDescriptionFormPage()));
                  },
                  child: const Text(
                    'Add',
                  ))
            ],
          ),
        ),
        Positioned(
          bottom: 22,
          left: 16,
          child: CircleAvatar(
            backgroundColor: const Color(0xFFfb7750),
            child: IconButton(
              onPressed: () {
                var pos = pro.getCurrentLocation();
                pos.then((value) {});
              },
              icon: const Icon(FontAwesomeIcons.childReaching),
              alignment: Alignment.bottomLeft,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 64, right: 16),
          child: Row(
            children: [
              IconButton(
                color: const Color(0xFFfb7750),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MakeDashboardItems()));
                },
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(
                            color: Color(0xFFfb7750), width: 1.2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(
                            color: Color(0xFFfb7750), width: 1.2)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: const BorderSide(
                          color: Color(0xFFfb7750), width: 1.2),
                    ),
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFfb7750),
                    ),
                    hintText: "Search for location",
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),

        // CarouselWithDotsPage(imgList: imgList),
      ]),
    );
  }
}
