import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/home_controller.dart';
import 'package:mesh/feature/home_screens/home_tab/notification_tabs/notification_content.dart';
import 'package:mesh/screens/more_apply_details_screen.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/icon_button.dart';

class ApplyDetailsScreen extends StatelessWidget {
  static String routeName = "/apply-details";
  ApplyDetailsScreen({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: _ApplyDetailsAppBar(),
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
                child: NotifTitle(
                  showClose: false,
                  title: (controller.business.value) ? "Creator - bishen Ponnanna" : "MESH Studio",
                  subtitle: "Posted on 20th July",
                )),
            const SizedBox(height: 15),
            if (controller.business.value) const _CoursePrice(),
            (controller.business.value) ? const _CourseDetails() : const _ApplyDetails(),
            _ApplyDescriptionReview(),
            if (controller.business.value) const _CoursePreview(),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      textSize: 16,
                      height: 59,
                      fontWeight: FontWeight.w600,
                      borderRadius: 8,
                      primaryColor: Theme.of(context).focusColor,
                      buttonText: (controller.business.value) ? "Enroll Now" : "Apply Now",
                      onPressed: () {
                        Navigator.pushNamed(context, MoreApplyDetailsScreen.routeName);
                        // Get.toNamed("/more-apply-details");
                      })),
            )
          ],
        ));
  }
}

class _CourseDetails extends StatelessWidget {
  const _CourseDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Description(
              title: "Course Title",
              subtitle: "Course on Guitar",
            ),
            const Spacer(),
            Description(
              title: "Category",
              subtitle: "Music",
            ),
          ],
        ));
  }
}

class _CoursePreview extends StatelessWidget {
  const _CoursePreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Course Preview",
            style: TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/vertical-image.png",
                        height: 104,
                        width: 103,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (i == 0)
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: const Color(0xffC9C9C9).withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                            width: 34,
                            height: 16,
                            child: const Text("01:34", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white))),
                      )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}

class _CoursePrice extends StatelessWidget {
  const _CoursePrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Course Price",
              style: TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
            ),
            Text(
              "₹ 499.0",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff252529)),
            ),
          ],
        ));
  }
}

class _ApplyDescriptionReview extends StatelessWidget {
  _ApplyDescriptionReview({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Description",
            style: TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
          ),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.5,
                  color: Color(0xff292D32),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (controller.business.value)
                        ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad.."
                        : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore... ",
                  ),
                  TextSpan(text: "read more", style: TextStyle(color: Theme.of(context).focusColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplyDetails extends StatelessWidget {
  const _ApplyDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Description(
                  title: "Apply Before",
                  subtitle: "30, July 2021",
                ),
                const SizedBox(width: 50),
                Description(
                  title: "Location",
                  subtitle: "Mysore",
                ),
              ],
            ),
            const SizedBox(height: 24),
            Description(title: "Category", subtitle: "Music")
          ],
        ));
  }
}

class Description extends StatelessWidget {
  Description({Key? key, required this.title, required this.subtitle}) : super(key: key);

  final String title;
  final String subtitle;

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
        ),
        SizedBox(height: (controller.business.value) ? 6 : 12),
        Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xff252529)),
        ),
      ],
    );
  }
}

class _ApplyDetailsAppBar extends StatelessWidget {
  _ApplyDetailsAppBar({
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
            child: Text(
              (controller.business.value) ? "Back" : "Details",
              style: const TextStyle(fontSize: 20, color: Color(0xff252529), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
