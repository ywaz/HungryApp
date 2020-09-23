import 'package:Hungry/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantWidget extends StatelessWidget {
  Restaurant restaurant;
  RestaurantWidget(this.restaurant);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 7,
      margin: EdgeInsets.only(bottom: 6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Stack(
        children: [
          restaurant.imageUrl != null
              ? Image.network(
                  restaurant.imageUrl,
                  fit: BoxFit.cover,
                  height: screenSize.height / 5,
                  width: double.infinity,
                )
              : Image.asset(
                  'assets/images/noImage.jpeg',
                  fit: BoxFit.cover,
                  height: screenSize.height / 5,
                  width: double.infinity,
                ),
          Positioned(
              bottom: 15,
              left: 10,
              child: Text(
                restaurant.name,
                style: TextStyle(fontSize: 26),
              )),
          if (restaurant.rating != null)
            Positioned(
                bottom: 15,
                right: 10,
                child: CircleAvatar(
                  child: Text(restaurant.rating.toString()),
                ))
        ],
      ),
    );
  }
}
