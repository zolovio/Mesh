import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/widgets/bottom_text_bar.dart';
import 'package:mesh/widgets/chats.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:mesh/widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: 106,
          flexibleSpace: const _ChatAppBar(),
        ),
        body: Container(
          color: const Color(0xffF5F6F6),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    reverse: false,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 2 || index == 0) {
                        return Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: const Text("Sat, Oct 23 2022",
                                    style: TextStyle(
                                        color: Color(0xff949292),
                                        fontSize: 14))),

                            //
                            const SizedBox(height: 10),
                            Chats(
                              message: messages[index],
                            )
                          ],
                        );
                      }
                      return Chats(message: messages[index]);
                    },
                  ),
                ),
              ),
              const BottomTextBar(emoji: true)
            ],
          ),
        ));
  }
}

class _ChatAppBar extends StatelessWidget {
  const _ChatAppBar({
    Key? key,
  }) : super(key: key);

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
            const EdgeInsets.only(top: 50, left: 20, bottom: 10, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                AppBarIconButton(
                  onTap: () {
                    Get.back();
                  },
                  image: "assets/images/back.png",
                  fillColor: Colors.white70,
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
                            children: [
                              const Text("BishenPonnanna",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff252529),
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text("Active 20 mins ago",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).focusColor))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AppBarIconButton(
                  image: "assets/images/more.png",
                  onTap: () {},
                )
              ],
            ),
          ],
        ));
  }
}
