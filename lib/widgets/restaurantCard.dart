import 'package:Hungry/helpers/nearByPlaces.dart';
import 'package:Hungry/models/restaurant.dart';
import 'package:flutter/material.dart';

import 'package:Hungry/screens/restaurantScreen.dart';
import 'package:provider/provider.dart';

class RestaurantWidget extends StatefulWidget {
  Restaurant restaurant;
  RestaurantWidget(
    this.restaurant,
  );

  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => RestaurantScreen(restaurant: widget.restaurant),
      )),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 7,
        margin: EdgeInsets.only(bottom: 6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(15))),
        child: Stack(
          children: [
            widget.restaurant.imageUrl != null
                ? Hero(
                    tag: widget.restaurant.placeId,
                    child: Image.network(
                      widget.restaurant.imageUrl,
                      fit: BoxFit.cover,
                      height: screenSize.height / 5,
                      width: double.infinity,
                    ),
                  )
                : Hero(
                    tag: widget.restaurant.placeId,
                    child: Image.asset(
                      'assets/images/noImage.jpeg',
                      fit: BoxFit.cover,
                      height: screenSize.height / 5,
                      width: double.infinity,
                    ),
                  ),
            Positioned(
                bottom: 15,
                left: 10,
                child: Text(
                  widget.restaurant.name,
                  style: TextStyle(fontSize: 26),
                )),
            if (widget.restaurant.rating != null)
              Positioned(
                  bottom: 15,
                  right: 10,
                  child: CircleAvatar(
                    child: Text(widget.restaurant.rating.toString()),
                  ))
          ],
        ),
      ),
    );
  }
}
