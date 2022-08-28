// To parse this JSON data, do
//
//     final restoData = restoDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RestoData restoDataFromJson(String str) => RestoData.fromJson(json.decode(str));

String restoDataToJson(RestoData data) => json.encode(data.toJson());

class RestoData {
    RestoData({
        required this.restaurants,
    });

    final List<Restaurant> restaurants;

    factory RestoData.fromJson(Map<String, dynamic> json) => RestoData(
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class Restaurant {
    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
        required this.menus,
    });

    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;
    final Menus menus;

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
    };
}

class Menus {
    Menus({
        required this.foods,
        required this.drinks,
    });

    final List<Drink> foods;
    final List<Drink> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}

class Drink {
    Drink({
        required this.name,
    });

    final String name;

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };

// List<Restaurant> parseArticles(String? json) {
//   if (json == null) {
//     return [];
//   }
 
//   final List parsed = jsonDecode(json);
//   return parsed.map((json) => Restaurant.fromJson(json)).toList();
// }
}