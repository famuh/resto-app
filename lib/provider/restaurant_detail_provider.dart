import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/detail_restaurant.dart';

enum ResultStateDetail { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService}){
    fetchDetail(id);
  }

  late RestaurantDetail _restoResult;
  late ResultStateDetail _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get result => _restoResult;
  ResultStateDetail get state => _state;

  final String _id = 'rqdv5juczeskfw1e867';
  String get id => _id;
  
  Future<dynamic> fetchDetail(String id) async {
    try {
      _state = ResultStateDetail.loading;
      notifyListeners();
      final result = await apiService.restoDetail(id);
      if (result.restaurant.id.isEmpty ) {
        _state = ResultStateDetail.noData;
        return _message = 'Empty Data';
      } else {
        _state = ResultStateDetail.hasData;
        notifyListeners();
        print(result.restaurant);
        return _restoResult = result.restaurant;
      }
    } catch (e) {
      _state = ResultStateDetail.error;
      notifyListeners();
      print(e);
      return _message = 'Error --> $e';
    }
  }
}

