// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:papa_burger/src/restaurant.dart';

class MenuModel {
  final Restaurant restaurant;
  MenuModel({
    required this.restaurant,
  });

  // bool get hasDiscount => restaurant.discount != 0 ? true : false;

  double priceOfItem({
    required int index,
    required int i,
  }) {
    final Item item = restaurant.menu[i].items[index];
    final double itemPrice = item.price;

    if (item.price == 0) return itemPrice;

    // final int restaurantDiscount = restaurant.discount;
    final double itemDiscount = item.price;

    final double discount = itemPrice * (itemDiscount / 100);
    final double discountPrice = itemPrice - discount;

    return discountPrice;
  }

  List<double> getDiscounts() {
    final Set<double> allDiscounts = <double>{};

    for (final menu in restaurant.menu) {
      for (final item in menu.items) {
        final menus = restaurant.menu;
        final promotionItems =
            menus.where((menu) => menu.categorie == 'Promotion').toList();
        if (item.price == 0.0) {
          allDiscounts.remove(0);
          promotionItems.map((e) => e.items.clear());
        }
        allDiscounts
          ..add(item.price)
          ..remove(0);
        promotionItems.map(
          (e) => e.items.add(item),
        );
      }
    }
    final List<double> listDiscounts = List.from(allDiscounts)
      ..lock
      ..sort();

    final sortedDiscounts = listDiscounts;
    return sortedDiscounts;
  }

  String get stringPrice => '$priceOfItem\$';
}
