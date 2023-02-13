import 'package:drible_food_recipe_app/src/widgets/custom_google_font.dart';
import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  final String titleOfHeadline;
  final String seeAll;
  final Icon icon;
  final void Function() onTap;
  const CustomHeadline({
    Key? key,
    required this.titleOfHeadline,
    required this.seeAll,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomGoogleFontText(
            text: titleOfHeadline,
            textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: CustomGoogleFontText(
                  text: seeAll,
                  textStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              icon,
            ],
          ),
        ],
      ),
    );
  }
}
