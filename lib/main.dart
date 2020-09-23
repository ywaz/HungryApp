import 'package:Hungry/helpers/nearByPlaces.dart';
import 'package:flutter/material.dart';
import 'package:Hungry/screens/lis_of_restaurants.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hungry',
      theme: ThemeData(
        brightness: Brightness.dark,
        
        primaryColor: Colors.green,
        accentColor: Colors.grey[350],
        fontFamily: 'KumbhSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (ctx)=>NearByPlaces(),
        child: RestaurantsList()),
    );
  }
}
