import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:owner_app/screens/home_admin.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/components.dart';
import '../../provider/provider.dart';
import '../../resources/cache_image_network.dart';
import '../../resources/color_manager.dart';
import '../../resources/data.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/recipe_item.dart';
import '../cards_design.dart';
import 'add_suppliers.dart';
import 'editsupplier.dart';

class supplier_screen extends StatefulWidget {
  @override
  _supplier_screenState createState() => _supplier_screenState();
}

class _supplier_screenState extends State<supplier_screen> {
  var qrstr = "let's Scan it";
  TextEditingController _shopSearch = TextEditingController();
  String search = '';


  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suppliers',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black)),
        leading: SizedBox(
          width: 45,
          height: 45,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: Material(
                  color: const Color(0xffFD8F11).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const MakeDashboardItems()));
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                    color: const Color(0xffda6317),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: white,
        elevation: 0,
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
              controller: _shopSearch,
              // textAlignVertical: TextAlignVertical.bottom,
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
        ),

      ),
      body:FutureBuilder(
          future:  p.getSuppliersData(isRefreshSu: true, search,'103' ),
          builder: (context, snapshot) {
            return SmartRefresher(
              controller: p.refreshSuppliers,
              enablePullUp: true,
              onRefresh: () async {
                final result =
                await p.getSuppliersData(isRefreshSu: true, search,'103' );
                if (result) {
                  p.refreshSuppliers.refreshCompleted();
                } else {
                  p.refreshSuppliers.refreshFailed();
                }
              },
              onLoading: () async {
                final result = await  p.getSuppliersData( search,'103' );
                if (result) {
                  p.refreshSuppliers.loadComplete();
                } else {
                  p.refreshSuppliers.loadFailed();
                }
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(width: .1, color: darker),
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: buildCacheNetworkImage(
                                      width: 100,
                                      height: 100,
                                      url: p.dataSuppliers[index]["image"]),
                                ),

                                // CustomImage(
                                //   p.dataCustomer[index]["image"]??'https://indyme.com/wp-content/uploads/2020/11/customer-icon.png',
                                //   radius: 15,
                                //   height: 100,
                                //   borderRadius: null,
                                //   borderColor: Colors.white, bgColor: Colors.black,
                                // ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${p.dataSuppliers[index]["f_name"]}  ${p.dataSuppliers[index]["l_name"]}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: textColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          PopupMenuButton<int>(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  editsupplier_screen(
                                                                    id: p.dataSuppliers[
                                                                    index]['id'],
                                                                  )));
                                                    },
                                                    icon: Icon(Icons.edit)),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child:IconButton(
                                                    onPressed: () {
                                                      // Navigator.of(context).push(
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             editsupplier_screen(
                                                      //               id: p.dataSuppliers[
                                                      //               index]['id'],
                                                      //             )));
                                                    },
                                                    icon: Icon(Icons.delete,color: Colors.red,)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        p.dataSuppliers[index]["phone"],
                                        style: const TextStyle(
                                            fontSize: 14, color: labelColor),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: textColor,
                                                  size: 16,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  recipes[index]["rate"],
                                                  style:
                                                  const TextStyle(fontSize: 14),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        childCount: p.dataSuppliers.length,
                      )),
                ],
              ),
            );

          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const addSuppliers_Screen()));
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

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Skip', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;
        });
      });
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }
}
