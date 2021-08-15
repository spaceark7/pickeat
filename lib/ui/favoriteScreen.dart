import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pickeat_app/widgets/platformWidget.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: Center(
                child: Text(
                "Coming Soon!",
                style: Theme.of(context).textTheme.headline3,
              ),
    ));
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: Center(
      child: Text(
                "Coming Soon!",
                style: Theme.of(context).textTheme.headline3,
              ),
    ));
  }
}
