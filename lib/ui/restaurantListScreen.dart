import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/get_core.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/controller/restaurant_controller.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/providers/favorite_module_provider.dart';
import 'package:pickeat_app/ui/detailRestaurantScreen.dart';
import 'package:pickeat_app/widgets/card_restaurant.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final RestaurantsController resto = Get.put(RestaurantsController());
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
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
      iconColor: secondaryBrandColor,
      clearQueryOnClose: true,
      onQueryChanged: _handleChange,
      colorOnScroll: primaryBrandColor,
      height: 70,
      body: ChangeNotifierProvider(
          create: (context) => FavoriteModuleProvider(),
          child: _buildList(context)),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Scaffold(
            backgroundColor: Colors.white,
            body: FloatingSearchAppBar(
              title: Text(
                'Pick\'eat',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .apply(color: Colors.black),
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
            )),
        transitionBetweenRoutes: false,
      ),
      child: ChangeNotifierProvider(
          create: (context) => FavoriteModuleProvider(),
          child: _buildList(context)),
    );
  }

  Widget _buildList(BuildContext context) {
    return Obx(() {
      final _list = resto.restaurantList;
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                _list.where((restaurant) => restaurant.rating! >= 4.3).toList();
                return _carouselBuilder(context);
              }
              return CardRestaurant(restaurant: _list[index - 1]);
            }),
      );
    });
  }

  Widget _carouselBuilder(BuildContext context) {
    print(resto.topRatedList);
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
            items: resto.topRatedList
                .map((e) => _listCarouselItems(context, e))
                .toList(),
            options: CarouselOptions(
                height: 350,
                aspectRatio: 2.0,
                autoPlay: true,
                viewportFraction: 0.8,
                autoPlayCurve: Curves.easeInOutCubic)),
      ],
    );
  }

  void _handleSubmit(String keyword) {
    setState(() {
      _query = keyword;
    });
  }

  void _handleChange(String keyword) {
    setState(() {
      _query = keyword;
    });
  }

  Widget _listCarouselItems(BuildContext context, Restaurant item) {
    final String imageUrl =
        "https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}";
    print(imageUrl);

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        splashColor: secondaryBrandColor.withAlpha(80),
        focusColor: accentBrandColor,
        onTap: () {
          resto.id.value = item.id!;
          Navigator.pushNamed(context, DetailScreen.routeName, arguments: item);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 8),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Ink.image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 10),
                child: SizedBox(
                  height: 70,
                  child: Text(
                    item.name!,
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
