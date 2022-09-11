import 'package:flutter/material.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/data/model/search_restaurant.dart';
import 'package:resto_app/resto_detail.dart';

// UNTUK HOMEPAGE
class CardRestaurant extends StatelessWidget {
  final Restaurant? restaurant;
  const CardRestaurant({Key? key, this.restaurant}) : super(key: key);

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
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant?.pictureId}'))),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant!.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                    Text(' ' + restaurant!.city)
                  ],
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestoDetails.routeName,
                arguments: restaurant!.id);
          },
        ),
      ),
    );
  }
}

// UNTUK SEARCHPAGE

class CardRestaurantSearchPage extends StatelessWidget {
  final RestaurantSearch restaurant;
  const CardRestaurantSearchPage({Key? key, required this.restaurant})
      : super(key: key);

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
                    'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'))),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                    Text(' ' + restaurant.city)
                  ],
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestoDetails.routeName,
                arguments: restaurant.id);
          },
        ),
      ),
    );
  }
}
