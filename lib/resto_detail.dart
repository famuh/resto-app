import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/widgets/customer_review.dart';
import 'provider/restaurant_provider.dart';

class RestoDetails extends StatelessWidget {
  static const routeName = '/resto_details';

  String id;

  RestoDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            print('resto_detail : is loading');
            return const CircularProgressIndicator();
          } else if (state.state == ResultState.hasData) {
            var restaurant = state.result;
            print('resto_detail : has data');
            return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      expandedHeight: 300,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                            'https://restaurant-api.dicoding.dev/images/small/${restaurant.restaurant.pictureId}',
                            fit: BoxFit.fill),
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber),
                          Text(
                            restaurant.restaurant.rating.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      ListTile(
                        leading: const Icon(Icons.food_bank_rounded, size: 50),
                        title: Text(restaurant.restaurant.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(restaurant.restaurant.city),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          restaurant.restaurant.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),

                      // foods
                      const Text('Foods',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.restaurant.menus.foods.length,
                          itemBuilder: (context, index) => Center(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(restaurant
                                    .restaurant.menus.foods[index].name)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //drinks
                      const Text('Drinks',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.restaurant.menus.drinks.length,
                          itemBuilder: (context, index) => Center(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(restaurant
                                    .restaurant.menus.drinks[index].name)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Review
                      const Text('Customer Review'),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: restaurant.restaurant.customerReviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(restaurant.restaurant
                                            .customerReviews[index].name),
                                        Text(restaurant.restaurant
                                            .customerReviews[index].date)
                                      ],
                                    ),
                                    Text(
                                        "\"${restaurant.restaurant.customerReviews[index].review}\"")
                                  ],
                                ),
                              
                            );
                          },
                        ),
                      ),

                      // const CustomerReview()
                    ],
                  ),
                )));
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Text('dahlah');
          }
        },

        // child: Padding(
        //   padding: const EdgeInsets.symmetric(
        //       vertical: 8.0, horizontal: 16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       // Row(
        //       //   mainAxisAlignment: MainAxisAlignment.start,
        //       //   children: [
        //       //     const Icon(Icons.star_rounded, color: Colors.amber),
        //       //     Text(
        //       //       restaurant.rating.toString(),
        //       //       style: const TextStyle(fontWeight: FontWeight.bold),
        //       //     )
        //       //   ],
        //       // ),
        //       // ListTile(
        //       //   leading: const Icon(Icons.food_bank_rounded, size: 50),
        //       //   title: Text(restaurant.name,
        //       //       style:
        //       //           const TextStyle(fontWeight: FontWeight.bold)),
        //       //   subtitle: Text(restaurant.city),
        //       // ),

        //       // Container(
        //       //   padding: const EdgeInsets.all(10),
        //       //   child: Text(
        //       //     restaurant.description,
        //       //     textAlign: TextAlign.justify,
        //       //     style: const TextStyle(color: Colors.black54),
        //       //   ),
        //       // ),

        //       // // foods
        //       // const Text('Foods',
        //       //     style: TextStyle(fontWeight: FontWeight.w500)),
        //       // SizedBox(
        //       //   width: MediaQuery.of(context).size.width,
        //       //   height: 70,
        //       //   child: ListView.builder(
        //       //     shrinkWrap: true,
        //       //     scrollDirection: Axis.horizontal,
        //       //     // itemCount: restaurant.menus.foods.length,
        //       //     itemBuilder: (context, index) => Center(
        //       //       child: Container(
        //       //           margin: const EdgeInsets.symmetric(
        //       //               horizontal: 8, vertical: 4),
        //       //           decoration: BoxDecoration(
        //       //               border: Border.all(color: Colors.green),
        //       //               borderRadius: BorderRadius.circular(10)),
        //       //           padding: const EdgeInsets.symmetric(
        //       //               horizontal: 8, vertical: 4),
        //       //           child: Text(
        //       //               restaurant.menus!.foods[index].name
        //       //               )),
        //       //     ),
        //       //   ),
        //       // ),

        //       // //drinks
        //       // const Text('Drinks',
        //       //     style: TextStyle(fontWeight: FontWeight.w500)),
        //       // SizedBox(
        //       //   width: MediaQuery.of(context).size.width,
        //       //   height: 70,
        //       //   child: ListView.builder(
        //       //     shrinkWrap: true,
        //       //     scrollDirection: Axis.horizontal,
        //       //     // itemCount: restaurant.menus.drinks.length,
        //       //     itemBuilder: (context, index) => Center(
        //       //       child: Container(
        //       //           margin: const EdgeInsets.symmetric(
        //       //               horizontal: 8, vertical: 4),
        //       //           decoration: BoxDecoration(
        //       //               border: Border.all(color: Colors.green),
        //       //               borderRadius: BorderRadius.circular(10)),
        //       //           padding: const EdgeInsets.symmetric(
        //       //               horizontal: 8, vertical: 4),
        //       //           child: Text(
        //       //                restaurant.menus.drinks[index].name
        //       //               )),
        //       //     ),
        //       //   ),
        //       // )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
