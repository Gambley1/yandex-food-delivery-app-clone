// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';

class CartView extends StatelessWidget {
  const CartView({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  _appBar(BuildContext context) {
    final cartProducts = context.select<CartCubit, List<Item>>(
      (b) => b.state.cartItems
          .where((item) => b.state.cartItems.contains(item))
          .toList(),
    );
    final navigationCubit = context.read<NavigationCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: Row(
        children: [
          CustomIcon(
              icon: FontAwesomeIcons.arrowLeft,
              type: IconType.iconButton,
              onPressed: () {
                navigationCubit.navigation(0);
                Navigator.pop(context);
              }),
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
    );
  }

  _cartListView(BuildContext context) => BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartIsEmpty =
              context.select<CartCubit, bool>((b) => b.state.cartItems.isEmpty);
          final cartProducts = context.select<CartCubit, List<Item>>(
            (b) => b.state.cartItems
                .where((item) => b.state.cartItems.contains(item))
                .toList(),
          );
          final navigationCubit = context.read<NavigationCubit>();

          return !cartIsEmpty
              ? Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                          child: Row(
                            children: [
                              const CachedImage(
                                imageType: CacheImageType.smallImage,
                                imageUrl: '',
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: cartProducts[index].name,
                                    maxLines: 2,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  KText(
                                    text: cartProducts[index].getMenuItemsPrice,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(16)),
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
                                            topRight: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
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
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      );
                    },
                    itemCount: cartProducts.length,
                  ),
                )
              : Column(
                  children: [
                    const KText(
                      text: 'Cart is Empty',
                      size: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigationCubit.navigation(0);
                        Navigator.pop(context);
                      },
                      child: const KText(
                        text: 'Explore',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                );
        },
      );

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
                      removeAllFromCart();
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
    final cartIsEmpty =
        context.select<CartCubit, bool>((b) => b.state.cartItems.isEmpty);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _appBar(context),
            _cartListView(context),
            !cartIsEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  KText(
                                    text: '52\$',
                                    size: 24,
                                  ),
                                  KText(
                                    text: '40-50 min',
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const KText(
                                    text: 'Confirm',
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
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
