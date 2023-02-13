// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/views/pages/cart/state/cart.state.dart';

class CartView extends StatelessWidget {
  const CartView({
    Key? key,
  }) : super(key: key);

  _divider() => const SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
        sliver: SliverToBoxAdapter(
          child: Divider(
            height: 1,
            thickness: 1,
          ),
        ),
      );

  _appBar(BuildContext context) {
    final cartProducts = context.select<CartCubit, List<Item>>(
      (b) => b.state.cartModel.cartItems.toList(),
    );

    final restaurant = context
        .select<CartCubit, Restaurant>((b) => b.state.cartModel.cartRestaurant);
    return SliverToBoxAdapter(
      child: Padding(
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
            cartProducts.isNotEmpty
                ? CustomIcon(
                    type: IconType.iconButton,
                    onPressed: () {
                      _showCustomDialogToDeleteAllitems(context);
                    },
                    icon: FontAwesomeIcons.trash,
                    size: 21,
                  )
                : Container(),
          ],
        ),
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
                        text: cartProducts[index].getMenusItemsPriceString,
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
    removeAllFromCart() async {
      context.read<CartCubit>().removeAllItemFromCart();
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

  // _buildUi(BuildContext context) {
  //   final cartIsEmpty = context
  //       .select<CartCubit, bool>((b) => b.state.cartModel.cartItems.isEmpty);
  //   final navigationCubit = context.read<NavigationCubit>();

  //   return Scaffold(
  //     body: SafeArea(
  //       child: BlocBuilder<CartCubit, CartState>(
  //         builder: (context, state) {
  //           return CustomScrollView(
  //             slivers: [
  //               _appBar(context),
  //               !cartIsEmpty
  //                   ? _cartListView(context, state)
  //                   : SliverToBoxAdapter(
  //                       child: Column(
  //                         children: [
  //                           const SizedBox(
  //                             height: 200,
  //                           ),
  //                           const KText(
  //                             text: 'Cart is Empty',
  //                             size: 22,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                           SizedBox(
  //                             height: MediaQuery.of(context).size.width * 0.02,
  //                           ),
  //                           OutlinedButton(
  //                             onPressed: () {
  //                               navigationCubit.navigation(0);
  //                               Navigator.pop(context);
  //                             },
  //                             child: const KText(
  //                               text: 'Explore',
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: MediaQuery.of(context).size.height * 0.1,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //               _divider(),
  //               _buildOptionalAddMoreItems(context, state),
  //               // _buildTotal(state),

  //               // !cartIsEmpty
  //               //     ? Padding(
  //               //         padding: const EdgeInsets.symmetric(
  //               //             horizontal: kDefaultHorizontalPadding,
  //               //             vertical: kDefaultHorizontalPadding),
  //               //         child: Container(
  //               //           decoration: const BoxDecoration(color: Colors.white),
  //               //           child: Column(
  //               //             mainAxisSize: MainAxisSize.min,
  //               //             children: [
  //               //               Row(
  //               //                 children: [
  //               //                   Column(
  //               //                     crossAxisAlignment: CrossAxisAlignment.start,
  //               //                     mainAxisSize: MainAxisSize.min,
  //               //                     children: const [
  //               //                       KText(
  //               //                         text: '52\$',
  //               //                         size: 24,
  //               //                       ),
  //               //                       KText(
  //               //                         text: '40-50 min',
  //               //                       ),
  //               //                     ],
  //               //                   ),
  //               //                   SizedBox(
  //               //                     width: MediaQuery.of(context).size.width * 0.1,
  //               //                   ),
  //               //                   Expanded(
  //               //                     child: ElevatedButton(
  //               //                       onPressed: () {},
  //               //                       child: const KText(
  //               //                         text: 'Confirm',
  //               //                         color: Colors.white,
  //               //                         size: 24,
  //               //                       ),
  //               //                     ),
  //               //                   ),
  //               //                 ],
  //               //               ),
  //               //             ],
  //               //           ),
  //               //         ),
  //               //       )
  //               //     : Container(),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  _buildUi(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<CartState>(
          initialData: const CartState(),
          stream: CartStateT(localStorageRepository: LocalStorageRepository())
              .cartStream,
          builder: (context, snapshot) {
            final data = snapshot.data;
            final active = snapshot.connectionState == ConnectionState.active;
            final done = snapshot.connectionState == ConnectionState.done;
            final waiting = snapshot.connectionState == ConnectionState.waiting;
            final none = snapshot.connectionState == ConnectionState.none;
            return CustomScrollView(
              slivers: [
                _appBar(context),
                active
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final items = data?.cartModel.cartItems.toList();
                            final item = items?[index];
                            return Column(
                              children: [
                                KText(
                                  text: item!.name,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : done
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: KText(
                                text: 'Done',
                              ),
                            ),
                          )
                        : waiting
                            ? SliverToBoxAdapter(
                                child: Column(
                                  children: const [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    CustomCircularIndicator(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )
                            : none
                                ? const SliverToBoxAdapter(
                                    child: Center(
                                      child: KText(
                                        text: 'None',
                                      ),
                                    ),
                                  )
                                : const SliverToBoxAdapter(
                                    child: Center(
                                      child: KText(
                                        text: 'Non handled state',
                                      ),
                                    ),
                                  ),
              ],
            );
          },
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
