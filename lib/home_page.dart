
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/data/model/detail_restaurant.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/resto_detail.dart';
import 'package:resto_app/widgets/card_resto.dart';
import 'package:resto_app/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends State<HomePage> {
  // String imgAppbar =
  //     'https://images.unsplash.com/photo-1505935428862-770b6f24f629?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=867&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // flexibleSpace: Image.network(
        //   imgAppbar,
        //   fit: BoxFit.cover,
        // ),
        title: Column(
          children: const [
            Text('Restaurant', style: TextStyle(color: Colors.black)),
            Text(
              'recommendation restaurant for you !',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(apiService: ApiService()),
        child: const RestoListPage(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        tooltip: 'Search your favorite restaurant here',
        mini: true,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                  title: const Text(
                    'Looking for your favorite place ?',
                    style: TextStyle(fontSize: 14),
                  ),
                  content: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          label: Text('search . . .'),
                          suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

class RestoListPage extends StatelessWidget {
  const RestoListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant, restoDetail: ayam);
              });
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildList());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
