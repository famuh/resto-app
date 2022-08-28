

import 'dart:convert';

class Resto {
  final String name;
  final String description;
  final String urlImg;
  final String city;
  final String rating;

  Resto({
    required this.name,
    required this.description,
    required this.urlImg,
    required this.city,
    required this.rating,
  });

//  @override
//  String toString(){
//   return 'Resto{name : $name}';
//  }

  factory Resto.fromJson(Map<String, dynamic> resto) {
    return Resto(
      name: resto['restaurants']['name'],
      description: resto['restaurants']['description'],
      urlImg: resto['restaurants']['urlImg'],
      city: resto['restaurants']['city'],
      rating: resto['restaurants']['rating'],
    );
  }

// Future _loadJson() async{
//   String jsonString = await rootBundle.loadString('assets/resto_data.json');
//   final jsonData = jsonDecode(jsonString);
//   Resto resto = Resto.fromJson(jsonData);

// }
  
List<Resto> parseArticles(String? json) {
  if (json == null) {
    return [];
  }
 
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Resto.fromJson(json)).toList();
}
}
