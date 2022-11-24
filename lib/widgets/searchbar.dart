import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final double topSize;
  final Color? color;
  final double? height;
  const SearchBar({Key? key, required this.topSize, this.color, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topSize, left: 12, right: 12),
      padding: const EdgeInsets.all(7),
      width: double.infinity,
      height: height ?? 50,
      decoration: BoxDecoration(
          color: color ?? const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all((height != null) ? 0 : 4),
              prefixIcon: Image.asset(
                "assets/images/search.png",
              ),
              suffixIcon: Image.asset("assets/images/candle.png"),
              hintText: 'Search by Name',
              hintStyle:
                  const TextStyle(fontSize: 16, color: (Color(0xffA5A5A5))),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
