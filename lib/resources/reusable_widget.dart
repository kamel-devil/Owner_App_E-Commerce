import 'dart:async';

import 'package:flutter/material.dart';

class ReusableWidget{
  PreferredSizeWidget bottomAppBar(){
    return PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey[100],
          height: 1.0,
        ));
  }

  Widget createRatingBar({double rating=5, double size=24}){
    if(rating < 0){
      rating = 0;
    } else if(rating>5){
      rating = 5;
    }

    bool absolute = false;
    int fullStar = 0;
    int emptyStar = 0;

    if(rating == 0 || rating == 1 || rating == 2 || rating == 3 || rating == 4 || rating == 5){
      absolute = true;
    } else {
      double dec = (rating - int.parse(rating.toString().substring(0,1)));
      if(dec > 0 && dec < 1){
        if(dec >= 0.25 && dec <= 0.75){
          absolute = false;
        } else {
          absolute = true;
          if(dec < 0.25){
            emptyStar = 1;
          } else if(dec > 0.75){
            fullStar = 1;
          }
        }
      }
    }
    return Row(
      children: [
        for(int i=1;i<=rating+fullStar;i++) Icon(Icons.star, color: Colors.yellow[700], size: size),
        !absolute?Icon(Icons.star_half, color: Colors.yellow[700], size: size):const SizedBox.shrink(),
        for(int i=1;i<=(5-rating+emptyStar);i++) Icon(Icons.star_border, color: Colors.yellow[700], size: size),
      ],
    );
  }

  Widget customNotifIcon({int count=0, Color notifColor=Colors.grey, Color labelColor=Colors.pinkAccent, double notifSize=24, double labelSize=14, String position='right'}) {
    double? posLeft;
    double? posRight = 0;
    if(position == 'left'){
      posLeft = 0;
      posRight = null;
    }
    return Stack(
      children: <Widget>[
        Icon(Icons.notifications, color: notifColor, size: notifSize),
        Positioned(
          left: posLeft,
          right: posRight,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: BorderRadius.circular(labelSize),
            ),
            constraints: BoxConstraints(
              minWidth: labelSize,
              minHeight: labelSize,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget divider1(){
    return Divider(height: 0, color: Colors.grey[400]);
  }

  Future _showProgressDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  // dummy loading
  void startLoading(context, String textMessage, int backToPreviousPageStack){
    _showProgressDialog(context);
    Timer(const Duration(seconds: 2), () {
      Navigator.pop(context);
      _buildShowDialog(context, textMessage, backToPreviousPageStack);
    });
  }

  Future _buildShowDialog(BuildContext context, String textMessage, int backToPreviousPageStack) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      textMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.black12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.cyanAccent),
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          if(backToPreviousPageStack>0){
                            FocusScope.of(context).unfocus(); // hide keyboard when press button
                            for(int i=1;i<=backToPreviousPageStack;i++){
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  // end dummy loading

  Widget createDefaultLabel(context){
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(2)
      ),
      child: Row(
        children: const [
          Text('Default', style: TextStyle(
              color: Colors.white, fontSize: 13
          )),
          SizedBox(
            width: 4,
          ),
          Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }
}