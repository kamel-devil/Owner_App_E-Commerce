import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/data.dart';
import '../../widgets/category_item.dart';
import '../../widgets/custom_round_textbox.dart';
import '../../widgets/icon_box.dart';
import '../../widgets/recipe_item.dart';
import '../cards_design.dart';
import '../home_admin.dart';
import 'addproduct.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var qrstr = "let's Scan it";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                              builder: (context) => MakeDashboardItems()));
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
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: appBgColor,
            pinned: true,
            snap: true,
            floating: true,
            title: buildHeader(),
          ),
          SliverToBoxAdapter(
            child: buildSearchBlcok(),
          ),
          SliverToBoxAdapter(
            child: buildCategory(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => RecipeItem(
              data: recipes[index],
              onFavoriteTap: () {
                setState(() {
                  recipes[index]["is_favorited"] =
                      !recipes[index]["is_favorited"];
                });
              },
              onTap: () {},
            ),
            childCount: recipes.length,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanQr().whenComplete(() => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProduct())));
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

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Explore",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildSearchBlcok() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        children: [
          Expanded(
            child: CustomRoundTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
              suffix: null,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            radius: 50,
            padding: 8,
            child: SvgPicture.asset(
              "assets/icons/filter1.svg",
              color: darker,
              width: 18,
              height: 18,
            ),
          )
        ],
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

  int selectedCategoryIndex = 0;
  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
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
}
