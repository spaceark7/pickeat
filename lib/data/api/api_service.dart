import 'dart:convert';

import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var client = http.Client();

  Restaurant? restaurant;
  String? query = "";
  String id = "";
  String size = '';
  String get getSize => this.size;
  set setSize(String size) => this.size = size;

  static final String baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String listEndPoint = '/list';
  late String detailEndPoint = '/detail/$id';
  late String searchEndpoint = '/search?q=$query';
  late final String fetchPictureOption =
      "https://restaurant-api.dicoding.dev/images/";

  Future<Restaurants> listRestaurant() async {
    final response = await client.get(Uri.parse(baseUrl + listEndPoint));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load data');
    }
  }

 
}
