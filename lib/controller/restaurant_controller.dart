import 'package:get/get.dart';
import 'package:pickeat_app/data/api/api_service.dart';
import 'package:pickeat_app/data/model/restaurant.dart';
import 'package:pickeat_app/data/model/restaurant_detail.dart';

class RestaurantsController extends GetxController {
  var restaurantList = <Restaurant>[].obs;
  var topRatedList = <Restaurant>[].obs;
  var restaurantInfo = RestaurantInfo().obs;
  var id = ''.obs;

  @override
  void onInit() {
    fetchAllRestaurant();
    super.onInit();
  }

  void topRated() {
    topRatedList.value = restaurantList
        .where((restaurant) => restaurant.rating! >= 4.5)
        .toList();
  }

  Future<void> fetchRestaurantDetail(String? id) async {
    var detail = await ApiService.detailRestaurant(id);
    try {
      restaurantInfo.value = detail.restaurant;
    } catch (e) {
      e.printError();
    }
  }

  Future<void> fetchAllRestaurant() async {
    var restaurants = await ApiService.listRestaurant();

    try {
      restaurantList.value = restaurants.restaurants;
      topRated();
    } catch (e) {
      return e.printError();
    } finally {
      restaurantList.value = restaurants.restaurants;
    }
  }
}
