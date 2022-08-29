import 'package:flutter/material.dart';
import 'package:resto_app/data/restaurant.dart';

class RestoDetails extends StatelessWidget {
  static const routeName = '/resto_details';
  final Restaurant restaurant;

  const RestoDetails({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(restaurant.pictureId, fit: BoxFit.fill),
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
                Text(restaurant.rating.toString())
              ],
            ),
            ListTile(
              title: Text(restaurant.name),
              subtitle: Text(restaurant.city),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.justify,
              ),
            ),

            // foods
            const Text('Foods'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.menus.foods.length,
                itemBuilder: (context, index) => Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(restaurant.menus.foods[index].name)),
                ),
              ),
            ),

            //drinks
            const Text('Drinks'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.menus.foods.length,
                itemBuilder: (context, index) => Center(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(restaurant.menus.drinks[index].name)),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }
}

// Widget _buildFoodItem(BuildContext context, Restaurant resto){
//   return Card(
//     child: Text(resto.menus.drinks)
//   );
// }
