
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:provider/provider.dart';
import 'package:Hungry/helpers/nearByPlaces.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomSheetMap extends StatelessWidget {

  ItemScrollController scrollController;
  BottomSheetMap(this.scrollController);

   @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.map),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          showBottomSheet(
            elevation: 5,
            context: context,
            builder: (ctx) {
              NearByPlaces provider = Provider.of<NearByPlaces>(ctx, listen:false);
              Set<Marker> _markers = Set<Marker>();
              provider.restaurants.forEach((restaurant) {
                _markers.add(Marker(
                  markerId: MarkerId(restaurant.placeId),
                  position: LatLng(restaurant.coordinates.latitude, restaurant.coordinates.longitude),
                  onTap: (){
                    scrollController.jumpTo(index: provider.getRestaurantId(restaurant.placeId));},
                  ));
               });
              return Container(
                width: double.infinity,
                height: 300,
                child: GoogleMap(
                  minMaxZoomPreference: MinMaxZoomPreference(13, 16),
                  initialCameraPosition: CameraPosition(target: LatLng(provider.location.latitude, provider.location.longitude)),
                  markers: _markers,
                  myLocationEnabled: true,
                  ),
              );

        }
          );},
    );
  }
}
