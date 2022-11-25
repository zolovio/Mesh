import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:mesh/widgets/searchbar.dart';

import '../feature/home_screens/controllers/home_controller.dart';
import '../feature/home_screens/home_tab/home_tab.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.pages[0] = const HomeTab();
        return false;
      },
      child: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                flexibleSpace: _SearchAppBar(),
                toolbarHeight: 85,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
              )
            ];
          },
          body: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (ctx, i) {
                    return const _SearchSuggestion();
                  },
                ),
              ))),
    );
  }
}

class _SearchSuggestion extends StatelessWidget {
  const _SearchSuggestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            border: Border.all(color: const Color(0xffDFDDDD).withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: const [
            _SearchSuggestionTitle(user: "Kylie Jenner"),
            SizedBox(height: 15),
            _SearchSuggestionImages(),
            SizedBox(height: 15),
          ],
        ));
  }
}

class _SearchSuggestionImages extends StatelessWidget {
  const _SearchSuggestionImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset("assets/images/vertical-image.png",
              width: 75.65, height: 120, fit: BoxFit.cover),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset("assets/images/vertical-image.png",
              width: 75.65, height: 120, fit: BoxFit.cover),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset("assets/images/vertical-image.png",
              width: 75.65, height: 120, fit: BoxFit.cover),
        ),
        Column(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/horizontal-image.png"),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Image.asset("assets/images/horizontal-image.png"),
                Container(
                  height: 54,
                  width: 76.07,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffE1DFDF).withOpacity(0.6)),
                  child: const Text("+20",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class _SearchSuggestionTitle extends StatelessWidget {
  const _SearchSuggestionTitle({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            // Container(
            //   height: 48.0,
            //   width: 48.0,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: NetworkImage(
            //             "https://images.unsplash.com/photo-1582610285985-a42d9193f2fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fHdvbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80")),
            //   ),
            // ),
            GradientOvalImage(
                imageSize: 48, color: Theme.of(context).focusColor),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Harley James",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff252529),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text("Content Creator",
                    style: TextStyle(fontSize: 14, color: Color(0xff949292)))
              ],
            )
          ],
        ),
        const FollowButton()
      ],
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  _SearchAppBar({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffF5F6F6),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        padding:
            const EdgeInsets.only(top: 50, left: 20, bottom: 20, right: 20),
        child: Row(
          children: [
            AppBarIconButton(
              onTap: () {
                controller.pages[0] = const HomeTab();
              },
              image: "assets/images/back.png",
              fillColor: Colors.white70,
            ),
            const Expanded(
                child: SearchBar(
              topSize: 0,
              color: Colors.white,
              height: 44,
            ))
          ],
        ));
  }
}
