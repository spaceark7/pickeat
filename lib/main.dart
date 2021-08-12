import 'package:flutter/material.dart';
import 'package:pickeat_app/common/style.dart';
import 'package:pickeat_app/ui/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PickEat',
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
     },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration (
         image: DecorationImage(image: 
         AssetImage('assets/images/s1.jpg',),
         fit: BoxFit.cover)
        ),

        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                child: Image.asset('assets/logo.png'
                ,height: 70,
                width: 70,),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Continue"))
            ],
          )
        ),

      ),
      
    );
  }
}
