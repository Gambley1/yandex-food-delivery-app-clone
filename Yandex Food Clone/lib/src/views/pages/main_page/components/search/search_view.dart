import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/services/network/api/search_api.dart';
import 'package:papa_burger/src/views/pages/main_page/state/search_result.dart';

import '../../state/search_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin<SearchView> {
  late final SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(api: SearchApi());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
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
                onChanged: _searchBloc.search.add,
              ),
            ),
          ),
        ],
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
              StreamBuilder(
                stream: _searchBloc.results,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final result = snapshot.data;
                    if (result is SearchResultsError) {
                      return KText(text: result.error.toString());
                    } else if (result is SearchResultsLoading) {
                      return const CustomCircularIndicator(color: Colors.black);
                    } else if (result is SearchResultsNoResults) {
                      return const KText(
                        text: '  Nothing found \n Please try again!',
                        size: 24,
                      );
                    } else if (result is SearchResultsWithResults) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final restaurant = result.restaurants[index];
                            final name = restaurant.name;
                            final rating = restaurant.rating;
                            final tags = restaurant.tagsName;
                            final numOfRatings = restaurant.numOfRatings;
                            final imageUrl = restaurant.imageUrl;
                            final quality = restaurant.quality;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultHorizontalPadding,
                                  vertical: kDefaultHorizontalPadding),
                              child: RestaurantCard(
                                restaurant: restaurant,
                                restaurantImageUrl: imageUrl,
                                restaurantName: name,
                                rating: rating,
                                quality: quality,
                                numOfRatings: numOfRatings,
                                tags: tags,
                              ),
                            );
                          },
                          itemCount: result.restaurants.length,
                        ),
                      );
                    } else {
                      return const KText(text: 'Unhandled state');
                    }
                  } else {
                    return const KText(text: 'Loading...');
                  }
                },
              ),
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
