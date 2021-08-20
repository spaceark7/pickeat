

import 'package:flutter/material.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/providers/favorite_module_provider.dart';
import 'package:pickeat_app/ui/detailRestaurantScreen.dart';
import 'package:pickeat_app/ui/favoriteScreen.dart';
import 'package:pickeat_app/ui/homeScreen.dart';
import 'package:pickeat_app/ui/profileScreen.dart';
import 'package:provider/provider.dart';
import 'data/model/restaurant.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => FavoriteModuleProvider())
    ],
    child:  MyApp() ,)
    
    
   );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PickEat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: primaryBrandColor,
       accentColor: secondaryBrandColor,
       dividerColor: accentBrandColor,
       scaffoldBackgroundColor: backgoundColor,
       visualDensity: VisualDensity.adaptivePlatformDensity,
       textTheme: brandTextTheme,
       appBarTheme: AppBarTheme(
         textTheme: brandTextTheme.apply(bodyColor: Colors.black),
         elevation: 0
       ),
       bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: secondaryBrandColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
     initialRoute: HomeScreen.routeName,
     routes: {
       HomeScreen.routeName: (context) => HomeScreen(),
       DetailScreen.routeName: (context) => DetailScreen(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
       FavoriteScreen.routeName: (context) => FavoriteScreen(),
       ProfileScreen.routeName: (context) => ProfileScreen(),
     },
    );
  }
}

