import 'package:flutter/material.dart';
import 'package:resto_app/data/restaurant.dart';
import 'package:resto_app/resto_detail.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image.network(
            'https://images.unsplash.com/photo-1505935428862-770b6f24f629?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=867&q=80',
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
        body: const RestoListPage());
  }
}

class RestoListPage extends StatelessWidget {
  const RestoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('resto_data.json'),
      builder: (context, AsyncSnapshot snapshot) {
        final List<Restaurant> restaurant =
            restoDataFromJson(snapshot.requireData).restaurants;
        return ListView.builder(
          itemCount: restaurant.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildRestoItem(context, restaurant[index]);
          },
        );
      },
    );
  }
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return Card(
    elevation: 1,
    child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        resto.pictureId,
        width: 100,
      ),
      title: Row(children: [
        const Icon(
          Icons.food_bank_rounded,
          size: 20,
        ),
        Text(
          resto.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ]),
      subtitle: Row(children: [
        const Icon(Icons.location_on, size: 20),
        Text(resto.city)
      ]),
      onTap: () {
        Navigator.pushNamed(context, RestoDetails.routeName, arguments: resto);
      },
    ),
  );
}
