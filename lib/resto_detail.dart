import 'package:flutter/material.dart';
import 'package:resto_app/data/restaurant.dart';

class RestoDetails extends StatelessWidget {
  static const routeName = '/resto_details';
  final Restaurant restaurant;

  const RestoDetails({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(restaurant.name),
    );
  }
}