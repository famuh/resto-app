import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'provider/restaurant_provider.dart';

class RestoDetails extends StatelessWidget {
  static const routeName = '/resto_details';

  String id;

  RestoDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), idResto: id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              print('resto_detail : is loading');
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant;
              print('resto_detail : has data from ' + restaurant.id);
              return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        expandedHeight: 350,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 32,),
                            Text(
                              restaurant.rating.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.withOpacity(.5),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.food_bank_rounded, size: 50),
                            title: Text(restaurant.name,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(restaurant.city),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            restaurant.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
const Divider(color: Colors.transparent),
                        // foods
                        const Text('Foods',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) => Center(
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(153, 196, 196, 196),
                                      // border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child:
                                      Text(restaurant.menus.foods[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                      
                                      )),
                            ),
                          ),
                        ),
                        const Divider(color: Colors.transparent),

                        //drinks
                        const Text('Drinks',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) => Center(
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(153, 196, 196, 196),
                                      // border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child:
                                      Text(restaurant.menus.drinks[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                      
                                      )),
                            ),
                          ),
                        ),

                        const Divider(color: Colors.transparent),

                        // Review
                        const Text('Customer Review'),
                        Container(
                          constraints: const BoxConstraints(
                              minHeight: 50, maxHeight: 80),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.customerReviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 300,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(restaurant
                                              .customerReviews[index].name),
                                          Text(restaurant
                                              .customerReviews[index].date)
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          "\"${restaurant.customerReviews[index].review}\"")
                                    ],
                                  ),
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
        ),
      ),
    );
  }
}
