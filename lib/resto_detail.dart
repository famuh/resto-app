import 'package:flutter/material.dart';
import 'package:resto_app/data/model/detail_restaurant.dart';
import 'package:resto_app/data/model/restaurant.dart';

class RestoDetails extends StatelessWidget {
  static const routeName = '/resto_details';
  final Restaurant restaurant;
  String? id;

  RestoDetails({Key? key, required this.restaurant, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                fit: BoxFit.fill),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber),
                  Text(
                    restaurant.rating.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ListTile(
                leading: const Icon(Icons.food_bank_rounded, size: 50),
                title: Text(restaurant.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(restaurant.city),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              Text(restaurant.id),
              // foods
              const Text('Foods', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurant.menus.foods.length,
                  itemBuilder: (context, index) => Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          restaurant.city
                          // restaurant.menus!.foods[index].name
                          )),
                  ),
                ),
              ),

              //drinks
              const Text('Drinks', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurant.menus.drinks.length,
                  itemBuilder: (context, index) => Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text('a'
                          // restaurant.menus.drinks[index].name
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
