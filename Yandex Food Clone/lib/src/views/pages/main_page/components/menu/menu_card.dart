import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({
    super.key,
    required this.menuModel,
    required this.menu,
    required this.i,
  });

  final MenuModel menuModel;
  final Menu menu;
  final int i;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  late final CartBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CartBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showCustomToClearItemsFromCart(BuildContext context, Item menuItems) {
    addItemToCartAfterRemovingAll() {
      context.read<CartCubit>().addItemToCartAfterRemovingAll(
          menuItems, widget.menuModel.restaurantId);
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const KText(
            text: 'Need to clear a cart for a new order',
            size: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomButtonInShowDialog(
                      borderRadius: BorderRadius.circular(18),
                      padding: const EdgeInsets.all(10),
                      colorDecoration: Colors.grey.shade200,
                      size: 18,
                      text: 'Cancel',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      addItemToCartAfterRemovingAll();
                      Navigator.pop(context);
                    },
                    child: CustomButtonInShowDialog(
                      borderRadius: BorderRadius.circular(18),
                      padding: const EdgeInsets.all(10),
                      colorDecoration: primaryColor,
                      size: 18,
                      text: 'Clear',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // void addToCart(Item item, Restaurant restaurant) {
    //   context.read<CartCubit>().addItemToCart(item, restaurant);
    //   context.read<CartCubit>().addRestaurantIdInCart(restaurant);
    // }

    // void removeFromCart(Item item, Restaurant restaurant) {
    //   context.read<CartCubit>().removeItemFromCart(item, restaurant);
    // }

    final restaurantIdInCart =
        context.select<CartCubit, int>((b) => b.state.restaurantId);

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 18, 12, 36),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final menuItems = widget.menu.items[index];
            final name = menuItems.name;
            final price = menuItems.priceString;
            final description = menuItems.description;

            final inCart =
                _bloc.cachedCartItems.contains(menuItems) &&
                    restaurantIdInCart == widget.menuModel.restaurant.id;
            final hasDiscount = menuItems.price != 0;

            final priceTotal =
                widget.menuModel.priceOfItem(i: widget.i, index: index);
            final discountPrice = '$priceTotal\$';

            return Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(
                  22,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                  child: Column(
                    children: [
                      CachedImage(
                        inkEffect: InkEffect.withEffect,
                        imageUrl: menuItems.imageUrl,
                        radius: 22,
                        top: 25,
                        left: 40,
                        sizeSimpleIcon: 42,
                        sizeXMark: 22,
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: double.infinity,
                        imageType: CacheImageType.smallImage,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hasDiscount
                              ? DiscountPrice(
                                  defaultPrice: price,
                                  discountPrice: discountPrice)
                              : KText(
                                  text: price,
                                ),
                          KText(
                            text: name,
                            size: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          KText(
                            text: description,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                      const Spacer(),
                           ElevatedButton(
                              onPressed: () {
                                HapticFeedback.heavyImpact();
                                _bloc.addToCart(menuItems, widget.menuModel.restaurantId);
                                logger.i('tapped');
                                // if (restaurantIdInCart ==
                                //         menuModel.restaurant.id ||
                                //     restaurantIdInCart == 0) {
                                //   !inCart
                                //       ? addToCart(menuItems,
                                //           menuModel.restaurant)
                                //       : removeFromCart(menuItems,
                                //           menuModel.restaurant);
                                // } else {
                                //   _showCustomToClearItemsFromCart(
                                //       context, menuItems);
                                // }
                                // if (restaurantIdInCart ==
                                //         menuModel.restaurant.id ||
                                //     restaurantIdInCart == 0) {
                                //   if (inCart) {
                                //     removeFromCartTest(
                                //         menuItems, menuModel.restaurant);
                                //   } else {
                                //     addToCartTest(
                                //         menuItems, menuModel.restaurant);
                                //   }
                                // } else {
                                //   _showCustomToClearItemsFromCart(
                                //       context, menuItems);
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    22,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIcon(
                                    icon: !inCart
                                        ? FontAwesomeIcons.plus
                                        : FontAwesomeIcons.minus,
                                    type: IconType.simpleIcon,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  KText(
                                    text: !inCart ? 'Add' : 'Remove',
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: widget.menu.items.length,
        ),
      ),
    );
  }
}
