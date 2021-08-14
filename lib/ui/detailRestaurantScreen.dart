import 'dart:convert';
import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/data/model/restaurant.dart';

class DetailScreen extends StatelessWidget {
  static final routeName = '/detail_screen';
  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final String desc = restaurant.description;
    final foods = _listFood();
    final drinks = _listDrink();

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
                      Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.apply(
                            color: secondaryBrandColor,
                            fontSizeDelta: 32.0,
                            fontWeightDelta: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Overall Score',
                                style: Theme.of(context).textTheme.bodyText1),
                            RatingBar(
                              rating: restaurant.rating,
                              icon: Icon(
                                Platform.isIOS
                                    ? CupertinoIcons.star
                                    : Icons.star,
                                size: 24,
                                color: Colors.grey,
                              ),
                              starCount: 5,
                              spacing: 0.0,
                              size: 24,
                              isIndicator: false,
                              allowHalfRating: true,
                              color: secondaryBrandColor,
                            ),
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
                      restaurant.city,
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
                  restaurant.description,
                  expandText: 'Read More',
                  collapseText: 'Show Less',
                  animation: true,
                  maxLines: 3,
                  collapseOnTextTap: true,
                  linkColor: accentBrandColor,
                  animationDuration: Duration(milliseconds: 500),
                  animationCurve: Curves.bounceInOut,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Menus",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Text(
                      'Food Selection',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(fontSizeDelta: 5),
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
                        children: _listFoodGrid(foods),
                      ),
                    ),
                  ],
                ),
                MenuGridHorizontal(context, drinks)
              
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget MenuGridHorizontal(BuildContext context, List<String> items ) {
    return Column(
      children: [
        Text(
          'Food Selection',
          style: Theme.of(context).textTheme.caption!.apply(fontSizeDelta: 5),
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

  List<String> _listFood() {
    List ss = restaurant.menus['foods'];
    List<String> w = ss.map((e) => e['name'] as String).toList();
    return w;
  }

  List<String> _listDrink() {
    List ss = restaurant.menus['drinks'];
    List<String> w = ss.map((e) => e['name'] as String).toList();

    return w;
  }

  List<Widget> _sliverBuilder(context, isScrolled) {
    return [
      SliverAppBar(
        expandedHeight: 300,
        pinned: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: secondaryBrandColor,
        foregroundColor: secondaryBrandColor,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            restaurant.name,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .apply(color: Colors.white),
          ),
          background: Image.network(
            restaurant.pictureId,
            fit: BoxFit.cover,
          ),
        ),
      )
    ];
  }
}
