import 'package:Hungry/helpers/nearByPlaces.dart';
import 'package:Hungry/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:Hungry/widgets/restaurantCard.dart';
import 'package:provider/provider.dart';
import 'package:Hungry/widgets/mapFloatingButton.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RestaurantsList extends StatefulWidget {
  @override
  _RestaurantsListState createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<NearByPlaces>(context).getCloseRestaurants().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((onError) {
        setState(() {
          _isLoading = false;
        });
      });

      _isInit = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    ItemScrollController scrollController = ItemScrollController();
    List<Restaurant> restaurantsList =
        Provider.of<NearByPlaces>(context, listen: false).restaurants;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ScrollablePositionedList.builder(
              itemCount: restaurantsList.length,
              itemScrollController: scrollController,

              itemBuilder: (ctx, index) {
                return RestaurantWidget(restaurantsList[index]);
              }),
      floatingActionButton: MapFloatingButton(scrollController)
    );
  }
}

///code using futurebuilder
// ),
// FutureBuilder(
//   future: NearByPlaces.getCloseRestaurants(),
//   builder: (ctx, AsyncSnapshot<List<Restaurant>> locationSnapshot) {
//     if (locationSnapshot.connectionState==ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       // positionSnapshot.data.latitude, positionSnapshot.data.longitude

//       return ListView.builder(
//         itemCount: locationSnapshot.data.length,
//         itemBuilder: (ctx, index){
//           return RestaurantWidget(locationSnapshot.data[index]);
//         });

//     }
// },
