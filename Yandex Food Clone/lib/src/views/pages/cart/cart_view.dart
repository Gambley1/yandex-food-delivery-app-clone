import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/restaurant.dart';

class CartView extends StatefulWidget {
  const CartView({
    Key? key,
  }) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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

  _appBar(BuildContext context) {
    final cartProducts = context.select<CartCubit, List<Item>>(
      (b) => b.state.cartModel.cartItems.toList(),
    );

    final restaurantId =
        context.select<CartCubit, int>((b) => b.state.cartModel.restaurantId);
    final restaurant = _bloc.getRestaurantById(restaurantId);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultHorizontalPadding - 12,
        vertical: kDefaultHorizontalPadding,
      ),
      child: Row(
        children: [
          CustomIcon(
            icon: FontAwesomeIcons.arrowLeft,
            type: IconType.iconButton,
            onPressed: () {
              // navigationCubit.navigation(0);
              // Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                PageTransition(
                  child: RestaurantMenusView(restaurant: restaurant),
                  type: PageTransitionType.fade,
                ),
              );
            },
          ),
          const KText(
            text: 'Your cart',
            size: 26,
          ),
          const Spacer(),
          // cartProducts.isNotEmpty
          //     ? CustomIcon(
          //         type: IconType.iconButton,
          //         onPressed: () {
          //           _showCustomDialogToDeleteAllitems(context);
          //         },
          //         icon: FontAwesomeIcons.trash,
          //         size: 21,
          //       )
          //     : Container(),
          CustomIcon(
            type: IconType.iconButton,
            onPressed: () {
              _showCustomDialogToDeleteAllitems(context);
            },
            icon: FontAwesomeIcons.trash,
            size: 21,
          ),
        ],
      ),
    );
  }

  _cartListView(BuildContext context, CartState state) {
    final cartProducts = state.cartModel.cartItems.toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = cartProducts[index];

          final imageUrl = product.imageUrl;
          final productName = product.name;

          return InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  horizontal: kDefaultHorizontalPadding,
                  vertical: kDefaultHorizontalPadding - 6),
              child: Row(
                children: [
                  CachedImage(
                    inkEffect: InkEffect.noEffect,
                    imageType: CacheImageType.smallImage,
                    height: 100,
                    width: 100,
                    imageUrl: imageUrl,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: productName,
                        maxLines: 2,
                        size: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      KText(
                        text: cartProducts[index].priceString,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                    ),
                    width: 100,
                    height: 40,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                            ),
                          ),
                        ),
                        KText(
                          text: state.numOfMeals.toString(),
                          size: 18,
                        ),
                        Expanded(
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(kDefaultBorderRadius - 4),
                                bottomRight:
                                    Radius.circular(kDefaultBorderRadius - 4),
                              ),
                            ),
                            onPressed: () {},
                            child: const Icon(
                              FontAwesomeIcons.minus,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: cartProducts.length,
      ),
    );
  }

  _buildOptionalAddMoreItems(
    BuildContext context,
    CartState state,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
          vertical: kDefaultHorizontalPadding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return GestureDetector(
            child: const Card(
              child: KText(
                text: 'test',
              ),
            ),
          );
        }, childCount: 10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 170,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }

  _buildTotal(CartState state) {
    final total = state.cartModel.totalWithDeliveryFee();

    final freeDelivery = state.cartModel.freeDelivery();
    return SliverPadding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: freeDelivery,
              size: 18,
            ),
            KText(
              text: "Total: ${total.floor()}\$",
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  _showCustomDialogToDeleteAllitems(BuildContext context) {
    // removeAllFromCart() {
    //   context.read<CartCubit>().removeAllItemFromCart();
    // }
    removeAllFromCart() {
      _bloc.removeItemsFromCart();
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const KText(
            text: 'Clear the Busket?',
            size: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultHorizontalPadding,
              vertical: kDefaultHorizontalPadding),
          actionsPadding: const EdgeInsets.fromLTRB(kDefaultHorizontalPadding,
              0, kDefaultHorizontalPadding, kDefaultHorizontalPadding),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomButtonInShowDialog(
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      padding: const EdgeInsets.all(kDefaultHorizontalPadding),
                      colorDecoration: Colors.grey.shade200,
                      size: 18,
                      text: 'Cancel',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      removeAllFromCart();
                      Navigator.pop(context);
                    },
                    child: CustomButtonInShowDialog(
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      padding: const EdgeInsets.all(kDefaultHorizontalPadding),
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            StreamBuilder<Set<Item>>(
              stream: _bloc.getItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final items = snapshot.requireData;
                  // if (cart is CartItemsHasError) {
                  //   return KText(text: cart.error.toString());
                  // } else if (cart is CartItemsLoading) {
                  //   return const CustomCircularIndicator(color: Colors.black);
                  // } else if (cart is CartItemsNoItems) {
                  //   return const KText(text: 'No items in cart!');
                  // } else if (cart is CartItemsWithItems) {
                  //   return Expanded(
                  //     child: ListView.builder(
                  //       itemBuilder: (context, index) {
                  //         final items = cart.cart.cartItems.toList();
                  //         final item = items[index];
                  //         final name = item.name;
                  //         final imageUrl = item.imageUrl;
                  //         final price = item.getMenusItemsPriceString;
                  //         return ListTile(
                  //           title: KText(text: name),
                  //           subtitle: KText(text: price),
                  //           trailing: CachedImage(
                  //               imageType: CacheImageType.smallImage,
                  //               imageUrl: imageUrl),
                  //         );
                  //       },
                  //       itemCount: cart.cart.cartItems.length,
                  //     ),
                  //   );
                  // }
                  //  else {
                  //   return KText(text: 'Unhandled state');
                  // }
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final item = items.toList()[index];
                        return ListTile(
                          title: KText(
                            text: item.name,
                          ),
                          subtitle: KText(
                            text: item.priceString,
                          ),
                        );
                      },
                      itemCount: items.length,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      const KText(text: 'Loading'),
                      CustomIcon(
                        type: IconType.iconButton,
                        onPressed: () {
                          _showCustomDialogToDeleteAllitems(context);
                        },
                        icon: FontAwesomeIcons.trash,
                        size: 21,
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return _buildUi(
          context,
        );
      },
    );
  }
}
