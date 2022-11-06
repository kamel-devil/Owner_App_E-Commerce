
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  double widthIconText2 = 5.0,
  Color background = Colors.orangeAccent,
  Color colorIcon = Colors.white,
  Color colorIcon2 = Colors.white,
  Color Textcolor = Colors.white,
  bool isUpperCase = true,
  bool icon2 = false,
  bool icon1 = false,
  double radius = 3.0,
  double sizeicon = 15,
  double sizeicon2 = 15,
  bool shape = false,
  dynamic Iconbutton = Icons.call,
  dynamic Iconbutton2 = Icons.call,
  bool icon = false,
  required VoidCallback? function,
  required String text,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: width,
      height: height,
      decoration: shape == true
          ? const ShapeDecoration(

              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff53e78b), Color(0xff14be77)], ),
              shape: StadiumBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            )
          : BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff53e78b), Color(0xff14be77)], ),
              border: Border.all(color: primary, width: 0.2),
              borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
          onPressed: function,
          child: icon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (icon2 == true)
                      InkWell(
                        child: Icon(
                          Iconbutton2,
                          color: colorIcon2,
                          size: sizeicon2,
                        ),
                        onTap: () {},
                      ),
                    if (icon2 == true) const Spacer(),
                    Text(
                      isUpperCase ? text.toUpperCase() : text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Textcolor,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    if (icon1 == true) const Spacer(),
                    if (icon1 == true)
                      InkWell(
                        child: Icon(
                          Iconbutton,
                          color: colorIcon,
                          size: sizeicon,
                        ),
                        onTap: () {},
                      ),
                  ],
                )
              : Text(
                  isUpperCase ? text.toUpperCase() : text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Textcolor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                )),
    );

Widget builditemCategories(context, modelShop) => Container(
      height: 203,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(ImageAssets.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modelShop.name!,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      modelShop.rate! > 0
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      modelShop.rate! > 1
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      modelShop.rate! > 2
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      modelShop.rate! > 3
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      modelShop.rate! > 4
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      modelShop.rate! > 5
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      const SizedBox(
                        width: 25,
                      ),
                      defaultButton(
                          Textcolor: primary,
                          icon2: true,
                          icon: true,
                          Iconbutton2: Icons.edit,
                          colorIcon2: primary,
                          height: 25,
                          sizeicon2: 25,
                          icon1: false,
                          Iconbutton: Icons.done,
                          colorIcon: white,
                          width: 100,
                          shape: false,
                          background: Colors.white,
                          function: () {},
                          text: 'Edit ',
                          isUpperCase: false),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.call,
                          color: green,
                        ),
                        onTap: () async {
                          final String phoneUrl = 'tel: ${modelShop.phone}';
                          if (await canLaunch(phoneUrl)) {
                            await launch(phoneUrl);
                          } else {
                            throw 'Could not launch $phoneUrl';
                          }
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        modelShop.phone!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.add_location_outlined,
                          color: blue,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: Text(
                          modelShop.address!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: black),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {},
                      child: Card(
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'All Review ',
                            style: TextStyle(
                                fontSize: 15, color: primary),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget builditemAdress(context) => Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(ImageAssets.person), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Item',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '& 55.5',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: primary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 110,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Quantity : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: black)),
                          TextSpan(
                              text: '2',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: primary))
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Addons '),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Cheese'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Vardation',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Size 12*'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget builditemOrder(context) => Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(ImageAssets.person),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'name :',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: ' Mr/mohamed',
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.w500,
                              ))
                        ]),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Quantity : ',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: black)),
                          TextSpan(
                              text: '2',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: black))
                        ]),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Total Amount : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: black)),
                          const TextSpan(
                              text: '22556.3',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent))
                        ]),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Date : ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: black)),
                          const TextSpan(
                              text: '22/22/2020',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))
                        ]),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Barcode :',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 20,
                            width: 120,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageAssets.barcode0),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultButton(
                    icon2: false,
                    icon: false,
                    height: 40,
                    sizeicon2: 25,
                    Iconbutton: Icons.search,
                    colorIcon: white,
                    width: 150,
                    shape: false,
                    Textcolor: primary,
                    background: Colors.white,
                    function: () {},
                    text: 'Ignore',
                    isUpperCase: false),
                const SizedBox(
                  width: 10,
                ),
                defaultButton(
                    icon2: false,
                    icon: false,
                    height: 40,
                    sizeicon2: 25,
                    Iconbutton: Icons.search,
                    colorIcon: white,
                    width: 150,
                    shape: false,
                    Textcolor: white,
                    background: primary,
                    function: () {},
                    text: 'Accept',
                    isUpperCase: false),
              ],
            )
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10.0,
        end: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildCategories(check, Popservices) => Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Card(
              child: Image(
                image: NetworkImage(Popservices['image']),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (check == false)
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                  color: Colors.black.withOpacity(.38),
                  width: 160,
                  height: 30,
                  child: Text(
                    Popservices['name'],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  )),
            ),
          if (check == false)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                color: whiteOpactity,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Popservices['rate'] > 0
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                    Popservices['rate'] > 1
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                    Popservices['rate'] > 2
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                    Popservices['rate'] > 3
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                    Popservices['rate'] > 4
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                    Popservices['rate'] > 5
                        ? Icon(
                            Icons.star,
                            color: primary,
                            size: 17,
                          )
                        : Icon(
                            Icons.star_border_purple500_sharp,
                            color: black,
                            size: 17,
                          ),
                  ],
                ),
              ),
            ),
          if (check == true)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Checkbox(
                onChanged: (value) {},
                value: false,
              ),
            ),
        ],
      ),
    );
