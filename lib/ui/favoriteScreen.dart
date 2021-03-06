import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pickeat_app/controller/restaurant_controller.dart';

import 'package:pickeat_app/widgets/platformWidget.dart';

class FavoriteScreen extends StatefulWidget {
  static final routeName = '/favorite_page';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final RestaurantsController item = Get.find();
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(body:
         Obx(() {
            print("Fav Screen $item");
          return ListView.builder(
              itemCount: item.restaurantList.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(item.restaurantList[index].name!),
                );

              });
        })
        );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Text(
        "Coming Soon!",
        style: Theme.of(context).textTheme.headline3,
      ),
    ));
  }
}
