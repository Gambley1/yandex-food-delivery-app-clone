import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/config/theme/my_theme_data.dart';
import 'package:papa_burger/src/restaurant.dart';

class RestaurantMenusView extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantMenusView({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  late final MenuModel menuModel = MenuModel(restaurantId: restaurant.id);

  _discountCard(List<double> discounts) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultHorizontalPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: discounts.map(
            (discount) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultHorizontalPadding - 6,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: kDefaultHorizontalPadding - 6,
                    ),
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade200,
                          Colors.blue.shade300,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        28,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.lightBlue.shade400,
                                Colors.lightBlue.shade100,
                              ],
                            ),
                          ),
                          child: const CustomIcon(
                            icon: FontAwesomeIcons.percent,
                            type: IconType.simpleIcon,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const KText(
                          text: 'Discount on several items',
                          size: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        KText(
                          text: '${discount.toString()}%',
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  _buildUi(BuildContext context) {
    final menusCategoriesName =
        menuModel.restaurant.menu.map((e) => e.categorie).toList();

    final discounts = menuModel.getDiscounts();

    final navigationCubit = context.read<NavigationCubit>();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              previous.cartModel.cartItems.length !=
              current.cartModel.cartItems.length,
          listener: (context, state) {},
          builder: (context, state) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actionsIconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    leading: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(
                          left: kDefaultHorizontalPadding),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CustomIcon(
                        size: 24,
                        icon: FontAwesomeIcons.arrowLeft,
                        type: IconType.iconButton,
                        onPressed: () {
                          navigationCubit.navigation(0);
                          Navigator.pop(context);
                        },
                      ),
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
                    flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: MyThemeData.restaurantHeaderThemeData,
                      child: CachedImage(
                        inkEffect: InkEffect.noEffect,
                        imageType: CacheImageType.bigImage,
                        imageUrl: restaurant.imageUrl,
                      ),
                    ),
                  ),
                  _discountCard(discounts),
                  for (var i = 0; i < menusCategoriesName.length; i++,) ...[
                    menuModel.restaurant.menu[i].items.isNotEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                top: 12,
                              ),
                              child: KText(
                                text: menuModel.restaurant.menu[i].categorie,
                                size: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(child: null),
                    MenuCard(
                      menuModel: menuModel,
                      i: i,
                      menu: menuModel.restaurant.menu[i],
                    ),
                  ]
                ],
              ),
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
