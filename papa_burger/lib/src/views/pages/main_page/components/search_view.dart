// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin<SearchView> {
  final TextEditingController? searchController = TextEditingController();

  List<Item> filteredItems = [];
  late int numOfFindResults;

  @override
  void dispose() {
    super.dispose();
    searchController!.dispose();
  }

  _appBar(BuildContext context) {
    final menuItems = context
        .select<MainPageBloc, List<Restaurant>>((b) => b.state.restaurants);
    _runFilter(String inputedKeyword) {
      late List<Item> results;
      if (inputedKeyword.isEmpty) {
        results = [];
      } else {
        final menus = menuItems.map((restaurant) => restaurant.menu).toList();
        final listMenus = menus.expand((menu) => menu).toList();
        final items = listMenus.map((menu) => menu.items).toList();
        final listItems = items.expand((item) => item).toList();
        results = listItems
            .where((element) => element.name
                .toLowerCase()
                .contains(inputedKeyword.toLowerCase()))
            .toList();
        logger.d(results);
      }

      setState(() {
        filteredItems = results;
        numOfFindResults = results.length;
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: Row(
        children: [
          CustomIcon(
            type: IconType.iconButton,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FontAwesomeIcons.arrowLeft,
            size: 22,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8)),
              child: AppInputText(
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPaddingTop: AppDimen.h4,
                focusedBorder: InputBorder.none,
                borderRadius: 24,
                labelText: 'Search...',
                textController: searchController,
                onChanged: (value) => _runFilter(value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _foundResults(BuildContext context) {
    final menuItems = context
        .select<MainPageBloc, List<Restaurant>>((b) => b.state.restaurants);
    return Expanded(
      child: filteredItems.isEmpty
          ? searchController!.text.isEmpty
              ? ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final name = menuItems[index].menu[index].items[index].name;
                    final desc =
                        menuItems[index].menu[index].items[index].description;
                    final price = menuItems[index]
                        .menu[index]
                        .items[index]
                        .getMenuItemsPrice;
                    // final imgPathPng =
                    //     meals[index].imagePathPng.replaceAll(' ', '');

                    return _mealListTile(name, desc, price);
                  },
                )
              : const Center(
                  child: Text('Nothing found'),
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: _numOfFindResults(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final name = filteredItems[index].name;
                      final desc = filteredItems[index].description;
                      final price = filteredItems[index].getMenuItemsPrice;
                      // final imgPathPng =
                      //     filteredItems[index].imagePathPng.replaceAll(' ', '');

                      return _mealListTile(
                        name,
                        desc,
                        price,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  _numOfFindResults() => KText(
        size: 16,
        text: 'Found results: $numOfFindResults',
      );

  _mealListTile(String name, String desc, String price) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushAndRemoveUntil(
        //     PageTransition(
        //       child: RestaurantMenusView(restaurant: restaurant),
        //       type: PageTransitionType.fade,
        //     ),
        //     (route) => true);
      },
      child: ListTile(
        leading: const CachedImage(
          imageType: CacheImageType.smallImage,
          sizeSimpleIcon: 30,
          left: 20,
          top: 0,
          sizeXMark: 16,
          imageUrl: '',
        ),
        title: KText(
          text: name,
          size: 22,
        ),
        subtitle: KText(text: desc),
        trailing: KText(
          text: price,
          size: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _appBar(context),
              _foundResults(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
