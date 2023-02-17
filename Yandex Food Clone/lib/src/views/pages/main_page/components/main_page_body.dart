import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';

class MainPageBody extends StatelessWidget {
  const MainPageBody({
    super.key,
    required this.restaurants,
  });

  final List<Restaurant> restaurants;

  final String title = 'What do you want today Sir?';

  _appBar(BuildContext context) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
        child: Row(
          children: [
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.barsStaggered,
            ),
            const Spacer(),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.solidBell,
            ),
            const SizedBox(
              width: 12,
            ),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.cartShopping,
            ),
            const SizedBox(
              width: 12,
            ),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {
                context.read<MainPageBloc>().logOutFromAccount(context);
              },
              icon: FontAwesomeIcons.arrowRightFromBracket,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: Colors.white,
      color: Colors.black,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      displacement: 30,
      onRefresh: () async {
        if (context.mounted) {
          context.read<MainPageBloc>().add(
                LoadMainPageEvent(),
              );
        }
      },
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: CustomScrollView(
          key: const PageStorageKey<String>(
            'main_page_key',
          ),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                top: kDefaultHorizontalPadding,
              ),
              sliver: SliverAppBar(
                title: const KText(
                  text: '',
                ),
                backgroundColor: Colors.white,
                floating: true,
                flexibleSpace: Column(
                  children: const [
                    SearchBar(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _appBar(context),
                  CategoriesSlider(
                    restaurants: restaurants,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultHorizontalPadding,
                    ),
                    child: KText(
                      text: 'Restaurants',
                      size: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            RestaurantsCard(
              restaurants: restaurants,
            ),
          ],
        ),
      ),
    );
  }
}
