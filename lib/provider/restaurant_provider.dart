import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {

  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }
  late String _aidi;
  String get aidi => _aidi;

  late RestoData _restoResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestoData get result => _restoResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restoHeadline();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      print(e);
      return _message = 'Error Restaurant Provider --> $e';
    }
  }
}

