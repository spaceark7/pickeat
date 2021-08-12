import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class RestaurantListScreen extends StatelessWidget {
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
          return Container(
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
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger(
                child: SnackBar(
              content: Text('hit'),
            ));
          },
          child: Container(
            child: Column(
              children: [
                Image.network(
                  restaurant.pictureId,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      Text(restaurant.name),
                      Text(restaurant.description)
                    ],
                  ),
                )
              ],
            ),
          ),
        )

        // ListTile(
        //   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        //   leading: Image.network(
        //     restaurant.pictureId,
        //     width: 80,
        //   ),
        //   title: Text(restaurant.name, style: Theme.of(context).textTheme.headline5,),
        //   subtitle: Text(restaurant.description),
        //   onTap: () {},
        // ),
        );
  }
}
