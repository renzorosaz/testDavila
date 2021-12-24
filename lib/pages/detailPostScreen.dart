import 'package:flutter/material.dart';
import 'package:test_davila/components/styles.dart';
import 'package:test_davila/model/postModel.dart';

class DetailPostScreen extends StatefulWidget {
  Item? item;

  DetailPostScreen({required this.item});

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  List<Item>? listPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  child: Image.asset('assets/pv2.png'),
                ),
              ),
              SizedBox(height: 80),
              Container(
                width: 370,
                height: 210,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.item!.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(child: Text(widget.item!.user!.firstName.toString())),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Container(child: Text(widget.item!.description.toString())),
              ),

              //CREATE VALUE - METHOD - LIKE SETSTATE
              //ADD BUTTON
            ],
          ),
        ),
      ),
    );
  }
}
