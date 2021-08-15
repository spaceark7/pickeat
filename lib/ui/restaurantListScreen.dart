import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/ui/detailRestaurantScreen.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<String> fav = [];
  String query = "";
  List<Restaurant> topRated = [];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: _buildFutureBuilder,
    );
  }

  Widget _buildFutureBuilder(context, snapshot) {
    if (snapshot.hasData) {
      final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
      final List<Restaurant> search = restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final List<Restaurant> rank =
          restaurants.where((resturant) => resturant.rating >= 4.3).toList();
      topRated = rank;

      if (query.isEmpty) {
        return _listViewBuilderNonQuery(context, restaurants);
      } else if (search.isEmpty) {
        return Center(
          child: Text(
            'Oops! We Can\'t Find It',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(fontSizeDelta: 6.0, fontWeightDelta: 2),
          ),
        );
      } else {
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
  }

  MediaQuery _listViewBuilderNonQuery(context, List<Restaurant> restaurants) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
          itemCount: restaurants.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _carouselBuilder(context);
            } else if (index == 1) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, bottom: 8.0, right: 16.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discover The Best Place",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      width: 190,
                      child: const Divider(
                        height: 10,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return _buildRestaurantItems(context, restaurants[index - 2]);
            }
          }),
    );
  }

  Widget _carouselBuilder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8, top: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Place',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .apply(color: Colors.black),
              ),
              Container(
                width: 130,
                child: Divider(
                  height: 10,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
            items: _carouselItems(context),
            options: CarouselOptions(
                height: 350,
                aspectRatio: 2.0,
                autoPlay: true,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.easeInOutCubic)),
      ],
    );
  }

  List<Widget> _carouselItems(BuildContext context) =>
      topRated.map((e) => _listCarouselItems(context, e)).toList();

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
      iconColor: secondaryBrandColor,
      clearQueryOnClose: true,
      onQueryChanged: _handleChange,
      colorOnScroll: primaryBrandColor,
      height: 70,
      body: _buildList(context),
    );
  }

  Widget _buildIOS(BuildContext context) {  
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
         
          middle: Scaffold(
            backgroundColor: Colors.white,
            body: 
          FloatingSearchAppBar(
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
      iconColor: secondaryBrandColor,
      clearQueryOnClose: true,
      onQueryChanged: _handleChange,
      colorOnScroll: primaryBrandColor,
      height: 70,
      body: null,
      
    )
          
          ),
          transitionBetweenRoutes: false,
        ),
        child: _buildList(context));
  }

  Widget _buildRestaurantItems(BuildContext context, Restaurant restaurant) {
    return Material(
        color: primaryBrandColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName,
                    arguments: restaurant);
              },
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
                                  .bodyText1!
                                  .apply(
                                      color: Colors.black,
                                      fontSizeDelta: 3,
                                      fontWeightDelta: 5),
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
                                },
                                icon: _favIconOption(restaurant),
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

  Icon _favIconOption(Restaurant restaurant) {
    return fav.contains(restaurant.name)
        ? Icon(Platform.isIOS ? CupertinoIcons.heart : Icons.favorite)
        : Icon(Platform.isIOS ? CupertinoIcons.heart_circle : Icons.favorite_outline);
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

  Widget _listCarouselItems(BuildContext context, Restaurant item) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        splashColor: secondaryBrandColor.withAlpha(80),
        focusColor: accentBrandColor,
        onTap: () {
          Navigator.pushNamed(context, DetailScreen.routeName, arguments: item);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 8),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Ink.image(
                image: NetworkImage(item.pictureId),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                child: SizedBox(
                  height: 70,
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyText1!.apply(
                        color: primaryBrandColor,
                        fontSizeDelta: 10,
                        fontWeightDelta: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 50,
                  child: Text(
                    item.description,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText2!.apply(
                          color: primaryBrandColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
