import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../provider/provider.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF212232),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.arrow_back_outlined,
        ),
        actions: const [
          Icon(
            Icons.grid_view,
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(colors: [
                    Colors.yellow.shade600,
                    Colors.orange,
                    Colors.red
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xFF2B3245)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Day',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          Text('Weak',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold)),
                          Text('Months',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: p.ranking(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && p.dataRanking.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            WinnerContainer(
                              color: p.dataRanking[1]['is_me']==true?Colors.amber:Color(0xFF2B3245),
                              winnerPosition:
                                  p.dataRanking[1]['rank'].toString(),
                              height: 120.0,
                              winnerName: p.dataRanking[1]['name'],
                              image: p.dataRanking[1]['image'],
                              countRank: p.dataRanking[1]['points'].toString(),
                            ),
                            WinnerContainer(
                              isFirst: true,
                              color: p.dataRanking[0]['is_me']==true?Colors.amber:Color(0xFF2B3245),
                              winnerPosition:
                                  p.dataRanking[0]['rank'].toString(),
                              height: 140.0,
                              winnerName: p.dataRanking[0]['name'],
                              image: p.dataRanking[0]['image'],
                              countRank: p.dataRanking[0]['points'].toString(),
                            ),
                            WinnerContainer(
                              color: p.dataRanking[2]['is_me']==true?Colors.amber:Color(0xFF2B3245),
                              winnerPosition:
                                  p.dataRanking[2]['rank'].toString(),
                              height: 100.0,
                              winnerName: p.dataRanking[2]['name'],
                              image: p.dataRanking[2]['image'],
                              countRank: p.dataRanking[2]['points'].toString(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  gradient: LinearGradient(colors: [
                    Colors.yellow.shade600,
                    Colors.orange,
                    Colors.red
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Color(0xFF212232),
                    ),
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: p.dataRanking.length,
                      itemBuilder: (BuildContext context, int index) {
                        _scrollController.scrollTo(
                            index: 7, duration: Duration(seconds: 1));
                        return itemRang(index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemRang(index) {
    var p = Provider.of<Funcprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: p.dataRanking[index]['is_me'] == true
                ? Colors.amber
                : Color(0xFF2B3245)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text(
                  '${p.dataRanking[index]['rank'] ?? '1'}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    p.dataRanking[index]['image'] ??
                        'https://cdn-icons-png.flaticon.com/128/4128/4128176.png',
                    height: 60.0,
                    width: 60.0,
                    fit: BoxFit.cover,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.dataRanking[index]['name'] ?? 'Name',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '@${p.dataRanking[index]['name'] ?? 'Name'}',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${p.dataRanking[index]['points'] ?? '1234'}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WinnerContainer extends StatelessWidget {
  final bool? isFirst;
  final Color? color;
  final String? winnerPosition;
  final String? image;
  final String? winnerName;
  final String? rank;
  final String? countRank;
  final double? height;

  const WinnerContainer(
      {Key? key,
      this.isFirst = false,
      this.color,
      this.winnerPosition,
      this.winnerName,
      this.rank,
      this.height,
      this.image,
      this.countRank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<Funcprovider>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: Container(
                height: height ?? 140.0,
                width: 100.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellow.shade600,
                      Colors.orange,
                      Colors.red
                    ]),
                    border: Border.all(color: Colors.amber),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                      color:color??Color(0xFF2B3245),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 7, left: 15),
                    child: isFirst == true
                        ? Image.asset('assets/images/king.png',
                            height: 70.0, width: 70.0)
                        : Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 15),
                  child: Container(
                    height: 80.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red),
                        image: DecorationImage(
                            image: NetworkImage(image ??
                                'https://cdn.iconscout.com/icon/free/png-128/avatar-370-456322.png'),
                            fit: BoxFit.fill)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 115.0, left: 15),
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Center(
                      child: Text(
                        winnerPosition ?? '1',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0, left: 23),
            child: Column(
              children: [
                Text(
                  winnerName ?? 'Kamel',
                  maxLines: 3,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  countRank ?? '99999',
                  style: TextStyle(
                      color:Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class ContestantList extends StatelessWidget {
//   final String? image;
//   final String? winnerName;
//   final String? rank;
//   final String? winnerPosition;
//
//   const ContestantList({Key? key, this.image, this.winnerName, this.rank, this.winnerPosition}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var p = Provider.of<Funcprovider>(context);
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         decoration:  BoxDecoration(
//           borderRadius: BorderRadius.circular(20.0),
//           color: Color(0xFF2B3245)
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 13.0),
//                 child: Text(
//                   winnerPosition??'1',
//                   style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
//                 ),
//               ),
//               ClipOval(
//                   clipBehavior: Clip.antiAlias,
//                   child: Image.network(
//                     image??'https://cdn-icons-png.flaticon.com/128/4128/4128176.png',
//                     height: 60.0,
//                     width: 60.0,
//                     fit: BoxFit.cover,
//                   )),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:  [
//                   Text(
//                     winnerName??'Name',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   Text(
//                     '@${winnerName ?? 'Name'}',
//                     style: TextStyle(color: Colors.white54),
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:  [
//                   Text(
//                     rank??'1234',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   Icon(
//                     Icons.favorite,
//                     color: Colors.red,
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
