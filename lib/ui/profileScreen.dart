import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static final routeName = '/profile_page';

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
