import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

class DiscountPrice extends StatelessWidget {
  const DiscountPrice({
    super.key,
    required this.defaultPrice,
    required this.discountPrice,
  });

  final String defaultPrice;
  final String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        KText(
          text: '$defaultPrice ',
          color: Colors.orange.shade800,
          size: 22,
        ),
        Column(
          children: [
            KText(
              text: discountPrice,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              size: 14,
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ],
    );
  }
}
