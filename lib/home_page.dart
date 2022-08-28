import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resto_app/data/restaurant.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: RestoListPage());
  }
}

class RestoListPage extends StatelessWidget {
  const RestoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString('resto_data.json'),
      builder: (context,AsyncSnapshot snapshot) {
        // print(snapshot.data);
        // if (snapshot.hasData) {
          final List<Restaurant> restaurant = restoDataFromJson(snapshot.requireData).restaurants;
          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildRestoItem(context, restaurant[index]);
            },
          );
          
        // }

      },
    ));
  }

 
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(
      resto.pictureId,
      width: 100,
    ),
    title: Text(resto.name),
    subtitle: Text(resto.city),
  );
}
