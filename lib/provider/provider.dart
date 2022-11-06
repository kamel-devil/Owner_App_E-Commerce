import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Funcprovider with ChangeNotifier {
  // List<Marker> mark = [];
  int currentPage = 1;//page

  List cate = [];
  List passengers = [];//shops list
  List servicesSh = [];
  List popShopsDa = [];
  Map shopDa = {};


  Map customerEdit = {};
  List dataCustomer = [];
  List listCutomer = [];

  List dataSuppliers = [];

  List dataRanking = [];
  List sliderData = [];

  double? lat;
  double? long;
  Map addressData = {};
  String? address;
  String address_en = '';
  String address_ar = '';


  File? file;
  File? image;
  final picker = ImagePicker();
  File? selectedFile;


  Locale lang = Locale('ar');


  bool result = false;
  final RefreshController refreshShop =
  RefreshController(initialRefresh: true);
  final RefreshController refreshSuppliers =
  RefreshController(initialRefresh: true);
  final RefreshController refreshCustomer =
  RefreshController(initialRefresh: true);
  bool isLogin = false;



  int? isMe;
  // List<Marker> mark = [];

  List sub = [];
  List dataCard = [];
  Map userData = {};
  List popshopsda = [];

  Map shopda = {};
  Map infLogin = {};
  Map infShop = {};
  Map dataProfile = {};



  // File? file;

  String? token;
  String? subId;

  void changeLang(Locale locale) {
    lang = locale;
  }

  Future requestPermission(Permission permission) async {
    final result = await permission.request();
    return result;
  }

  void askPermissionCamera() {
    requestPermission(Permission.camera).then(onStatusRequestedCamera);
  }

  void askPermissionStorage() {
    requestPermission(Permission.storage).then(onStatusRequested);
  }

  void askPermissionPhotos() {
    requestPermission(Permission.photos).then(onStatusRequested);
  }

  void onStatusRequested(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if(status == PermissionStatus.permanentlyDenied){
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.gallery);
    }
  }

  void onStatusRequestedCamera(status) {
    if (status != PermissionStatus.granted) {
      if (Platform.isIOS) {
        openAppSettings();
      } else {
        if(status == PermissionStatus.permanentlyDenied){
          openAppSettings();
        }
      }
    } else {
      getImage(ImageSource.camera);
    }
  }

  void getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if(image != null){
      File? cropped = await ImageCropper.cropImage(
          sourcePath: image!.path,
          aspectRatio: const CropAspectRatio(
              ratioX: 1000, ratioY: 700),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          cropStyle:CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: const AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            toolbarColor: Colors.white,
            toolbarTitle: 'Edit Images',
            statusBarColor: Color(0xFF0181cc),
            activeControlsWidgetColor: Color(0xFF515151),
            cropFrameColor: Colors.white,
            cropGridColor: Colors.white,
            toolbarWidgetColor: Color(0xFF515151),
            backgroundColor: Colors.white,
              showCropGrid:false
          )
      );
      if(cropped!=null){
        if(selectedFile!=null && selectedFile!.existsSync()){
          selectedFile!.deleteSync();
        }
        selectedFile = cropped;
      }

      // delete image camera
      if(source.toString()=='ImageSource.camera' && image!.existsSync()){
        image!.deleteSync();
      }

      image = null;
    }
    notifyListeners();
  }


  Future getDataCate(String id) async {
    String url =
        'https://ibtikarsoft.net/finder/api/admin/shop_categories.php?lang=ar&token=aruv8kzsmyo7&cat=$id';
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        cate = data;
      }
    } else {
      print("Error");
    }
    print('get data cate');
    // notifyListeners();
    return cate;
  }


  void change(double lat1, double long1) {
    lat = lat1;
    long = long1;
    notifyListeners();
  }

  Future login(String email, password) async {
    var response = await post(
        Uri.parse('https://ibtikarsoft.net/finder/api/shop/login.php'),
        body: {"username": email, "password": password});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    token = infLogin['token'];
    print(token);

    return infLogin;
  }

  dataShop(String id) async {
    var D = await get(
        Uri.parse('https://ibtikarsoft.net/mapapi/shop.php?lang=$lang&shop=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      shopDa = x;
    }
    print('https://ibtikarsoft.net/mapapi/shop.php?lang=$lang&shop=$id');
    return shopDa;
  }


  // datashops() async {
  //   var D = await get(Uri.parse(
  //       'https://ibtikarsoft.net/finder/api/user/shops.php?lang=ar&token=v4mdo2s8769e&lat=30.0374562&long=31.2095052&cat=0&page=$currentPage'));
  //   if (D.statusCode == 200) {
  //     var x = json.decode(D.body);
  //     shopsda = x;
  //   }
  //   print('https://ibtikarsoft.net/mapapi/shops.php?lang=${_locale(LAGUAGE_CODE)}&lat=30.0374562&long=31.2095052&cat=0'
  //   );
  //   return shopsda;
  // }
  Future<bool> getPassengerData(String search,int currentPage,String id,{bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      // if (currentPage >= totalPages) {
      //   refreshController.loadNoData();
      //   return false;
      // }
      if (passengers.isEmpty) {
        refreshShop.loadNoData();
        return false;
      }
    }
    final Uri uri = Uri.parse(
        "https://ibtikarsoft.net/finder/api/admin/shops.php?token=aruv8kzsmyo7&lang=ar&lat=29.99738139451116&long=31.138789320917386&cat=$id&page=$currentPage&search=$search");

    final response = await get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (isRefresh) {
        passengers = result;
      }else{
        passengers.addAll(result);
      }

      // currentPage++;

      // totalPages = result[4];
// notifyListeners();
      print(response.body);
      return true;
    } else {
      return false;
    }
  }


  Future Servicessh(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/services.php?lang=ar&shop=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      servicesSh = x;
    }
    return servicesSh;
  }

  Future ranking() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/admin/ranking.php?lang=ar&token=aruv8kzsmyo7&type=day'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      dataRanking = x;
    }
    print(dataRanking.length);
    print(dataRanking);
    return dataRanking;
  }

  dataPopShops(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/shops.php?lang=ar&lat=30.0374562&long=31.2095052&cat=0&pop=5'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      popShopsDa = x;
    }
    return popShopsDa;
  }

  Future<Position?> getCheckLocation() async {
    Geolocator.checkPermission().then((value) {
      print(value);
      if (value == LocationPermission.denied) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied) {
            print("denied");
          } else if (value == LocationPermission.whileInUse) {
            print('go ');
            getCurrentLocation();
            notifyListeners();
          } else {}
        });
      } else {
        getCurrentLocation();
      }
    });
    notifyListeners();
    return null;
  }

  Future<Position?> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPsition = await Geolocator.getLastKnownPosition();
    print('------------------------**-----------**--------');
    print(lastPsition?.latitude);
    print(lastPsition?.longitude);
    lat = lastPsition!.latitude;
    long = lastPsition.longitude;
    notifyListeners();
    return lastPsition;
    // locationMessage="$position.latitude ,$position.longitude";
  }

  checkInternet() async {
    bool result1 = await InternetConnectionChecker().hasConnection;
    if (result1 == true) {
      print('Connection Done');
    } else {
      print('Connection failed');
    }

    result = result1;
    notifyListeners();
  }

  void getAddressInfo(double latAddress, double longAddress) async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latAddress&lon=$longAddress&accept-language=$lang';
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      Map data = json.decode(res.body);
      if (data.isNotEmpty) {
        addressData = data;

        address = data['display_name'];
        print(address);
        notifyListeners();
      }
    } else {
      print("Error");
    }
  }
  saveUserData(String image, String token, String f_name, String l_name,String shops,String shop_id,String shop_name,String shop_image) async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = {
      "token": token,
      "f_name": f_name,
      "l_name": l_name,
      "image": image,
      "shops": shops,
      "shop_id": shop_id,
      "shop_name": shop_name,
      "shop_image": shop_image
    };
    String encodedMap = json.encode(dataUser);
    prefs.setString('userData', encodedMap);
  }

  void changeLogin(bool z) {
    isLogin = z;
    saveLogin(z);
  }
  Future saveToken(String vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', vall);
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    notifyListeners();
    return prefs.getString('token');
  }

  Future saveLogin(bool vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', vall);
  }

  Future getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLogin = prefs.getBool('login') ?? false;
    return prefs.getBool('login');
  }
  Future getDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('userData');
    userData = json.decode(encodedMap!);
    return userData;
  }

  Future<void> clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userData');
  }

  Future profile() async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=show'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      dataProfile = x;
    }
    print(dataProfile);
    return dataProfile;
  }

  // Future customer(String search) async {
  //   var D = await get(Uri.parse(
  //       'https://ibtikarsoft.net/finder/api/shop/customers.php?token=$token&shop=103&lang=ar&search=$search&page=1'));
  //   if (D.statusCode == 200) {
  //     var x = json.decode(D.body);
  //     dataCustomer = x;
  //   }
  //   print(dataCustomer);
  //   return dataCustomer;
  // }
  Future<bool> getCustomerData(String search, String id,
      {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      // if (currentPage >= totalPages) {
      //   refreshController.loadNoData();
      //   return false;
      // }
      if (dataCustomer.isEmpty) {
        refreshCustomer.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        "https://ibtikarsoft.net/finder/api/shop/customers.php?token=$token&shop=$id&lang=ar&search=$search&page=$currentPage");

    final response = await get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (isRefresh) {
        dataCustomer = result;
      } else {
        dataCustomer.addAll(result);
      }

      currentPage++;

      // totalPages = result[4];
      print(response.body);
      print("https://ibtikarsoft.net/finder/api/shop/customers.php?token=$token&shop=$id&lang=ar&search=$search&page=$currentPage");
      return true;
    } else {
      return false;
    }
  }
  Future<bool> getSuppliersData(String search, String id,
      {bool isRefreshSu = false}) async {
    if (isRefreshSu) {
      currentPage = 1;
    } else {
      // if (currentPage >= totalPages) {
      //   refreshController.loadNoData();
      //   return false;
      // }
      if (dataSuppliers.isEmpty) {
        refreshSuppliers.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        "https://ibtikarsoft.net/finder/api/shop/suppliers.php?token=$token&shop=$id&lang=ar&search=$search&page=$currentPage");

    final response = await get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (isRefreshSu) {
        dataSuppliers = result;
      } else {
        dataSuppliers.addAll(result);
      }

      currentPage++;

      // totalPages = result[4];
      print(response.body);
      print("https://ibtikarsoft.net/finder/api/shop/customers.php?token=$token&shop=$id&lang=ar&search=$search&page=$currentPage");
      return true;
    } else {
      return false;
    }
  }


  Future updateProfileWithImage(String file) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update"));

    // request.fields.addAll(data!);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes('image', File(file).readAsBytesSync(),
        filename: file);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }

  Future updateProfileName(String fName, lName) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"f_name": fName, "l_name": lName});
    Map x = json.decode(response.body);
    infLogin = x;
