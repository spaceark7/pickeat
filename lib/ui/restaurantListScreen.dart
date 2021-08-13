import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<String> fav = [];
  String query = "";

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
          final List<Restaurant> search = restaurants
              .where((restaurant) => restaurant.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          print("Hasil cari $query  ${search.map((e) => e.name)}");

          if (query.isEmpty) {
            return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItems(context, restaurants[index]);
                });
          }  else if(search.isEmpty) {
            return Center(
            child: Text('Oops! We Can\'t Find It',
            style: Theme.of(context).textTheme.bodyText1!.apply(
              fontSizeDelta: 6.0,
              fontWeightDelta: 2),),
          );
          }
          
          else {
            return ListView.builder(
                itemCount: search.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItems(context, search[index]);
                });
          }
          
        } else {
          return Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return FloatingSearchAppBar(
      title: Text(
        'Pick\'eat',
        style:
            Theme.of(context).textTheme.headline4!.apply(color: Colors.black),
      ),
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 900),
      accentColor: secondaryBrandColor,
      hintStyle: Theme.of(context).textTheme.bodyText1,
      hint: 'I\'m Looking For ...',
      onSubmitted: _handleSubmit,
      clearQueryOnClose: true,
      onQueryChanged: _handleChange,
      colorOnScroll: primaryBrandColor,
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
                                  setState(() {
                                    if (fav.contains(restaurant.name)) {
                                      fav.remove(restaurant.name);
                                      final snackBar = SnackBar(
                                        content: Text(
                                            '${restaurant.name} is deleted from Favorite!'),
                                        backgroundColor: accentBrandColor,
                                        duration: Duration(seconds: 1),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      fav.add(restaurant.name);
                                      final snackBar = SnackBar(
                                        content: Text('Added to Favorite!'),
                                        backgroundColor: secondaryBrandColor,
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  });

                                  print(fav.map((e) => e));
                                },
                                icon: fav.contains(restaurant.name)
                                    ? Icon(Platform.isIOS
                                        ? CupertinoIcons.heart
                                        : Icons.favorite)
                                    : Icon(Platform.isIOS
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

  void _handleSubmit(String keyword) {
    setState(() {
      query = keyword;
    });
  }

  void _handleChange(String keyword) {
    setState(() {
      query = keyword;
    });
  }
}
