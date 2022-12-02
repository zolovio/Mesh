import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/home_tab/home_tabs/post.dart';
import 'package:mesh/screens/search_screen.dart';
// import 'package:mesh/screens/home_screens/home_tab/home_tabs/post.dart';
import 'package:mesh/screens/user_info_screen.dart';
import 'package:mesh/widgets/label.dart';

import '../../../widgets/icon_button.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Post(),
    Post(
      question: true,
    )
  ];
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: ScrollController(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: TabOption(
                          text: "Posts",
                          selectedIndex: _selectedIndex,
                          index: 0,
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: TabOption(
                          text: "Questions",
                          selectedIndex: _selectedIndex,
                          index: 1,
                        ))
                  ],
                )),
            flexibleSpace: _HomeAppBar(),
            toolbarHeight: controller.business.value ? 110 : 159,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          )
        ];
      },
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: _pages.elementAt(_selectedIndex)),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  _HomeAppBar({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AppBarIconButton(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  image: "assets/images/info.png",
                ),
                const Spacer(),
                AppBarIconButton(
                    image: "assets/images/search.png",
                    onTap: () {
                      controller.pages[0] = SearchScreen();
                    }),
                const SizedBox(
                  width: 8,
                ),
                Stack(clipBehavior: Clip.none, children: [
                  AppBarIconButton(
                      image: "assets/images/send.png",
                      onTap: () {
                        Get.toNamed("/messages");
                      }),
                  Positioned(
                    right: 2,
                    top: -3,
                    child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffF5D865))),
                  )
                ]),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UnderLinedText(
                            text: (controller.business.value)
                                ? "Collaborators! "
                                : "Hello",
                            italics: !controller.business.value,
                          ),
                          if (!controller.business.value)
                            const SizedBox(width: 5),
                          if (!controller.business.value)
                            Text("Bishen 😎",
                                style:
                                    Theme.of(context).textTheme.headlineLarge)
                        ],
                      ),
                      if (!controller.business.value)
                        Text("How You Doing?",
                            style: Theme.of(context).textTheme.labelMedium)
                    ],
                  ),
                  const Spacer(),
                  Image.asset("assets/images/star.png",
                      height: controller.business.value ? 100 : 150,
                      width: controller.business.value ? 120 : 170,
                      fit: BoxFit.fill)
                ],
              ),
            ),
          ],
        ));
  }
}
