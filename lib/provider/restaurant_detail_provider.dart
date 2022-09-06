
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/detail_restaurant.dart';
import 'restaurant_provider.dart';



class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  

  RestaurantDetailProvider({required this.apiService}){
    fetchDetail(id);
  }

  late RestaurantDetail _restoResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get result => _restoResult;
  ResultState get state => _state;

  final String _id = 'rqdv5juczeskfw1e867';
  String get id => _id;
  
  Future<dynamic> fetchDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.restoDetail(id);
      if (result.id.isEmpty) {
        print('is Empty :D');
        _state = ResultState.noData;
        return _message = 'Empty Data';
      } else if(result.id.isNotEmpty){
        _state = ResultState.hasData;
        notifyListeners();
        print(result.id);
        return _restoResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      print(e);
      return _message = 'Error Restaurant Detail--> $e';
    }
  }
}

