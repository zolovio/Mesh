import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/screens/follow_request_screen.dart';
import 'package:mesh/widgets/label.dart';
import 'package:mesh/widgets/profile_cover_pic.dart';

class DrawerOption {
  final String image;
  final String text;
  final bool arrow;
  final VoidCallback tapEvent;

  DrawerOption({
    required this.image,
    required this.text,
    required this.arrow,
    required this.tapEvent,
  });
}

class Drawerr extends StatelessWidget {
  Drawerr({required this.context}) {
    options = [
      DrawerOption(
          image: "assets/icons/envelop.svg",
          text: "My Questions",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().userInfoScreenSelectedIndex.value = 1;
            Get.find<HomeController>().selectedPage.value = 3;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/message-yellow-dot.svg",
          text: "My Posts",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().userInfoScreenSelectedIndex.value = 0;
            Get.find<HomeController>().selectedPage.value = 3;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/calendar.svg",
          text: "My Training",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().notificationTabSelectedIndex.value = 2;
            Get.find<HomeController>().selectedPage.value = 2;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/graduate.svg",
          text: "My Competition",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().notificationTabSelectedIndex.value = 0;
            Get.find<HomeController>().selectedPage.value = 2;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/message-green-dot.svg",
          text: "Audition",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().notificationTabSelectedIndex.value = 1;
            Get.find<HomeController>().selectedPage.value = 2;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/bookmark.svg",
          text: "Bookmark",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().userInfoScreenSelectedIndex.value = 2;
            Get.find<HomeController>().selectedPage.value = 3;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/people.svg",
          text: "Collaborators",
          arrow: true,
          tapEvent: () {
            Get.find<HomeController>().collaborator.value = !Get.find<HomeController>().collaborator.value;
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/envelop.svg",
          text: "Follow Requests",
          arrow: true,
          tapEvent: () {
            print("tap");
            Navigator.popAndPushNamed(context, FollowRequestScreen.routeName);
          }),
      DrawerOption(
          image: "assets/icons/message-green-dot.svg",
          text: "Settings",
          arrow: true,
          tapEvent: () {
            // tap event goes here
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/calendar.svg",
          text: "Marketplace",
          arrow: false,
          tapEvent: () {
            // tap event goes here
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/graduate.svg",
          text: "Helps and FAQs",
          arrow: true,
          tapEvent: () {
            // tap event goes here
            Navigator.pop(context);
          }),
      DrawerOption(
          image: "assets/icons/logout.svg",
          text: "Logout",
          arrow: false,
          tapEvent: () {
            // tap event goes here
            Navigator.pop(context);
          })
    ];
  }

  final BuildContext context;
  late List<DrawerOption> options;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        const ProfileCoverPic(),
        const SizedBox(height: 35),
        const Text(
          "Bishen Ponnanna",
          style: TextStyle(fontSize: 18, color: Color(0xff252529), fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "View Profile",
          style: TextStyle(fontSize: 14, color: Theme.of(context).focusColor, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 2,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length - 1,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  DrawerOptions(options: options, i: i),
                  if (i != options.length - 2) const CustomDivider(),
                ],
              );
            }),
        Expanded(
          child: Container(),
        ),
        DrawerOptions(
          options: options,
          i: options.length - 1,
          color: const Color(0xffF5F5F5),
        )
      ],
    ));
  }
}

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({Key? key, required this.options, required this.i, this.color}) : super(key: key);

  final List<DrawerOption> options;
  final int i;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: options[i].tapEvent,
      child: Container(
          color: color,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              SvgPicture.asset(options[i].image),
              const SizedBox(width: 8),
              Text(options[i].text),
              const Spacer(),
              if (options[i].text != "Logout")
                (options[i].arrow)
                    ? SvgPicture.asset("assets/icons/arrow-right.svg")
                    : Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffF7D86C),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: 76,
                        height: 19,
                        child: const Text(
                          "Coming Soon",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff755600),
                          ),
                        ),
                      ),
            ],
          )),
    );
  }
}
