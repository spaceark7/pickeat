import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
               
                return _buildRestaurantItems(context, restaurants[index]);
              });
        } else {
          return Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick\'eat',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .apply(color: Colors.black)),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Pick\'Eat'),
          transitionBetweenRoutes: false,
        ),
        child: _buildList(context));
  }

  Widget _buildRestaurantItems(BuildContext context, Restaurant restaurant) {
    return Material(
        color: primaryBrandColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Ink.image(
                      height: 200,
                      image: NetworkImage(restaurant.pictureId),
                      fit: BoxFit.cover,
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 10.0, bottom: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurant.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .apply(color: Colors.black),
                            ),
                            Text(restaurant.city),
                            RatingBar(
                              rating: restaurant.rating,
                              icon: Icon(
                                Platform.isIOS
                                    ? CupertinoIcons.star
                                    : Icons.star,
                                size: 16,
                                color: Colors.grey,
                              ),
                              starCount: 5,
                              spacing: 0.0,
                              size: 16,
                              isIndicator: false,
                              allowHalfRating: true,
                              color: secondaryBrandColor,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                 
                                },
                                icon:  Icon(Platform.isIOS
                                        ? CupertinoIcons.heart
                                        : Icons.favorite_outline),
                                iconSize: 36.0,
                                color: secondaryBrandColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
