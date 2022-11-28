import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../configs/app_router.dart';
import '../../../main.dart';
import '../../../widgets/background_gradient.dart';
import '../../../widgets/button.dart';
import '../../../widgets/icon_button.dart';
import '../../../widgets/label.dart';
import '../controllers/skill_controller.dart';

// class Skill {
//   final String text;
//   final String image;
//   final bool selected;

//   Skill({required this.text, required this.image, required this.selected});
// }

class SelectSkillScreen extends StatefulWidget {
  const SelectSkillScreen({Key? key}) : super(key: key);

  @override
  State<SelectSkillScreen> createState() => _SelectSkillScreenState();
}

class _SelectSkillScreenState extends State<SelectSkillScreen> {
  // List<Skill> skills = [
  //   Skill(
  //       text: "Photography", image: "assets/icons/camera.svg", selected: false),
  //   Skill(
  //       text: "Travelling",
  //       image: "assets/icons/airplane.svg",
  //       selected: false),
  //   Skill(
  //       text: "Cooking",
  //       image: "assets/icons/cooking-pot.svg",
  //       selected: false),
  //   Skill(text: "Running", image: "assets/icons/shoe.svg", selected: false),
  //   Skill(
  //       text: "Art And Craft", image: "assets/icons/art.svg", selected: false),
  //   Skill(text: "Drinking", image: "assets/icons/drink.svg", selected: false),
  //   Skill(text: "Music", image: "assets/icons/music.svg", selected: false),
  //   Skill(text: "Video Games", image: "assets/icons/game.svg", selected: false),
  //   Skill(text: "Reading", image: "assets/icons/book.svg", selected: false),
  //   Skill(
  //       text: "Sports", image: "assets/icons/basketball.svg", selected: false),
  // ];

  final SkillsController skillscontroller = Get.put(SkillsController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        const BackgroundGradient(),
        Center(
          child: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              children: [
                const SizedBox(height: 45),
                Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      AppBarIconButton(
                        image: "assets/images/back.png",
                        onTap: () {
                          ///Get.back();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await const FlutterSecureStorage().deleteAll();
                          FirebaseAuth.instance.signOut();
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(
                              AppRouter.loginScreen, (route) => false);
                        },
                        icon: const Icon(Icons.exit_to_app),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const UnderLinedText(text: "Complete"),
                    const SizedBox(width: 5),
                    Text("your profile",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.85,
                    child: Text("Select skills that you posses",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Obx(() {
                            return skillscontroller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.teal,
                                    ),
                                  )
                                : skillscontroller.skillsList.isEmpty
                                    ? Center(
                                        child: Text('no skills available'),
                                      )
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            skillscontroller.skillsList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 1.7,
                                                crossAxisSpacing: 4.0,
                                                mainAxisSpacing: 4.0),
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                            onTap: () {
                                              // setState(() {
                                              //   skills[i] = Skill(
                                              //       text: skills[i].text,
                                              //       image: skills[i].image,
                                              //       selected: !skills[i].selected);
                                              // });
                                              !skillscontroller
                                                      .skillsList[i].selected
                                                  ? skillscontroller
                                                      .selectedskillsList
                                                      .add(skillscontroller
                                                          .skillsList[i].id)
                                                  : skillscontroller
                                                      .selectedskillsList
                                                      .remove(skillscontroller
                                                          .skillsList[i].id);
                                              skillscontroller
                                                      .skillsList[i].selected =
                                                  !skillscontroller
                                                      .skillsList[i].selected;
                                              // print(skillscontroller
                                              //     .selectedskillsList);
                                              setState(() {});
                                            },
                                            child: SizedBox(
                                              width: 140,
                                              height: 68,
                                              child: Card(
                                                  elevation: (skillscontroller
                                                          .skillsList[i]
                                                          .selected)
                                                      ? 7
                                                      : 0,
                                                  shadowColor: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.5),
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      side: (!skillscontroller
                                                              .skillsList[i]
                                                              .selected)
                                                          ? BorderSide(
                                                              color: const Color(
                                                                      0xff97D3D3)
                                                                  .withOpacity(
                                                                      0.2))
                                                          : BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Container(
                                                    decoration:
                                                        (skillscontroller
                                                                .skillsList[i]
                                                                .selected)
                                                            ? BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Theme.of(
                                                                            context)
                                                                        .focusColor,
                                                                    const Color
                                                                            .fromRGBO(
                                                                        47,
                                                                        166,
                                                                        167,
                                                                        0.45)
                                                                  ],
                                                                  begin: Alignment
                                                                      .topRight,
                                                                  end: Alignment
                                                                      .bottomLeft,
                                                                  stops: const [
                                                                    0.4,
                                                                    0.2
                                                                  ],
                                                                  tileMode:
                                                                      TileMode
                                                                          .clamp,
                                                                ),
                                                              )
                                                            : null,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor: (skillscontroller
                                                                    .skillsList[
                                                                        i]
                                                                    .selected)
                                                                ? Theme.of(
                                                                        context)
                                                                    .focusColor
                                                                : const Color(
                                                                        0xff2FA6A7)
                                                                    .withOpacity(
                                                                        0.1),
                                                            foregroundImage:
                                                                NetworkImage(
                                                                    'https://mesh.kodagu.today/assets/${skillscontroller.skillsList[i].icon}'),
                                                            // Icon(
                                                            //    IconData(),
                                                            //     color: (skills[i]
                                                            //             .selected)
                                                            //         ? Colors.white
                                                            //         : Theme.of(context)
                                                            //             .focusColor),
                                                          ),
                                                          Text(
                                                              skillscontroller
                                                                  .skillsList[i]
                                                                  .title
                                                                  .toString(),
                                                              style: (skillscontroller
                                                                      .skillsList[
                                                                          i]
                                                                      .selected)
                                                                  ? Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .white)
                                                                  : Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium)
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        });
                          }),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: skillscontroller.isSaving.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      margin: const EdgeInsets.all(0),
                                      textSize: 16,
                                      height: 59,
                                      fontWeight: FontWeight.w600,
                                      borderRadius: 8,
                                      primaryColor:
                                          Theme.of(context).focusColor,
                                      buttonText: "Continue",
                                      onPressed: () {
                                        // skillscontroller.fetchSkills();
                                        // navigatorKey.currentState
                                        //     ?.pushNamed(AppRouter.prepareScreen);
                                        skillscontroller.updateSkills(
                                            userid:
                                                '634a4d8b-e71a-493d-bbed-eadb98da3f54');
                                        // Get.toNamed("/login");
                                        // Get.toNamed("/home");
                                        // Get.toNamed("/error");
                                        ///Get.toNamed("/prepare");
                                        ///
                                      }),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
