import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger/src/restaurant.dart';

class FilteredRestaurantsView extends StatelessWidget {
  final List<Restaurant> filteredRestaurants;

  const FilteredRestaurantsView({
    super.key,
    required this.filteredRestaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Card(
                    elevation: 6,
                    child: Column(
                      children: [
                        KText(
                          text: filteredRestaurants[index].name,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
