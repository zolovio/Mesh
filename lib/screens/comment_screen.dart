import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/widgets/bottom_text_bar.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';

import '../widgets/icon_button.dart';

class CommentScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: 97,
          flexibleSpace: const _CommentAppBar(),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 13,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Text("Comments(12)",
                                  style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              const Spacer(),
                              const Text("30min",
                                  style: TextStyle(
                                      color: Color(0xff949292), fontSize: 16))
                            ],
                          ));
                    }
                    return const _Comment();
                  }),
            ),
            BottomTextBar(postId: controller.postId.value)
          ],
        ));
  }
}

class _CommentAppBar extends StatelessWidget {
  const _CommentAppBar({
    Key? key,
  }) : super(key: key);

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
                  onTap: () {},
                  image: "assets/images/down.png",
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const OvalImage(
                            imageSize: 48,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("BishenPonnanna",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff252529),
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 2),
                              Text("my Daily routine 😍❤️",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff615858)))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class _Comment extends StatelessWidget {
  final bool notSeen;

  const _Comment({
    Key? key,
    this.notSeen = false,
    // this.moreinfo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(response);
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Theme.of(context).focusColor.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 3, top: 0, bottom: 0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const OvalImage(
                  imageSize: 50,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: screenWidth * 0.6,
                      child: const Text("Travis Phillip",
                          style: TextStyle(
                              color: Color(0xff252529),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: screenWidth * 0.67,
                      child: const Text(
                          "awesome work done! really impressed. wanna work together??",
                          style: TextStyle(
                              color: Color(0xff615858),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Like",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff949292))),
                          Text("Reply",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff949292))),
                          Text("2m",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff949292)))
                        ],
                      ),
                    )
                    // if (moreinfo())
                    // CustomButton(
                    //   padding: const EdgeInsets.all(1),
                    //   margin: const EdgeInsets.only(top: 10),
                    //   width: 65,
                    //   height: 25,
                    //   textSize: 9,
                    //   fontWeight: FontWeight.w500,
                    //   buttonText: "View Event",
                    //   onPressed: () {},
                    //   shadowColor: Colors.transparent,
                    //   primaryColor: Colors.transparent,
                    //   borderColor: Theme.of(context).focusColor,
                    //   textColor: Theme.of(context).focusColor,
                    // ),
                  ],
                ),
                // const Spacer(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
