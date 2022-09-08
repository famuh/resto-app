import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/widgets/card_resto.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool? isSearch;
  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    isSearch = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Text('Search',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 36))),

              // SEARCH FIELD
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                        controller: searchEditingController,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 15, top: 3),
                            border: InputBorder.none,
                            hintText: 'search . . .',
                            
                            suffixIcon: isSearch != true
                                ? const Icon(Icons.search)
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        searchEditingController.value =
                                            TextEditingValue.empty;
                                      });
                                    },
                                    icon: const Icon(Icons.close_rounded))),
                        onChanged: (val) {
                          if (searchEditingController.text.isNotEmpty) {
                            setState(() {
                              isSearch = true;
                            });
                          } else {
                            setState(() {
                              isSearch = false;
                            });
                          }
                        })),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('batal'))
              ]),

              // item from consumer
              Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.result.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result.restaurants[index];
                            if (searchEditingController.text.isEmpty) {
                              return CardRestaurant(restaurant: restaurant);
                            }
                            else if (restaurant.name.startsWith(searchEditingController.text) || restaurant.name[0].toLowerCase() == searchEditingController.text[0]) {
                              return CardRestaurant(restaurant: restaurant);
                            }else{
                              return Container();
                            }
                          }),
                    );
                  } else if (state.state == ResultState.noData) {
                    return Center(child: Material(child: Text(state.message)));
                  } else if (state.state == ResultState.error) {
                    return Center(child: Material(child: Text(state.message)));
                  } else {
                    return const Center(child: Material(child: Text('')));
                  }
                },
              ),

              
            ])));
  }

  }

