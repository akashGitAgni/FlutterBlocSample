import 'dart:async';

import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/DataLayer/zomato_client.dart';

import 'bloc.dart';

class RestaurantBloc implements Bloc {
  final Location location;

  RestaurantBloc(this.location);

  final client = ZomatoClient();

  final controller = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => controller.stream;

  void submitQuery(String query) async {
    final results = await client.fetchRestaurants(location, query);
    controller.sink.add(results);
  }


  @override
  void dispose() {
    controller.close();
  }
}