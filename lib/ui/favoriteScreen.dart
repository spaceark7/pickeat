import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Coming Soon!",
          style: Theme.of(context).textTheme.headline3,),
      ),
    );
  }
}
