import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_davila/components/styles.dart';
import 'package:test_davila/pages/detailPostScreen.dart';
import 'package:test_davila/model/postModel.dart';

class ListPromotionsScreen extends StatefulWidget {
  const ListPromotionsScreen({Key? key}) : super(key: key);

  @override
  _ListPromotionsScreenState createState() => _ListPromotionsScreenState();
}

class _ListPromotionsScreenState extends State<ListPromotionsScreen> {
  int currentPage = 1;

  late int totalPages;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Item>? listPost = [];

  bool isAuth = false;

  //FUTURE TO CONSUME DATA FROM JSON
  Future<bool> getPostData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse("https://61c35faa9cfb8f0017a3eb2e.mockapi.io/api/v1/posts/?page=1&limit=10");

    final response = await http.get(uri);

    //CHECK THE RESPONSE
    if (response.statusCode == 200) {
      PostModel? postModel = postModelFromJson(response.body);
      List<Item>? items = postModel.items;

      if (isRefresh) {
        listPost = items;
      } else {
        listPost!.addAll(items!);
      }
      currentPage++;
      totalPages = 10;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  void _checkBiometric() async {
    // check for biometric availability
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    // enumerate biometric technologies
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Touch your finger on the sensor to login',
          useErrorDialogs: true,
          stickyAuth: false,
          androidAuthStrings: AndroidAuthMessages(signInTitle: "Login to HomePage"));
    } catch (e) {
      print("error using biometric auth: $e");
    }
    setState(() {
      isAuth = authenticated ? true : false;
    });

    print("authenticated: $authenticated");
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Screen Registra tu TOUCH ID

        return AlertDialog(
          title: isAuth ? Text("Identificacion Correcta") : Text("Ajusta tu Huella"),
          content: new Text("La Identificacion dactilar es correcta"),
          actions: <Widget>[
            new TextButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getPostData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getPostData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        child: Image.asset('assets/pv2.png'),
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                          onTap: () => {
                                if (isAuth == true) {_showDialog()} else {_checkBiometric()}
                              },
                          child: Icon(Icons.fingerprint_outlined))
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Text('TODAS LAS PROMOCIONES',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                  SizedBox(height: 80),
                  Container(
                      height: 600,
                      width: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listPost!.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                                onTap: () async {
                                  print(listPost![index]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DetailPostScreen(item: listPost![index])),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Stack(children: [
                                          Image.network(
                                            listPost![index].image.toString(),
                                            width: 250,
                                            height: 200,
                                          ),
                                          isAuth
                                              ? Padding(
                                                  padding: const EdgeInsets.only(top: 150.0),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(50),
                                                      child: Image.network(
                                                        'https://www.kindacode.com/wp-content/uploads/2020/11/my-dog.jpg',
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      )),
                                                )
                                              : SizedBox(),
                                        ]),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 230,
                                          width: 300,
                                          child: Column(
                                            children: [
                                              Text(listPost![index].title.toString(), style: Styles.textBlackGoogleFontSize(13)),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(listPost![index].description.toString(),
                                                    style: TextStyle(fontWeight: FontWeight.normal)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ));
                          })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
