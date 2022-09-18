import 'package:flutter_test/flutter_test.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

void main() {
  test('Mengembalikan tipe RestoData', () async {
   
    final restaurantProvider = RestaurantProvider(apiService: ApiService());

    final data = await restaurantProvider.apiService.restoHeadline();
    RestoData result = data;
    var isSuccesfullyParse = result.restaurants.isNotEmpty;
    
    expect(isSuccesfullyParse, true);
    
  });
}
