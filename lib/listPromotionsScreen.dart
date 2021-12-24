import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  Future<bool> getPassengerData({bool isRefresh = false}) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getPassengerData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getPassengerData();
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
                  Container(
                    width: 200,
                    child: Image.asset('assets/pv2.png'),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Text('TODAS LAS PROMOCIONES', style: TextStyle(color: Colors.red, fontSize: 18)),
                  ),
                  SizedBox(height: 80),
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listPost!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 320,
                            height: 450,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(width: 420, height: 210, child: Image.network(listPost![index].image.toString())),
                                  Text(listPost![index].title.toString()),
                                  Container(child: Text(listPost![index].description.toString() + "..."))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