print('https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update');
    return infLogin;
  }

  Future updateProfilePhone(String phone) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"phone": phone});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future updateProfileEmail(String email) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"email": email});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future updateProfileAddress(String address) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"address": address});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future updateProfileUsername(String username) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"username": username});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future updateProfileBirth(String dob) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=update'),
        body: {"dob": dob});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future updateProfilePassword(String old_pass, String new_pass) async {
    var response = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/shop/profile.php?token=$token&lang=$lang&action=password'),
        body: {"old_pass": old_pass, 'new_pass': new_pass});
    Map x = json.decode(response.body);
    infLogin = x;
    print('--------------------');
    print(infLogin);
    return infLogin;
  }

  Future uploadCustomer(
      Map<String, String> data,
      File file,
      ) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/shop/customers_add.php?token=rlpuiw7u3mi4&shop=103&lang=ar"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);
    // listCutomer = json.decode(result);
    print(result);
    notifyListeners();
    // print(res.headers);
  }

  editCustomer({required String id}) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/shop/customers_edit.php?token=rlpuiw7u3mi4&shop=103&lang=ar&customer=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      customerEdit = x;
      // if (x.isNotEmpty) {
      //   ownerEdit = x;
      //
      //   fName = x['f_name'];
      //   lName = x['l_name'];
      //   userName = x['username'];
      //   phone = x['phone'];
      //   image=x['image'];
      //   print(fName);
      // }
    }
    return customerEdit;
  }
  Future updateCustomer(
      {required Map<String, String> data,
        required String file,
        required String id}) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/shop/customers_update.php?token=rlpuiw7u3mi4&shop=103&lang=ar&customer=$id"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes('image', File(file).readAsBytesSync(),
        filename: file);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }


  Future uploadSuppliers(
      Map<String, String> data,
      File file,
      ) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/shop/suppliers_add.php?token=rlpuiw7u3mi4&shop=103&lang=ar"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes(
        'image', File(file.path).readAsBytesSync(),
        filename: file.path);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);
    // listCutomer = json.decode(result);
    print(result);
    notifyListeners();
    // print(res.headers);
  }

  editSuppliers({required String id}) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/finder/api/shop/suppliers_edit.php?token=rlpuiw7u3mi4&shop=103&lang=ar&supplier=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);
      customerEdit = x;
      // if (x.isNotEmpty) {
      //   ownerEdit = x;
      //
      //   fName = x['f_name'];
      //   lName = x['l_name'];
      //   userName = x['username'];
      //   phone = x['phone'];
      //   image=x['image'];
      //   print(fName);
      // }
    }
    return customerEdit;
  }


  Future updateSuppliers(
      {required Map<String, String> data,
        required String file,
        required String id}) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            "https://ibtikarsoft.net/finder/api/shop/suppliers_update.php?token=rlpuiw7u3mi4&shop=103&lang=ar&supplier=$id"));

    request.fields.addAll(data);
    request.headers['Authorization'] = "";
    //  request.files.add(http.MultipartFile.fromBytes('file', File(file.path).readAsBytesSync(),filename: file.path));
    //  var res = await request.send();

    var picture = MultipartFile.fromBytes('image', File(file).readAsBytesSync(),
        filename: file);

    request.files.add(picture);
    var response = await request.send();
    var responsseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responsseData);

    print(result);
    notifyListeners();
    // print(res.headers);
  }
}
