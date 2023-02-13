import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/views/pages/cart/state/cart.state.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.state,
    required this.menuModel,
    required this.menu,
    required this.i,
  });

  final CartState state;
  final MenuModel menuModel;
  final Menu menu;
  final int i;

  _showCustomToClearItemsFromCart(BuildContext context, Item menuItems) {
    addItemToCartAfterRemovingAll() {
      context
          .read<CartCubit>()
          .addItemToCartAfterRemovingAll(menuItems, menuModel.restaurant);
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
    void addToCart(Item item, Restaurant restaurant) {
      context.read<CartCubit>().addItemToCart(item, restaurant);
      context.read<CartCubit>().addRestaurantIdInCart(restaurant);
    }

    void addToCartTest(Item item, Restaurant restaurant) {
      CartStateT(localStorageRepository: LocalStorageRepository())
          .addToCart(cartItem: item, restaurant: restaurant);
    }

    void removeFromCart(Item item, Restaurant restaurant) {
      context.read<CartCubit>().removeItemFromCart(item, restaurant);
    }

    void removeFromCartTest(Item item, Restaurant restaurant) {
      CartStateT(localStorageRepository: LocalStorageRepository())
          .removeFromCart(cartItem: item, restaurant: restaurant);
    }

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
            final loadingState =
                CartStateT(localStorageRepository: LocalStorageRepository())
                        .state
                        .cartStatus ==
                    CartStatus.loading;
            final menuItems = menu.items[index];
            final inCart =
                CartStateT(localStorageRepository: LocalStorageRepository())
                    .state
                    .cartModel
                    .cartItems
                    .contains(menuItems);

            final hasDiscount = menuItems.price != 0;

            final menuPriceTotal = menuModel.priceOfItem(i: i, index: index);
            final menuPriceString = menuPriceTotal.toString();

            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(
                    22,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedImage(
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
                                  ? Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            KText(
                                              text: 'not ${menuItems.price}',
                                              size: 18,
                                              color: Colors.black54,
                                            ),
                                            KText(
                                              text: menuPriceString,
                                              size: 20,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  : KText(
                                      text: menuItems.getMenusItemsPriceString,
                                    ),
                              KText(
                                text: menuItems.name,
                                size: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              KText(
                                text: menuItems.description,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                          const Spacer(),
                          !loadingState
                              ? ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();

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
                                    if (restaurantIdInCart ==
                                            menuModel.restaurant.id ||
                                        restaurantIdInCart == 0) {
                                      if (inCart) {
                                        removeFromCartTest(
                                            menuItems, menuModel.restaurant);
                                      } else {
                                        addToCartTest(
                                            menuItems, menuModel.restaurant);
                                      }
                                    } else {
                                      _showCustomToClearItemsFromCart(
                                          context, menuItems);
                                    }
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
                                    mainAxisSize: MainAxisSize.max,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      KText(
                                        text: !inCart ? 'Add' : 'Remove',
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                )
                              : ExpandedElevatedButton.inProgress(
                                  label: '',
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: menu.items.length,
        ),
      ),
    );
  }
}
