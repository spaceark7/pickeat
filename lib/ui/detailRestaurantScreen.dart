import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickeat_app/data/model/restaurant.dart';

class DetailScreen extends StatelessWidget {
  static final routeName = '/detail_screen';
  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(restaurant.name),
      ),
    );
  }
}