Widget builditemdetailServiceCategories(context, detailsServices) => Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 110,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(detailsServices.image!),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailsServices.name!,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      detailsServices.rate! > 0
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      detailsServices.rate! > 1
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      detailsServices.rate! > 2
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      detailsServices.rate! > 3
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      detailsServices.rate! > 4
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      detailsServices.rate! > 5
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      Textcolor: primary,
                      icon2: true,
                      icon: true,
                      Iconbutton2: Icons.edit,
                      colorIcon2: primary,
                      height: 40,
                      sizeicon2: 25,
                      Iconbutton: Icons.done,
                      colorIcon: white,
                      width: 150,
                      shape: false,
                      background: Colors.white,
                      function: () {},
                      text: 'Edit ',
                      isUpperCase: false),
                ],
              ),
            )
          ],
        ),
      ),
    );
Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? textStyle,
  TextStyle? labelStyle,
  InputBorder? enabledBorder,
  bool isPassword = false,
  bool buttonIcon = false,
  ValueChanged? change,
  VoidCallback? suffixPressed,
   FormFieldValidator<String>? validate,
  required String? label,
  IconData? prefix,
  OutlineInputBorder? myfocusborder,
  ValueChanged? onSubmit,
  IconData? suffix,
  bool isClickable = true,
  int? maxlength,
  GestureTapCallback? TapWhenClick,
   void Function(String?)? save
}) =>
    TextFormField(
      onSaved:save,
      onTap: TapWhenClick,
      controller: controller,
      style: textStyle,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      enabled: isClickable,
      onChanged: change,
      maxLength: maxlength,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        enabledBorder: enabledBorder,
        labelText: label,
        labelStyle: labelStyle,
        focusedBorder: myfocusborder,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null && buttonIcon == false
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : buttonIcon == true
                ? Container(
                    width: 80,
                    child: InkWell(
                      onTap: suffixPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(suffix),
                          SizedBox(
                            width: 55,
                            child: Text(
                              'Get Location',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget buildItemCridView(text, number, color, height, speace) => Container(
      height: height,
      width: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: speace,
            ),
            Text(number,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25)),
          ],
        ),
      ),
    );
