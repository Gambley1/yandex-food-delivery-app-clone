import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function()? onTap;
  const CustomSearchBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TextEditingController searchBarController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: TextField(
        textInputAction: TextInputAction.done,
        style: GoogleFonts.getFont(
          'Quicksand',
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        controller: searchBarController,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.mic_none,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          hintText: 'Search for recipe',
          hintStyle: GoogleFonts.getFont(
            'Varela Round',
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }
}
