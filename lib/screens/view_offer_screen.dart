import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mesh/controller/home_controller.dart';
import 'package:mesh/screens/home_screens/home_tab/notification_tab.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';

class ViewOfferScreen extends StatelessWidget {
  ViewOfferScreen({Key? key}) : super(key: key);

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
              flexibleSpace: _ViewOfferAppBar(),
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
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (ctx, i) {
                      return _OfferContent(i: i);
                    }))),
      ),
    );
  }
}

class _OfferContent extends StatelessWidget {
  const _OfferContent({Key? key, required this.i}) : super(key: key);
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: (i == 0) ? 10 : 7.5, left: 15, right: 15, bottom: 7.5),
        decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffDBD9D9))),
        child: Column(
          children: const [_OfferTitle(), _OfferDescription(), _OfferButtons()],
        ));
  }
}

class _OfferButtons extends StatelessWidget {
  const _OfferButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).focusColor),
                child: const Text("View Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600))),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 31),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).focusColor),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/message.svg"),
                    const SizedBox(width: 10),
                    Text("Message",
                        style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600))
                  ],
                )),
          ),
        ],
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
        color: const Color(0xffF1F1F3),
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
        child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
            style: TextStyle(fontSize: 14, color: Color(0xff949292))));
  }
}

class _OfferTitle extends StatelessWidget {
  const _OfferTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const OvalImage(
                  imageSize: 46,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Bishen Ponnanna",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff252529),
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2),
                    Text("Song composer",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff949292)))
                  ],
                )
              ],
            ),
            const CloseCircle()
          ],
        ));
  }
}

class CloseCircle extends StatelessWidget {
  const CloseCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffC9C9C9).withOpacity(0.2)),
      child: const Icon(
        Icons.close,
        size: 10,
      ),
    );
  }
}

class _ViewOfferAppBar extends StatelessWidget {
  _ViewOfferAppBar({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<HomeController>();

  showModal(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return const SortFilter();
        },
      );

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
            child: Text("View Offers",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 7),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xffF7D86C),
                  borderRadius: BorderRadius.circular(4)),
              width: 54,
              height: 17,
              child: const Text("16 offers",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff252529)))),
          const Spacer(),
          AppBarIconButton(
            onTap: () {
              showModal(context);
            },
            image: "assets/images/candle.png",
            iconColor: Theme.of(context).focusColor,
          ),
        ],
      ),
    );
  }
}

class SortFilter extends StatefulWidget {
  const SortFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  final List<String> sortOptions = ["Date", "Popularity"];

  var value = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sort By",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff252529)),
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
                  setState(() {
                    value = sortOptions[i];
                  });
                },
                child: Container(
                  width: 327,
                  height: 55,
                  margin: EdgeInsets.only(top: (i == 0) ? 5 : 8, bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                      color: (value == sortOptions[i])
                          ? const Color(0xffEBF9F9)
                          : const Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (value == sortOptions[i])
                              ? Theme.of(context).focusColor
                              : const Color(0xffEEEEF0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sortOptions[i],
                          style: TextStyle(
                              fontSize: 18,
                              color: (value == sortOptions[i])
                                  ? Theme.of(context).focusColor
                                  : const Color(0xffA5A5A5))),
                      if (value == sortOptions[i])
                        Radio(
                            activeColor: Theme.of(context).focusColor,
                            splashRadius: 9,
                            value: sortOptions[i],
                            focusColor: Theme.of(context).focusColor,
                            groupValue: value,
                            onChanged: (v) {})
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
