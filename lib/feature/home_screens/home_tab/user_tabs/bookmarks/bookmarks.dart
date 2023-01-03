import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/home_tab/home_tabs/post.dart';

import '../../../../../widgets/label.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  int _selectedIndex = 0;
  final controller = Get.find<HomeController>();
  final List<String> _tabs = ["Post", "Questions"];
  pages() => <Widget>[
        Post(isBookMarks: true),
        Post(question: true, isBookMarks: true),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (int i = 0; i < _tabs.length; i++)
            Stack(clipBehavior: Clip.none, children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
                child: Text(
                  _tabs[i],
                  style: TextStyle(fontSize: 16, color: (_selectedIndex == i) ? Theme.of(context).focusColor : const Color(0xff9D9D9D)),
                ),
              ),
              if (_selectedIndex == i)
                Positioned(
                    bottom: -15,
                    right: 5,
                    left: 5,
                    child: Container(
                      width: 25,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Theme.of(context).focusColor),
                    ))
            ])
        ]),
        const SizedBox(height: 5),
        const CustomDivider(),
        pages().elementAt(_selectedIndex)
        // const Pictures()
      ]),
    );
  }
}
