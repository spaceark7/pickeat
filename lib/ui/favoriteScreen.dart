import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/providers/favorite_module_provider.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Widget _buildAndroid(BuildContext context) {
    final _favList = context.read<FavoriteModuleProvider>().favList;
    print("from fav screen : $_favList");
    print("from fav screen : ${FavoriteModuleProvider.tf}");


    return Scaffold(
        body: FavoriteModuleProvider.tf.isEmpty
            ? Center(
                child: Text("No data"),
              )
            : ListView.builder(
                itemCount:
                    context.watch<FavoriteModuleProvider>().favList.length,
                itemBuilder: (context, index) {
                  return _buildList(context, _favList[index]);
                }));
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

  Widget _buildList(BuildContext context, Restaurant favList) {
    return Text(favList.name);
  }
}
