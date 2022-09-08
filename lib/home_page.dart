
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/api_service_restaurant.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/search_page.dart';
import 'package:resto_app/widgets/card_resto.dart';
import 'package:resto_app/widgets/platform_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/appbarBg.jpg',
          fit: BoxFit.cover,
        ),
        title: Column(
          children: const [
            Text('Restaurant', style: TextStyle(color: Colors.black)),
            Text(
              'recommendation restaurant for you !',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: const RestoListPage(),
        ),
      ),
      floatingActionButton: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService()),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          var restaurant = state.result.restaurants;
          return FloatingActionButton(
            backgroundColor: Colors.black,
            tooltip: 'Search your favorite restaurant here',
            mini: true,
            onPressed: () {
            Navigator.pushNamed(context, SearchPage.routeName,
            arguments:  restaurant);
            },
            child: const Icon(Icons.search),
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
          })),
    );
  }}

class RestoListPage extends StatefulWidget {
  const RestoListPage({Key? key}) : super(key: key);

  @override
  State<RestoListPage> createState() => _RestoListPageState();
}

class _RestoListPageState extends State<RestoListPage> {
  String? loadMessage;

  @override
  void initState() {
    // TODO: implement initState
    loadMessage = 'Wait a second . . .';
    super.initState();
  }
  Widget _buildList() {
    return 
    Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          Future.delayed(const Duration(seconds: 8), (){
            setState(() {
              loadMessage = 'It\'s getting longer . . .';
            });
          });
          return Center(child: Text(loadMessage!));
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              });
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ));
        } else if (state.state == ResultState.error) {
          return Container();
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ));
        }});
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _buildList());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
