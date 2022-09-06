import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/detail_restaurant.dart';
import 'package:resto_app/data/model/restaurant.dart';


    
class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  
  Future<RestoData> restoHeadline() async{
    final response = await http.get(Uri.parse('$_baseUrl$_list'));
    
    if (response.statusCode == 200) {
      print('Response List : OK');
      return RestoData.fromJson(json.decode(response.body));
    }else{
      throw 'Error to load';
    }
  }
  
  Future<RestaurantDetail> restoDetail(id) async{
    final response = await http.get(Uri.parse(_baseUrl+'detail/$id'));
    if (response.statusCode == 200) {
      print('Response Detail : OK');
      return RestaurantDetail.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load detail');
    }
  }
}