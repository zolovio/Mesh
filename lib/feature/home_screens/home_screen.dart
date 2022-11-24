import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mesh/feature/home_screens/home_vm.dart';

import '../drawer/ui/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final _vm = ref.watch(homeVmProvider);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawerr(),
        body: _vm.pages[_vm.selectedPage],
        floatingActionButton: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(
            math.pi / 4,
          ),
          child: SizedBox(
            width: 60.26,
            height: 61.97,
            child: FloatingActionButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                backgroundColor: Theme.of(context).focusColor,
                onPressed: () {
                  // Get.toNamed("/upload");
                },
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(
                      -math.pi / 4,
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 1.5)),
                        child: const Icon(Icons.add)))),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: SizedBox(
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _vm.onSelectedPage(0);
                      },
                      child: BottomItem(
                          selectedIndex: _vm.selectedPage,
                          index: 0,
                          image: "home-active"),
                    ),
                    GestureDetector(
                      onTap: () {
                        _vm.onSelectedPage(1);
                      },
                      child: BottomItem(
                          selectedIndex: _vm.selectedPage,
                          index: 1,
                          image: "cup"),
                    ),
                    GestureDetector(
                      onTap: () {
                        _vm.onSelectedPage(2);
                      },
                      child: BottomItem(
                          selectedIndex: _vm.selectedPage,
                          index: 2,
                          image: "notification"),
                    ),
                    GestureDetector(
                      onTap: () {
                        _vm.onSelectedPage(3);
                      },
                      child: BottomItem(
                          selectedIndex: _vm.selectedPage,
                          index: 3,
                          image: "image"),
                    ),
                  ],
                ))),
        // ),
      );
    });
  }
}

class BottomItem extends StatelessWidget {
  const BottomItem(
      {Key? key,
      required int selectedIndex,
      required this.index,
      required this.image})
      : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;
  final int index;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: (image == "cup" || image == "notification")
            ? EdgeInsets.only(
                bottom: 3,
                left: (image == "notification") ? 40 : 3,
                right: (image == "cup") ? 40 : 3,
                top: 3)
            : const EdgeInsets.all(3.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            (index == 3)
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2,
                          color: (_selectedIndex == index)
                              ? Theme.of(context).focusColor
                              : Colors.transparent),
                    ),
                    child: Image.asset("assets/images/$image.png",
                        fit: BoxFit.cover))
                : Image.asset("assets/images/$image.png",
                    fit: BoxFit.fill,
                    color: (_selectedIndex == index)
                        ? Theme.of(context).focusColor
                        : const Color(0xffC5C5C5)),
            if (_selectedIndex == index)
              Positioned(
                  bottom: (index == 3) ? -13 : -15,
                  left: (index == 3) ? 2 : null,
                  child: Container(
                    width: (_selectedIndex == 2) ? 23 : 25,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Theme.of(context).focusColor),
                  ))
          ],
        ));
  }
}
