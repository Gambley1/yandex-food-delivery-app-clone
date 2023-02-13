import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final bool? dense;
  final bool? isThreeLine;
  final ShapeBorder? shape;
  final Color? iconColor;
  const CustomListTile({
    Key? key,
    this.title,
    this.subTitle,
    this.leading,
    this.trailing,
    this.dense,
    this.isThreeLine,
    this.shape,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subTitle,
      leading: leading,
      dense: dense ?? false,
      trailing: trailing,
      isThreeLine: isThreeLine ?? false,
      shape: shape,
      iconColor: iconColor ?? Colors.black,
    );
  }
}
