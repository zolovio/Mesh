import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/home_tab/user_tab.dart';
import 'package:mesh/screens/apply_offer_screen.dart';
import 'package:mesh/screens/view_offer_screen.dart';
import 'package:mesh/widgets/label.dart';
import 'package:mesh/widgets/searchbar.dart';

class CompetitionTab extends StatefulWidget {
  const CompetitionTab({Key? key, this.edit = false}) : super(key: key);
  final bool edit;
  @override
  State<CompetitionTab> createState() => _CompetitionTabState();
}

class _CompetitionTabState extends State<CompetitionTab> {
  int _selectedIndex = 0;
  final controller = Get.find<HomeController>();
  List<String> _tabs() => (controller.business.value)
      ? ["Active Training", "All Courses", "My Training"]
      : [
          "Active Competition",
          "My Competition",
        ];
  pages() => <Widget>[
        NotificationContent(
          competition: true,
        ),
        if (controller.business.value) NotificationContent(),
        NotificationContent()
      ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      width: double.infinity,
      child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              for (int i = 0; i < _tabs().length; i++)
                Stack(clipBehavior: Clip.none, children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = i;
                      });
                    },
                    child: Text(
                      _tabs()[i],
                      style: TextStyle(
                          fontSize: 16,
                          color: (_selectedIndex == i)
                              ? Theme.of(context).focusColor
                              : const Color(0xff9D9D9D)),
                    ),
                  ),
                  if (_selectedIndex == i)
                    Positioned(
                        bottom: -15,
                        right: (controller.business.value) ? 10 : 30,
                        left: (controller.business.value) ? 10 : 30,
                        child: Container(
                          // width: 25,
                          height: 4,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Color(0xffF7D86C)),
                        ))
                ])
            ]),
            const SizedBox(height: 5),
            const CustomDivider(),
            pages().elementAt(_selectedIndex)
            // const Pictures()
          ]),
    );
  }
}

class NotificationContent extends StatelessWidget {
  NotificationContent(
      {Key? key, this.competition = false, this.earnings = false})
      : super(key: key);
  final bool competition;
  final bool earnings;
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (earnings) ? 6 : 4,
        itemBuilder: (ctx, i) {
          if (earnings && i == 0) {
            return const _TotalEarning();
          }
          if (earnings && i == 1) {
            return GestureDetector(
                onTap: () => Get.toNamed("/bank-details"),
                child: const _AddBankContainer());
          }
          if ((controller.business.value && !competition && i == 0) ||
              (!controller.business.value && i == 0)) {
            return Container(
                margin: const EdgeInsets.only(bottom: 7.5),
                child: const SearchBar(topSize: 15));
          }
          return Notification(
              competition: competition, applied: !(i == 2), earnings: earnings);
        });
  }
}

class _AddBankContainer extends StatelessWidget {
  const _AddBankContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        width: double.infinity,
        // height: 83,
        decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            border: Border.all(color: const Color(0xffDCDBDB)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/icons/bank.svg"),
            const SizedBox(width: 11),
            SizedBox(
              width: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeadingText(text: "Bank Details"),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text(
                        "This account is used to facilitate all your deposits and withdrawals",
                        style:
                            TextStyle(color: Color(0xff949292), fontSize: 12)),
                  )
                ],
              ),
            ),
            const Spacer(),
            Text("Add Bank",
                style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))
          ],
        ));
  }
}

class _TotalEarning extends StatelessWidget {
  const _TotalEarning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.5),
        width: double.infinity,
        height: 83,
        decoration: BoxDecoration(
            gradient: const RadialGradient(
                colors: [Color(0xffDBECEC), Color(0xff31A1A2)],
                focalRadius: 50,
                radius: 5,
                center: Alignment.topCenter),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).focusColor.withOpacity(0.7),
                  Theme.of(context).focusColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.5, 0.2],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Total Earned",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )),
                    Text("₹5,450.00",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        )),
                  ]),
              Container(
                height: 41,
                width: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(63, 222, 224, 0.2),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(-3, -3)),
                      BoxShadow(
                          color: Color.fromRGBO(31, 110, 110, 0.5),
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(3, 3)),
                    ],
                    color: Theme.of(context).focusColor.withOpacity(0.6)),
                child: const Text(
                  'Withdraw',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ));
  }
}

class Notification extends StatelessWidget {
  Notification(
      {Key? key,
      this.competition = false,
      this.earnings = false,
      this.applied = true,
      this.showClose = true})
      : super(key: key);

