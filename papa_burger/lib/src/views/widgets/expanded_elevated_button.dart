import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

class ExpandedElevatedButton extends StatelessWidget {
  const ExpandedElevatedButton({
    required this.label,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  ExpandedElevatedButton.inProgress({
    required String label,
    Key? key,
  }) : this(
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          key: key,
        );
  final String label;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: AppDimen.h40,
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              label: KText(
                text: label,
                size: 20,
                color: Colors.white,
              ),
              icon: icon,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onTap,
              child: KText(
                text: label,
                size: 20,
                color: Colors.white,
              ),
            ),
    );
  }
}
