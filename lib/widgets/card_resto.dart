import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/resto_detail.dart';

class CardRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<CardRestaurant> createState() => _CardRestaurantState();
}

class _CardRestaurantState extends State<CardRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                opacity: .2,
                image: NetworkImage(
                    'https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}'))),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
              SizedBox(
                width: MediaQuery.of(context).size.width/3,
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 16, color: Colors.redAccent,),
                    Text(' '+widget.restaurant.city)
                  ],
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestoDetails.routeName,
                arguments: widget.restaurant.id);
          },
        ),
      ),
    );
  }
}
