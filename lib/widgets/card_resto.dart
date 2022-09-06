import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/restaurant.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/resto_detail.dart';

import '../provider/restaurant_provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

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
              leading: Text(
                restaurant.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestoDetails(
                              id: restaurant.id,
                            )));
              },
            ),
          ),
        );
      // },
      // child: Material(
      //   child: Card(
      //     elevation: 2,
      //     child: Container(
      //       // margin: EdgeInsets.symmetric(vertical: 5),
      //       decoration: BoxDecoration(
      //           image: DecorationImage(
      //               fit: BoxFit.cover,
      //               opacity: .2,
      //               image: NetworkImage(
      //                   'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'))),
      //       child: ListTile(
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      //         leading: Text(
      //           restaurant.name,
      //           style:
      //               const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      //         ),
      //         onTap: () {
      //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>RestoDetails(
      //           //   restaurant: restaurant, id: provID.getId('1')))
      //           //   );

      //           Navigator.pushNamed(context, RestoDetails.routeName,
      //               arguments: [restaurant, restaurant.id]);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    }
  }

