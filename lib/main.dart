import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/home_page.dart';
import 'package:resto_app/provider/restaurant_search_provider.dart';
import 'package:resto_app/resto_detail.dart';
import 'package:resto_app/search_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestoDetails.routeName: (context) => RestoDetails(
                id: ModalRoute.of(context)?.settings.arguments as String),
          SearchPage.routeName: (context) => const SearchPage()
        },
      ),
    );
  }
}
