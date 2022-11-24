import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mesh/controller/home_controller.dart';
import 'package:mesh/screens/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/screens/home_screens/home_tab/notification_tabs/notification_content.dart'
    as n;
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/icon_button.dart';

class ApplyOfferScreen extends StatelessWidget {
  ApplyOfferScreen({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.pages[2] = NotificationTab();
        return false;
      },
      child: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              flexibleSpace: _ApplyOfferAppBar(),
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
            child: Container(
              color: Colors.white,
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    n.Notification(showClose: false),
                    const SizedBox(height: 15),
                    const _OfferDescription(),
                    CustomButton(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        textSize: 16,
                        height: 59,
                        fontWeight: FontWeight.w600,
                        borderRadius: 8,
                        primaryColor: Theme.of(context).focusColor,
                        buttonText: "Send Offer",
                        onPressed: () {
                          Get.toNamed("/apply-details");
                        })
                  ]),
            )),
      ),
    );
  }
}

class _OfferDescription extends StatelessWidget {
  const _OfferDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(minHeight: 230),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsetsDirectional.all(21),
        decoration: BoxDecoration(
            color: const Color(0xffF7F7F7).withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffE3E3E3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add a description to your offer",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            const SizedBox(height: 17),
            InputTextBig(),
          ],
        ));
  }
}

class InputTextBig extends StatelessWidget {
  InputTextBig({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(minHeight: 126),
        width: double.infinity,
        child: Card(
            elevation: 5,
            shadowColor: const Color(0xff9D9999).withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
                // height: 30,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 800,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xff252529)),
                  decoration: const InputDecoration(
                      counterText: "",
                      hintText: "Max 800 Characters",
                      labelStyle:
                          TextStyle(fontSize: 14, color: Color(0xff252529)),
                      hintStyle:
                          TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none),
                ))));
  }
}

class _ApplyOfferAppBar extends StatelessWidget {
  _ApplyOfferAppBar({
    Key? key,
  }) : super(key: key);
  // _ApplyOfferAppBar
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffF5F6F6),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0, right: 20),
      child: Row(
        children: [
          AppBarIconButton(
            onTap: () {
              controller.pages[2] = NotificationTab();
            },
            image: "assets/images/back.png",
            fillColor: Colors.white70,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
            child: Text("Apply",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
