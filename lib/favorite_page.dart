
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/database_provider.dart';
import 'package:resto_app/widgets/card_resto.dart';

import 'utils/result_state.dart';
import 'widgets/platform_widget.dart';

class FavoriteScreen extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoritesTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text(favoritesTitle),
        ),
        child: _buildList());
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favorites.length,
          itemBuilder: (context, index) {
          return CardRestaurant(restaurant: provider.favorites[index]);
        });
      } else {
        return Center(
          child: Text(provider.message),
        );
      }
    });
  }
}
