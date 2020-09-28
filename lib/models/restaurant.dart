

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant{
  String placeId;
  String name;
  LatLng coordinates;
  String imageUrl;
  double rating;
  int userRatings;
  bool openNow;

  Restaurant({this.placeId, this.coordinates, this.imageUrl, this.name, this.openNow, this.rating, this.userRatings, });
  
}