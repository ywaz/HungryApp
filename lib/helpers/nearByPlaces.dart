import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:Hungry/models/restaurant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


const String GOOGLE_API_KEY = 'AIzaSyB_3s_vTIoOxDWaYwv5V-h9-WXraMhkTdE';

class NearByPlaces with ChangeNotifier{

  String restaurantIcon="https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png";
  List<Restaurant> _restaurantsList=[];
  Position location;
  List<Restaurant> get restaurants {
    return [..._restaurantsList];
  } 

  int getRestaurantId(String restaurantId){
    if(_restaurantsList.isNotEmpty){

      return _restaurantsList.indexWhere((element) => element.placeId==restaurantId);
    }
    return null;

  }

  Future<Position> getCloseRestaurants() async {
    location =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String url ='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&rankby=distance&type=restaurant&key=$GOOGLE_API_KEY';
    // String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=43.6991667,7.2537592&rankby=distance&type=restaurant&key=$GOOGLE_API_KEY';

    // Coordinates nice  34.034053,-5.0149347

    List<dynamic> agregatedList = [];
    http.Response urlRsp;
    int counter;
    Map<dynamic, dynamic> decodedMap;
    
      do {
        counter = 0;
        do {
          sleep(Duration(milliseconds: 100));
          urlRsp = await http.get(url);
          decodedMap = jsonDecode(urlRsp.body);
          counter++;
        } while (decodedMap['status'] != 'OK' && counter < 10);

        agregatedList = [...agregatedList, ...decodedMap['results']];

        url =
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=${decodedMap['next_page_token']}&key=$GOOGLE_API_KEY';
      } while (decodedMap.containsKey('next_page_token') &&
          decodedMap['next_page_token'] != '' &&
          agregatedList.length < 40);
    
    // List<Restaurant> restaurantsList = [];

    agregatedList.forEach((element) {
      _restaurantsList.add(Restaurant(
        name: element['name'],
        coordinates: LatLng(element['geometry']['location']['lat'],
            element['geometry']['location']['lng']),
        imageUrl: element.containsKey('photos')
            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${element['photos'][0]['photo_reference']}&key=$GOOGLE_API_KEY'
            : null,
        openNow: element.containsKey('opening_hours')
            ? element['opening_hours']['open_now']
            : null,
        placeId: element['place_id'],
        rating:
            element.containsKey('rating') ? element['rating'].toDouble() : null,
        userRatings: element.containsKey('user_ratings_total')
            ? element['user_ratings_total']
            : null,
      ));
    });

    
    notifyListeners();
    return location;
  }

  String getStaticMap() {

    String mapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=${location.latitude},${location.longitude}&zoom=13&size=400x400';
    _restaurantsList.forEach((restaurant) { 
      mapUrl=  mapUrl+'&markers=color:red%7Clabel:R%7C${restaurant.coordinates.latitude},${restaurant.coordinates.longitude}';
    });
    mapUrl = mapUrl+'&key=$GOOGLE_API_KEY';
    print(mapUrl);
    return mapUrl;
  }


}
