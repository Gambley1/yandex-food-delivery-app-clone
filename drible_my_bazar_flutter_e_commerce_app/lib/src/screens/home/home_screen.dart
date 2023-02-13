// ignore_for_file: camel_case_types

import 'package:drible_my_bazar_flutter_e_commerce_app/src/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomGoogleFontText(text: 'my bazar'),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: appBarColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_rounded,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          _searchBarWithFilter(),
          _buildCategoryHeadline(),
          _buildCategorySlider(),
          _buildBestSellingHeadline(),
        ],
      ),
    );
  }
}

class _buildBestSellingHeadline extends StatelessWidget {
  const _buildBestSellingHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeadline(
      titleOfHeadline: 'Best Selling',
      seeAll: 'See all',
      icon: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 12,
      ),
      onTap: () {},
    );
  }
}

class _searchBarWithFilter extends StatelessWidget {
  const _searchBarWithFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 8, 16),
            child: CustomSearchBar(
              onTap: () {},
            ),
          ),
        ),
        const _buildFilter(),
      ],
    );
  }
}

class _buildCategorySlider extends StatelessWidget {
  const _buildCategorySlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            _buildCategoryBackground(
                              categoriesModel: categoriesModel[index],
                            ),
                            _buildCategoryIcon(
                              categoriesModel: categoriesModel[index],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _buildCategoryName(
                          categoriesModel: categoriesModel[index],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              width: 2,
            );
          },
          itemCount: categoriesModel.length),
    );
  }
}

class _buildCategoryName extends StatelessWidget {
  const _buildCategoryName({
    Key? key,
    required this.categoriesModel,
  }) : super(key: key);

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomGoogleFontText(
      text: categoriesModel.name,
    ));
  }
}

class _buildCategoryIcon extends StatelessWidget {
  const _buildCategoryIcon({
    required this.categoriesModel,
    Key? key,
  }) : super(key: key);

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: categoriesModel.icon,
    );
  }
}

class _buildCategoryBackground extends StatelessWidget {
  const _buildCategoryBackground({
    required this.categoriesModel,
    Key? key,
  }) : super(key: key);

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: categoriesModel.backgroundColor,
      ),
      height: 70,
    );
  }
}

class _buildCategoryHeadline extends StatelessWidget {
  const _buildCategoryHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeadline(
      titleOfHeadline: 'Categories',
      seeAll: 'See all',
      icon: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 12,
      ),
      onTap: () {},
    );
  }
}

class _buildFilter extends StatelessWidget {
  const _buildFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange[800],
          borderRadius: BorderRadius.circular(8),
        ),
        width: 50,
        height: 50,
        child: const Icon(
          Icons.filter_alt_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
