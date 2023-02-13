import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/config/theme/my_theme_data.dart';
import 'package:papa_burger/src/restaurant.dart';

class RestaurantMenusView extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantMenusView({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  _appBar(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(6, 36, 6, 0),
        child: Row(
          children: [
            CustomIcon(
              icon: FontAwesomeIcons.arrowLeft,
              type: IconType.iconButton,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const KText(
              text: 'Menu',
              size: 22,
            ),
          ],
        ),
      );

  _showCustomToClearItemsFromCart(BuildContext context, Item menuItems) {
    addItemToCartAfterRemovingAll() {
      context
          .read<CartCubit>()
          .addItemToCartAfterRemovingAll(menuItems, restaurant.id);
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const KText(
            text: 'Need to clear a cart for a new order',
            letterSpacing: 0,
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

  _buildUi(BuildContext context) {
    void addToCart(Item item, int restaurant) {
      context.read<CartCubit>().addItemToCart(item);
      context.read<CartCubit>().initRestaurantIdInCart(restaurant);
    }

    void removeFromCart(Item item, int restaurantId) {
      context.read<CartCubit>().removeItemFromCart(item, restaurantId);
    }

    final restaurantIdInCart =
        context.select<CartCubit, int>((b) => b.state.restaurantId);

    final menusCategoriesName =
        restaurant.menu.map((e) => e.categorie).toList();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              previous.cartItems.length != current.cartItems.length,
          listener: (context, state) {},
          builder: (context, state) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(
                      20,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 25,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  expandedHeight: 290,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: const CachedImage(
                    imageType: CacheImageType.bigImage,
                    imageUrl:
                        'https://images.unsplash.com/photo-1514996183542-72c207fee1e3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80',
                  ),
                ),
                for (var i = 0; i < menusCategoriesName.length; i++,) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 12,
                      ),
                      child: KText(
                        text: restaurant.menu[i].categorie,
                        size: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 18, 12, 36),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.68,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final loadingState =
                              state.cartStatus == CartStatus.cartLoading;
                          final menuItems = restaurant.menu[i].items[index];
                          final inCart = state.cartItems.contains(menuItems);
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(
                                22,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedImage(
                                        imageUrl: '',
                                        top: 25,
                                        left: 40,
                                        sizeSimpleIcon: 42,
                                        sizeXMark: 22,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.14,
                                        width: double.infinity,
                                        imageType: CacheImageType.smallImage,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: menuItems.getMenuItemsPrice,
                                            size: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          KText(
                                            text: menuItems.name,
                                            size: 18,
                                            fontWeight: FontWeight.w500,
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
                                                if (restaurantIdInCart ==
                                                        restaurant.id ||
                                                    restaurantIdInCart == 0) {
                                                  !inCart
                                                      ? addToCart(menuItems,
                                                          restaurant.id)
                                                      : removeFromCart(
                                                          menuItems,
                                                          restaurant.id);
                                                } else {
                                                  _showCustomToClearItemsFromCart(
                                                      context, menuItems);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 1,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    28,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomIcon(
                                                    icon: !inCart
                                                        ? FontAwesomeIcons.plus
                                                        : FontAwesomeIcons
                                                            .minus,
                                                    type: IconType.simpleIcon,
                                                    size: 18,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                  ),
                                                  KText(
                                                    text: !inCart
                                                        ? 'Add'
                                                        : 'Remove',
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
                          );
                        },
                        childCount: restaurant.menu[i].items.length,
                      ),
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: MyThemeData.restaurantViewThemeData,
      child: Builder(
        builder: (context) => _buildUi(context),
      ),
    );
  }
}
