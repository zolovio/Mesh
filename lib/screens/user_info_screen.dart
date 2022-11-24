import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/controller/home_controller.dart';
import 'package:mesh/screens/home_screens/home_tab/home_tab.dart';
import 'package:mesh/screens/home_screens/home_tab/user_tab.dart';
import 'package:mesh/screens/home_screens/home_tab/user_tabs/about/about.dart';
import 'package:mesh/screens/home_screens/home_tab/user_tabs/portfolio/portfolio.dart';
import 'package:mesh/screens/view_offer_screen.dart';
import 'package:mesh/widgets/button.dart';

import 'package:mesh/widgets/gradient_oval_image.dart';

import '../widgets/icon_button.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, this.myprofile = false}) : super(key: key);
  final bool myprofile;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  int _selectedIndex = 0;

  bool following = false;

  final List<Widget> _pages = <Widget>[
    AboutTab(),
    AboutTab(exp: true),
    Container(),
    Portfolio()
  ];
  final controller = Get.find<HomeController>();

  final List<String> _tabs = ["About", "Experience", "Training", "Portfolio"];

  showModal(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return const SwitchToBusiness();
        },
      );

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              flexibleSpace: _HomeAppBar(),
              toolbarHeight: 226,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
            )
          ];
        },
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(color: Colors.white, child: const _FollowerCount()),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        (widget.myprofile)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                      margin: const EdgeInsets.all(0),
                                      padding: const EdgeInsets.all(0),
                                      borderRadius: 8,
                                      buttonText: "Edit Profile",
                                      onPressed: () {
                                        controller.pages[3] = const UserTab();
                                      },
                                      width: 116,
                                      height: 40,
                                      textSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Theme.of(context).focusColor,
                                      shadowColor: Colors.transparent,
                                      borderColor: Theme.of(context).focusColor,
                                      primaryColor: Colors.transparent),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      showModal(context);
                                    },
                                    child: const FollowButton(
                                        text: "Switch to Business",
                                        width: 176,
                                        height: 40),
                                  ),
                                ],
                              )
                            : (following)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            following = false;
                                          });
                                        },
                                        child: const FollowButton(
                                            text: "Following",
                                            width: 101,
                                            height: 40),
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                          margin: const EdgeInsets.all(0),
                                          padding: const EdgeInsets.all(0),
                                          borderRadius: 8,
                                          buttonText: "Message",
                                          onPressed: () {},
                                          width: 101,
                                          height: 40,
                                          textSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor:
                                              Theme.of(context).focusColor,
                                          shadowColor: Colors.transparent,
                                          borderColor:
                                              Theme.of(context).focusColor,
                                          primaryColor: Colors.transparent)
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        following = true;
                                      });
                                    },
                                    child: const FollowButton()),
                        const SizedBox(height: 10),
                        Container(
                            height: 65,
                            alignment: Alignment.center,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF7F7F7)),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _tabs.length,
                                itemBuilder: (ctx, i) {
                                  return Tab(
                                      tabs: _tabs[i],
                                      i: _selectedIndex,
                                      index: i,
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = i;
                                        });
                                      });
                                })),
                        _pages.elementAt(_selectedIndex)
                      ],
                    ))
              ],
            )));
  }
}

class Tab extends StatelessWidget {
  const Tab(
      {Key? key,
      required String tabs,
      required this.onTap,
      required this.i,
      required this.index})
      : _tabs = tabs,
        super(key: key);

  final String _tabs;
  final void Function()? onTap;
  final int i;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: (i == index) ? Colors.white : null,
              borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          alignment: Alignment.center,
          child: Text(
            _tabs,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: (i == index)
                    ? Theme.of(context).focusColor
                    : const Color(0xff9D9D9D)),
          )),
    );
  }
}

