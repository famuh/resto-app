import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/detail_restaurant.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/home_page.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/resto_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(apiService: ApiService()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        // initialRoute: HomePage.routeName,
        
        // routes: {
        //   HomePage.routeName : (context) => const HomePage(),
        //   RestoDetails.routeName : (context) => ChangeNotifierProvider(
        //     create: (_) => RestaurantDetailProvider(apiService: ApiService()),
        //     child: RestoDetails(
        //       restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantDetail,
        //     ),
        //   )
        // },
      ),
    );
  }
  
}
