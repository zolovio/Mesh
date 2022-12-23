import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/configs/app_router.dart';
import 'package:mesh/screens/view_offer_screen.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:mesh/widgets/searchbar.dart';

import '../widgets/gradient_oval_image.dart';

class MessageScreen extends StatelessWidget {
  static String routeName = "/message";
  const MessageScreen({Key? key}) : super(key: key);

  showModal(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return const ApplyFilter();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            toolbarHeight: 80,
            flexibleSpace: const _MessageAppBar()),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i) {
              if (i == 0) {
                return SearchBar(
                  topSize: 15,
                  tapFunction: () {
                    showModal(context);
                    // print("Clicked");
                  },
                );
              }

              if (i == 1) {
                return Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Stories(),
                    ),
                    const SizedBox(height: 6),
                    Container(margin: const EdgeInsets.symmetric(horizontal: 13), child: const Divider())
                  ],
                );
              }
              return Column(
                children: [const _Message(), Container(margin: const EdgeInsets.symmetric(horizontal: 13), child: const Divider())],
              );
            }));
  }
}

class _MessageAppBar extends StatelessWidget {
  const _MessageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffF5F6F6),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0, right: 20),
        child: Row(
          children: [
            AppBarIconButton(
              onTap: () {
                Get.back();
              },
              image: "assets/images/back.png",
              fillColor: Colors.white70,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
              child: Text("Messenger", style: TextStyle(fontSize: 20, color: Color(0xff252529), fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            AppBarIconButton(image: "assets/images/pencil.png", onTap: () {}, green: true)
          ],
        ));
  }
}

class _Message extends StatelessWidget {
  final bool notSeen;

  const _Message({
    Key? key,
    this.notSeen = false,
    // this.moreinfo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(response);
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.chatScreen);
        // Get.toNamed("/chat");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 3, top: 0, bottom: 0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const OvalImage(
              imageSize: 50,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  width: screenWidth * 0.6,
                  child: const Text("Travis Phillip", style: TextStyle(color: Color(0xff252529), fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: screenWidth * 0.6,
                  child: const Text("awesome work done! really impressed. wanna work together??",
                      style: TextStyle(color: Color(0xff959494), fontSize: 14, fontWeight: FontWeight.w400)),
                ),

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
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: const Text(
                "10min",
                style: TextStyle(fontSize: 14, color: Color(0xff949292)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class Stories extends StatelessWidget {
  Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //topText,
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Container(margin: const EdgeInsets.symmetric(horizontal: 5), child: OvalImage(imageSize: 50)),
                      Positioned(
                          right: 7.0,
                          // bottom: 20,
                          child: Container(
                            width: 17,
                            height: 17,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Theme.of(context).focusColor, border: Border.all(color: Colors.white, width: 4)),
                          ))
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.all(3),
                      child: Text(
                        "Travis\nPhillip",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff252529),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ApplyFilter extends StatefulWidget {
  const ApplyFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<ApplyFilter> createState() => _ApplyFilterState();
}

class _ApplyFilterState extends State<ApplyFilter> {
  // final controller = Get.find<HomeController>();

  final List<String> sortOptions = ["Unread", "New", "Old"];

  var value = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 268,
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox(
                  width: 280,
                  child: Text(
                    "Apply Filter",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff252529)),
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
                      // controller.business.value = false;
                    } else {
                      // controller.business.value = true;
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
                      color: (value == sortOptions[i]) ? const Color(0xffEBF9F9) : const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: (value == sortOptions[i]) ? Colors.transparent : const Color(0xffEEEEF0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(sortOptions[i],
                          style: TextStyle(fontSize: 18, color: (value == sortOptions[i]) ? Theme.of(context).focusColor : const Color(0xffA5A5A5))),
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
