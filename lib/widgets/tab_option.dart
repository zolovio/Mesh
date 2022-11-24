import 'package:flutter/material.dart';

class TabOption extends StatelessWidget {
  const TabOption(
      {Key? key,
      required int selectedIndex,
      required this.index,
      required this.text})
      : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;
  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166,
      height: 61,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (_selectedIndex == index) ? Colors.white : null,
          border: Border.all(
              color: Theme.of(context).indicatorColor,
              width: (_selectedIndex == index) ? 8 : 1)),
      child: Align(
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyle(
                color: (_selectedIndex != index)
                    ? const Color(0xff9D9D9D)
                    : Theme.of(context).focusColor,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
