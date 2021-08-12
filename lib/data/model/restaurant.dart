import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Object menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> resturant) {
    id = resturant['id'];
    name = resturant['name'].toString();
    description = resturant['description'].toString();
    pictureId = resturant['pictureId'];
    city = resturant['city'].toString();
    rating = resturant['rating'].toDouble();

    menus = resturant['menus'];

    
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  Map<String, dynamic> map = jsonDecode(json);
  final List parsed = map['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