Widget builditemwallexpense() => Container(
      height: 183,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              true
                  ? Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(ImageAssets.image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20)),
                    )
                  : Container(
                      height: 130,
                      width: 110,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(''), fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(20)),
                    ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'name :',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(width: 150,),
                            InkWell(
                              child: Icon(
                                Icons.call,
                                color: green,
                              ),
                              onTap: () async {
                                final String phoneUrl = 'tel:';
                                if (await canLaunch(phoneUrl)) {
                                  await launch(phoneUrl);
                                } else {
                                  throw 'Could not launch $phoneUrl';
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Service type :',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        true
                            ? Row(
                                children: [
                                  const Text(
                                    'Barcode :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff53e78b)),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(ImageAssets.barcode0),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Phone :',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'Location :',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    ' ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.add_location_outlined,
                                color: blue,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Date :',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: black),
                                ),
                                TextSpan(
                                  text: ' 15/2/2020',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: black),
                                )
                              ]),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: black,
                                )),
                            const SizedBox(width: 10),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.delete,
                                  color: black,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
Widget buildGridproduct(context, allservices) => Container(
      color: Colors.white,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Image(
                image: NetworkImage(allservices['image']),
                width: double.infinity,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.8, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    allservices['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      allservices['rate'] > 0
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 1
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 2
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 3
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 4
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 5
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
Widget builditemService(context, allservices) => Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(allservices['image']),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    allservices['name'],
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    allservices['desc'] == null ? 'desc' : allservices['desc'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      allservices['rate'] > 0
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 1
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 2
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 3
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 4
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                      allservices['rate'] > 5
                          ? Icon(
                              Icons.star,
                              color: primary,
                              size: 17,
                            )
                          : Icon(
                              Icons.star_border_purple500_sharp,
                              color: black,
                              size: 17,
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
builditemAppbar(context) => InkWell(
      child: const Icon(Icons.arrow_back),
      onTap: () {},
    );
builditemdetailsservice(context, detailsServices) => showModalBottomSheet(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 31.4,
              left: 2,
              right: 2,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          builditemdetailServiceCategories(
                              context, detailsServices),
                          myDivider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Descripes',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Masasaa losdasld alsdlasdao asldlasldo asdlalsdoa lalsdoa sdasdasd asdasda asdasd asda .',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 130,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: 130,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        detailsServices
                                                            .gallery![index]),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              width: 5,
                                            ),
                                        itemCount:
                                            detailsServices.gallery!.length),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            'Review ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: black),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: primary,
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: primary,
                                                size: 15,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: primary,
                                                size: 15,
                                              ),
                                              const Icon(
                                                Icons
                                                    .star_border_purple500_sharp,
                                                size: 15,
                                              ),
                                              const Icon(
                                                Icons
                                                    .star_border_purple500_sharp,
                                                size: 15,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text('(212)'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 73 * 20,
                                        child: ListView.separated(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  myDivider(),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      '11 Septemper 2020 ',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'A******** ',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:

                                                                      black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color:
                                                                        primary,
                                                                size: 15,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color:
                                                                        primary,
                                                                size: 15,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color:
                                                                        primary,
                                                                size: 15,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .star_border_purple500_sharp,
                                                                size: 15,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .star_border_purple500_sharp,
                                                                size: 15,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'Every came in the very well packet 0000000 is edcadaksdas asa asdas dasd asd asd asda',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color:
                                                              black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => myDivider(),
                                            itemCount: 20),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      myDivider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

void ShowToast({required String text, required Toaststates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum Toaststates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(Toaststates state) {
  Color color;
  switch (state) {
    case Toaststates.SUCCESS:
      color = Colors.green;
      break;
    case Toaststates.ERROR:
      color = Colors.red;
      break;
    case Toaststates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
buildItemlistCategoriesTop(context, categories, cubic) => SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: AppPadding.p8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: buildbutton(context, categories![index], index, cubic),
            ),
          ),
          itemCount: categories!.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
        ),
      ),
    );
buildbutton(context, categories, index, cubic) => defaultButton(
    icon: true,
    shape: false,
    width: 170,
    icon2: true,
    Iconbutton2: IconDataSolid(int.parse(categories['icon_name'])),
    Textcolor: black,
    colorIcon2: HexColor(categories['color']),
    background: cubic.indexService == index
        ? primary
        : whiteOpactity,
    function: () {
      cubic.changeBottomService(index);
    },
    text: categories['name'],
    isUpperCase: false);
