import 'package:Hungry/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestaurantScreen extends StatefulWidget {
  Restaurant restaurant;
  RestaurantScreen({this.restaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          widget.restaurant.name,
          softWrap: true,
        ),
      ),
      body: Container(
        height: screenSize.height * 9 / 19,
        width: double.infinity,
        child: Hero(
          tag: widget.restaurant.placeId,
          child: widget.restaurant.imageUrl != null
              ? Stack(
                  children: [
                    PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.network(
                          widget.restaurant.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'assets/images/rest1.jpeg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset('assets/images/rest2.jpeg',
                            fit: BoxFit.cover),
                        Image.asset('assets/images/dish.jpeg',
                            fit: BoxFit.cover),
                      ],
                    ),
                    Positioned(
                      bottom: 15,
                      right: screenSize.width/2-27,
                      child: SmoothPageIndicator(
                          effect: SlideEffect(
                              spacing: 5.0,
                              radius: 6.0,
                              dotWidth: 10.0,
                              dotHeight: 10.0,
                              paintStyle: PaintingStyle.stroke,
                              strokeWidth: 1.5,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.white60),
                          controller: pageController,
                          count: 4),
                    ),
                  ],
                )
              : Image.asset('assets/images/noImage.jpeg'),
        ),
      ),
    );
  }
}
