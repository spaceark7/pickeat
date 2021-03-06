import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/controller/restaurant_controller.dart';
import 'package:pickeat_app/data/model/restaurant.dart';

class DetailScreen extends StatefulWidget {
  static final routeName = '/detail_screen';
  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final imageUrl = "https://restaurant-api.dicoding.dev/images/medium/";
  final RestaurantsController item = Get.find();
  @override
  void initState() {
    item.fetchRestaurantDetail(item.id.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
      headerSliverBuilder: _sliverBuilder,
      body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                             item.restaurantInfo.value.rating.toString(),
                              style: Theme.of(context).textTheme.bodyText1!.apply(
                               color: secondaryBrandColor,
                               fontSizeDelta: 32.0,
                               fontWeightDelta: 5),
                           )),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Overall Score',
                                      style: Theme.of(context).textTheme.bodyText1),
                            Obx(() => 
                              RatingBar.builder(
                                     initialRating: item.restaurantInfo.value.rating!,
                                      itemBuilder: (context, _) => 
                                      Icon( Platform.isIOS
                                                ? CupertinoIcons.star
                                                : Icons.star,
                                            size: 8,
                                            color: secondaryBrandColor,
                                          ),
                                          itemSize: 18,
                                          itemCount: 5,
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {},
                                          allowHalfRating: true,
                                  ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Platform.isIOS ? CupertinoIcons.placemark : Icons.place,
                        color: secondaryBrandColor,
                        size: 24,
                      ),
                    ),
                    Text(
                      item.restaurantInfo.value.address!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Divider(
                  color: Colors.black38,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Description',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .apply(fontSizeDelta: 5),
                ),
                SizedBox(
                  height: 16,
                ),
                ExpandableText(
                  widget.restaurant.description,
                  expandText: 'Read More',
                  collapseText: 'Show Less',
                  animation: true,
                  maxLines: 3,
                  collapseOnTextTap: true,
                  linkColor: accentBrandColor,
                  animationDuration: Duration(milliseconds: 500),
                  animationCurve: Curves.ease,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    "Menus",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Divider(
                  color: Colors.black38,
                ),
                SizedBox(
                  height: 16,
                ),
                // menuGridHorizontal(context, foods, "Foods"),

                // SizedBox(height: 16.0,),
                // menuGridHorizontal(context, drinks, "Drinks"),
                // SizedBox(height: 69.0,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          primary: secondaryBrandColor,
                          textStyle: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        defaultTargetPlatform == TargetPlatform.iOS
                            ? showCupertinoDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Coming Soon!'),
                                    content: Text(
                                        'This feature will be coming soon!'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Coming Soon!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .apply(
                                              fontWeightDelta: 5,
                                              fontSizeDelta: 5),
                                    ),
                                    content: Text(
                                      'This feature will be coming soon!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .apply(fontWeightDelta: 5),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: secondaryBrandColor),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Dismiss'),
                                      ),
                                    ],
                                  );
                                },
                              );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Text("Book Table"),
                      )),
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget menuGridHorizontal(
      BuildContext context, List<String> items, String category) {
    return Column(
      children: [
        Text(
          '$category Selection',
          style: Theme.of(context)
              .textTheme
              .caption!
              .apply(fontSizeDelta: 7, fontWeightDelta: 7),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 5,
            children: _listFoodGrid(items),
          ),
        ),
      ],
    );
  }

  List<Material> _listFoodGrid(List<String> foods) {
    return foods
        .map((e) => Material(
              elevation: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: accentBrandColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      e,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  List<Widget> _sliverBuilder(context, isScrolled) {
    return [
      Obx(() => SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: secondaryBrandColor,
              foregroundColor: secondaryBrandColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.restaurant.name!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .apply(color: Colors.white),
                ),
                background: Image.network(
                  imageUrl + item.restaurantInfo.value.pictureId!,
                  fit: BoxFit.cover,
                ),
              ),
            ))
    ];
  }
  
   }