class _FollowerCount extends StatelessWidget {
  const _FollowerCount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEFEF),
            blurRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text("100",
                  style: TextStyle(
                      color: Color(0xff252529),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                "Posts",
                style: TextStyle(
                    color: Theme.of(context).focusColor, fontSize: 14),
              )
            ],
          ),
          const SizedBox(width: 15),
          Column(
            children: [
              const Text("300",
                  style: TextStyle(
                      color: Color(0xff252529),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                "Following",
                style: TextStyle(
                    color: Theme.of(context).focusColor, fontSize: 14),
              )
            ],
          ),
          const SizedBox(width: 15),
          Column(
            children: [
              const Text("2908",
                  style: TextStyle(
                      color: Color(0xff252529),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                "Followers",
                style: TextStyle(
                    color: Theme.of(context).focusColor, fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// _pages.elementAt(_selectedIndex)

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
          color: Color(0xffEBF9F9),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarIconButton(
                  onTap: () {
                    controller.pages[0] = const HomeTab();
                  },
                  image: "assets/images/back.png",
                  fillColor: Colors.white70,
                  green: true,
                ),
                const Spacer(),
                Image.asset("assets/images/star.png",
                    height: 210, width: 140, fit: BoxFit.fill)
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  GradientOvalImage(
                      imageSize: 86, color: Theme.of(context).focusColor),
                  const SizedBox(height: 10),
                  const Text(
                    "Bishen Ponnanna",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff252529),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Male",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).focusColor,
                              fontWeight: FontWeight.w600),
                        ),
                        const VerticalDivider(),
                        const Text(
                          "Age 24",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff615858),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class TabOption extends StatelessWidget {
  const TabOption(
      {Key? key,
      required int selectedIndex,
      required this.index,
      this.radio = false,
      required this.text})
      : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;
  final int index;
  final bool radio;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (radio)
              Transform.scale(
                scale: (_selectedIndex == index) ? 1 : 0.5,
                child: Theme(
                  data: ThemeData(
                    //here change to your color
                    unselectedWidgetColor: const Color(0xffC6C5C5),
                  ),
                  child: Radio(
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Theme.of(context).focusColor,
                      value: index.toString(),
                      focusColor: Theme.of(context).focusColor,
                      groupValue: _selectedIndex.toString(),
                      onChanged: (v) {}),
                ),
              ),
            if (radio && _selectedIndex == index) const SizedBox(width: 9),
            Text(text,
                style: TextStyle(
                    color: (_selectedIndex != index)
                        ? const Color(0xff9D9D9D)
                        : Theme.of(context).focusColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class SwitchToBusiness extends StatefulWidget {
  const SwitchToBusiness({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchToBusiness> createState() => _SwitchToBusinessState();
}

class _SwitchToBusinessState extends State<SwitchToBusiness> {
  final controller = Get.find<HomeController>();

  final List<String> sortOptions = ["No", "Yes"];

  var value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 258,
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 280,
                      child: Text(
                        "Are you sure you want to switch to business account?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff252529)),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CloseCircle())
                  ]),
            ),
            const Divider(
              color: Color(0xffEBEAEA),
            ),
            for (int i = 0; i < sortOptions.length; i++)
              GestureDetector(
                onTap: () {
                  if (value != sortOptions[i]) {
                    setState(() {
                      value = sortOptions[i];
                    });
                  } else {
                    if (i == 0) {
                      controller.business.value = false;
                    } else {
                      controller.business.value = true;
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 327,
                  height: 48,
                  margin: EdgeInsets.only(top: (i == 0) ? 5 : 8, bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                      color: (value == sortOptions[i])
                          ? const Color(0xffEBF9F9)
                          : const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (value == sortOptions[i])
                              ? Colors.transparent
                              : const Color(0xffEEEEF0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(sortOptions[i],
                          style: TextStyle(
                              fontSize: 18,
                              color: (value == sortOptions[i])
                                  ? Theme.of(context).focusColor
                                  : const Color(0xffA5A5A5))),
                      // if (value == sortOptions[i])
                      //   Radio(
                      //       activeColor: Theme.of(context).focusColor,
                      //       splashRadius: 9,
                      //       value: sortOptions[i],
                      //       focusColor: Theme.of(context).focusColor,
                      //       groupValue: value,
                      //       onChanged: (v) {})
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
