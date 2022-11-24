import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh/feature/home_screens/home_tab/user_tabs/portfolio/portfolio.dart';

import 'package:mesh/feature/userinfo/ui/user_info_screen.dart' as t;
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';

import '../home_vm.dart';

class UserTab extends StatefulWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    _EditProfileAbout(),
    _EditProfileAbout(
      exp: true,
    ),
    Container(),
    Portfolio(edit: true)
  ];

  final List<String> _tabs = ["About", "Experience", "Training", "Portfolio"];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final controller = ref.watch(homeVmProvider);
      return WillPopScope(
        onWillPop: () async {
          controller.pages[3] = const t.UserInfoScreen(
            myprofile: true,
          );
          return false;
        },
        child: NestedScrollView(
            controller: ScrollController(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  flexibleSpace: _UserTabAppBar(),
                  toolbarHeight: 90,
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
                    Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 16.0, 8.0, 12.0),
                              child: Row(
                                children: <Widget>[
                                  GradientOvalImage(
                                    imageSize: 64,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Angelina Philip",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff252529),
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 2),
                                      Row(children: [
                                        SvgPicture.asset(
                                            "assets/icons/edit-2.svg"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text("Change Profile Picture",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .focusColor)),
                                      ])
                                    ],
                                  )
                                ],
                              ),
                            ),
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
                                      return t.Tab(
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
                        )),
                    if (_selectedIndex == 3)
                      Container(
                          margin: const EdgeInsets.all(15),
                          child: const CancelOrSave())
                  ],
                ))),
      );
    });
  }
}

class _UserTabAppBar extends StatelessWidget {
  _UserTabAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final controller = ref.watch(homeVmProvider);
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffF5F6F6),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0, right: 20),
        child: Row(
          children: [
            AppBarIconButton(
              onTap: () {
                controller.pages[3] = const t.UserInfoScreen(
                  myprofile: true,
                );
              },
              image: "assets/images/back.png",
              fillColor: Colors.white70,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
              child: Text("Edit Profile",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff252529),
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    });
  }
}

class _EditProfileAbout extends StatelessWidget {
  _EditProfileAbout({Key? key, this.exp = false}) : super(key: key);
  final bool exp;

  final about = TextEditingController(text: "Angela");
  final experience = TextEditingController();
  final List<String> tags = [
    "Videography 1 year",
    "Art 3 year",
    "Painting 2 year",
    "Modelling 4 year"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: HeadingText(
                text: (exp) ? "Experience" : "Name",
              )),
          Container(
              // height: 30,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 15),
              child: TextField(
                controller: (exp) ? experience : about,
                style: const TextStyle(fontSize: 16, color: Color(0xff252529)),
                decoration: InputDecoration(
                    hintText: (exp) ? "Tell Us Your Exp Level" : "Enter Name",
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Color(0xff252529)),
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Color(0xff9D9D9D)),
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE3E3E3))),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE3E3E3))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE3E3E3))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Color(0xffE3E3E3)))),
              )),
          Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: const HeadingText(
                text: "Skills",
              )),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE3E3E3),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Wrap(spacing: 15, runSpacing: 10, children: [
                for (String tag in tags)
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 9),
                      decoration: BoxDecoration(
                          color: const Color(0xffE7F8F8),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(tag,
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600))),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE7E6E6)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text("Add tag",
                        style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)))
              ])),
          const CancelOrSave()
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff252529)));
  }
}