  final bool competition;
  final bool earnings;
  final bool applied;
  final bool showClose;

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        (controller.business.value)
            ? GestureDetector(
                onTap: () {
                  Get.toNamed("/apply-details");
                },
                child: Container(
                  margin: (controller.business.value)
                      ? const EdgeInsets.symmetric(
                          vertical: 7.5, horizontal: 18)
                      : null,
                  padding: (controller.business.value)
                      ? const EdgeInsets.all(1)
                      : null,
                  // height: earnings ? 169 : 159,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffEBF9F9),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: (controller.business.value)
                            ? null
                            : const EdgeInsets.symmetric(
                                vertical: 7.5, horizontal: 18),
                        // height: 121,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFAFAFA),
                            border: (controller.business.value)
                                ? null
                                : Border.all(color: const Color(0xffDBD9D9))),
                        child: Column(children: [
                          NotifTitle(
                            showClose: !controller.business.value,
                            title: (controller.business.value)
                                ? "Course on Guitar"
                                : null,
                            subtitle: (controller.business.value)
                                ? "By Bishen"
                                : null,
                          ),
                          const SizedBox(height: 15),
                          _NotifDetail(),
                        ]),
                      ),
                      SizedBox(height: (earnings) ? 10 : 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: (earnings)
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            (earnings)
                                ? Text("Total Earned",
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))
                                : SvgPicture.asset(
                                    "assets/icons/video-circle.svg"),
                            const SizedBox(width: 4),
                            (earnings)
                                ? Text("₹1,000.00",
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))
                                : Text("Continue",
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700))
                          ],
                        ),
                      ),
                      SizedBox(height: (earnings) ? 10 : 8),
                    ],
                  ),
                ),
              )
            : Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
                // height: 121,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFAFAFA),
                    border: Border.all(color: const Color(0xffDBD9D9))),
                child: Column(children: [
                  NotifTitle(
                    showClose: showClose,
                  ),
                  const SizedBox(height: 15),
                  _NotifDetail(),
                  if (!competition) const SizedBox(height: 15),
                  if (!competition && showClose) _NotifButtons()
                ]),
              ),
        if (!controller.business.value && competition)
          _CustomClip(applied: applied)
      ],
    );
  }
}

class _CustomClip extends StatelessWidget {
  const _CustomClip({
    Key? key,
    required this.applied,
  }) : super(key: key);

  final bool applied;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 20,
        right: 14,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                width: (applied) ? 70 : 93,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: (applied)
                        ? const Color(0xff07864B)
                        : const Color(0xffDAA400),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                child: Text((applied) ? "Applied" : "Expires Soon",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))),
            Positioned(
                right: 0,
                bottom: -8,
                child: SvgPicture.asset(
                    "assets/icons/${(applied) ? "green" : "yellow"}-triangle.svg"))
          ],
        ));
  }
}

class _NotifButtons extends StatelessWidget {
  _NotifButtons({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.pages[2] = ApplyOfferScreen();
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).focusColor),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/edit.svg"),
                  const SizedBox(width: 5),
                  Text("Edit",
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700))
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            controller.pages[2] = ViewOfferScreen();
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).focusColor),
              child: const Text("Review Offers (23)",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700))),
        ),
      ],
    );
  }
}

class _NotifDetail extends StatelessWidget {
  _NotifDetail({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!controller.business.value)
          Container(
              alignment: Alignment.center,
              width: 36,
              height: 36,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset("assets/icons/location.svg")),
        if (controller.business.value)
          const Text("Ratings",
              style: TextStyle(fontSize: 14, color: Color(0xff292D32))),
        SizedBox(width: (controller.business.value) ? 8 : 12),
        if (controller.business.value)
          SvgPicture.asset("assets/icons/star.svg"),
        if (controller.business.value) const SizedBox(width: 3),
        if (controller.business.value)
          const Text("4.2",
              style: TextStyle(fontSize: 14, color: Color(0xffFEC90C))),
        if (!controller.business.value)
          const Text("Mysore",
              style: TextStyle(fontSize: 14, color: Color(0xff292D32))),
        const Spacer(),
        const Text("Category",
            style: TextStyle(fontSize: 14, color: Color(0xff292D32))),
        const SizedBox(width: 10),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
            decoration: BoxDecoration(
                color: const Color(0xffF1F1F3),
                borderRadius: BorderRadius.circular(51)),
            child: const Text(
              "Singing",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff949292)),
            ))
      ],
    );
  }
}

class NotifTitle extends StatelessWidget {
  NotifTitle({Key? key, required this.showClose, this.title, this.subtitle})
      : super(key: key);

  final bool showClose;
  final String? title;
  final String? subtitle;
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/images/vertical-image.png",
                  width: (controller.business.value) ? 40 : 56,
                  height: (controller.business.value) ? 40 : 55,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? "Wanted Song Composer",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff252529),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle ?? "MESH Studio",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff949292)))
              ],
            )
          ],
        ),
        if (showClose)
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Icon(
              Icons.close,
              size: 10,
            ),
          )
      ],
    );
  }
}
