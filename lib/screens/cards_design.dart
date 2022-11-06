import 'package:flutter/material.dart';
import 'package:owner_app/screens/shops/shops.dart';
import 'package:provider/provider.dart';

import '../profile/user1.dart';
import '../provider/provider.dart';
import '../resources/cache_image_network.dart';
import 'Expense/expense.dart';
import 'POS/POS.dart';
import 'customer/customer.dart';
import 'products/products.dart';
import 'supliers/suppliers.dart';

class MakeDashboardItems extends StatefulWidget {
  const MakeDashboardItems({Key? key}) : super(key: key);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF004B8D),
                    Color(0xFFffffff),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Customer_Screen()));
            }
            if (index == 1) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => supplier_screen()));            }
            if (index == 2) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Products()));            }
            if (index == 3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => POS()));
            }
            if (index == 4) {
              //5.item
            }
            if (index == 5) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Expense()));            }
            if (index == 6) {
              //6.item
            }
            if (index == 7) {
              //6.item
            }
            if (index == 8) {
              //6.item
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Image.network(
                  img,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 170, 193, 232),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Products()));
            },
          ),
          ListTile(
            title: const Text('suplaiers'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => supplier_screen()));
            },
          ),
          ListTile(
            title: const Text('Customer'),
            onTap: () {},
          ),
        ],
      )),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: buildCacheNetworkImage(
                width: double.infinity,
                height: 150,
                url:
                    'https://t4.ftcdn.net/jpg/03/06/69/49/360_F_306694930_S3Z8H9Qk1MN79ZUe7bEWqTFuonRZdemw.jpg'),
          ),
          Card(
            elevation: 2,
            color: const Color.fromARGB(255, 170, 193, 232),
            shadowColor: Colors.blueAccent,
            child: Container(
              padding: const EdgeInsets.only(bottom: 5,top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Name Shop",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: buildCacheNetworkImage(
                        width: 150,
                        height: 140,
                        url:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU_lGSsjGQHmThCUkRFbw7ZJOqcakt-WpQbA&usqp=CAU'),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem(
                    "Customer",
                    "https://cdn.iconscout.com/icon/premium/png-128-thumb/customer-service-3133192-2606595.png",
                    0),
                makeDashboardItem(
                    "Suppliers",
                    "https://cdn.iconscout.com/icon/premium/png-64-thumb/meeting-wtith-suppliers-6055997-5059915.png",
                    1),
                makeDashboardItem(
                    "Product",
                    "https://cdn3d.iconscout.com/3d/premium/thumb/product-5806313-4863042.png",
                    2),
                makeDashboardItem(
                    "POS",
                    "https://cdn.iconscout.com/icon/premium/png-64-thumb/pos-payment-1900136-1604802.png",
                    3),
                makeDashboardItem(
                    "All Orders",
                    "https://cdn3d.iconscout.com/3d/premium/thumb/order-processing-4735855-3934244.png",
                    4),
                makeDashboardItem(
                    "Expense",
                    "https://cdn.iconscout.com/icon/premium/png-64-thumb/expense-1523821-1289834.png",
                    5),
                makeDashboardItem(
                    "Report",
                    "https://cdn.iconscout.com/icon/premium/png-64-thumb/report-42-104117.png",
                    6),
                makeDashboardItem(
                    "Settings",
                    "https://cdn.iconscout.com/icon/premium/png-64-thumb/settings-1509074-1276642.png",
                    7),
                makeDashboardItem(
                    "LogOut",
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Human-gnome-logout.svg/1200px-Human-gnome-logout.svg.png",
                    8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
