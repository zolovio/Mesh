import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

// import 'package:mesh/screens/home_screens/home_tab/notification_tabs/notification_content.dart';
// import 'package:mesh/screens/home_screens/home_tab/user_tab.dart';
// import 'package:mesh/screens/home_screens/home_tab/user_tabs/portfolio/portfolio.dart';
import 'package:mesh/screens/view_offer_screen.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/icon_button.dart';

import '../feature/home_screens/controllers/home_controller.dart';
import '../feature/home_screens/home_tab/notification_tabs/notification_content.dart';
import '../feature/home_screens/home_tab/user_tab.dart';

class MoreApplyDetailsScreen extends StatefulWidget {
  const MoreApplyDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MoreApplyDetailsScreen> createState() => _MoreApplyDetailsScreenState();
}

class _MoreApplyDetailsScreenState extends State<MoreApplyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();

  final description = TextEditingController();
  final link = TextEditingController();

  var value = "Music and Video";

  var selected = "0";

  var update = false;
  var errorTitle = false;
  var errorLocation = false;
  var errorLink = false;

  final location = TextEditingController();

  final date = "22/09/21";
  final controller = Get.find<HomeController>();

  final List<String> category = [
    "Music and Video",
    "Writing and Translation",
    "Boxing Sport",
    "Music and Video",
    "Reading and Writing",
    "Sketching and Painting",
    "Music and Video",
    "Writing and Translation",
    "Art and Craft"
  ];

  showModal(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return _ChooseCategoryModal(category: category, selected: selected);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: _MoreApplyDetailsAppBar(),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
              child: NotifTitle(
                showClose: false,
                title: "MESH Studio",
                subtitle: "Posted on 20th July",
              )),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 6, bottom: 10),
                        child: HeadingText(
                          text: (controller.business.value)
                              ? "Add a Course Title"
                              : "Add a Title",
                        )),
                    CustomTextField(
                        controller: title,
                        hintText: "Max 200 characters",
                        maxLength: 200,
                        errorText: errorTitle,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter title";
                          }
                          if (!RegExp('[a-zA-Z0-9]').hasMatch(val)) {
                            setState(() {
                              errorTitle = true;
                            });
                            return "Please enter a valid title";
                          }
                          setState(() {
                            errorTitle = false;
                          });
                        }),
                    Container(
                        margin: const EdgeInsets.only(left: 6, bottom: 10),
                        child: HeadingText(
                          text: (controller.business.value)
                              ? "Add a Course Description"
                              : "Add a Description",
                        )),
                    CustomTextField(
                      controller: description,
                      hintText: "Max 300 characters",
                      maxLength: 300,
                      validator: RequiredValidator(
                          errorText: "Please add description"),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 6, bottom: 10),
                        child: const HeadingText(
                          text: "Choose a Category",
                        )),
                    GestureDetector(
                      onTap: () {
                        showModal(context);
                        setState(() {
                          update = true;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xffE3E3E3))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).focusColor),
                              ),
                              SvgPicture.asset("assets/icons/add-circle.svg")
                            ],
                          )),
                    ),
                    if (controller.business.value)
                      Container(
                          margin: const EdgeInsets.only(left: 6, bottom: 10),
                          child:
                              const HeadingText(text: "Add a Course preview")),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          dashPattern: const [4, 4],
                          color: const Color(0xffC1BEC6),
                          child: Container(
                            // padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            height: 90,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8),
                            //     border:
                            //         Border.all(color: const Color(0xffE3E3E3))),
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/icons/media-download.svg"),
                                  const SizedBox(width: 8),
                                  Text("Select Media Files",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor,
                                          fontSize: 14)),
                                ]),
                          )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 6, bottom: 10),
                        child: HeadingText(
                          text: (controller.business.value)
                              ? "Course Price"
                              : "Location",
                        )),
                    CustomTextField(
                      controller: location,
                      hintText: (controller.business.value)
                          ? "₹0.00"
                          : "Enter a location",
                      multiline: false,
                      errorText: errorLocation,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter title";
                        }
                        if (!RegExp('[a-zA-Z0-9]').hasMatch(val)) {
                          setState(() {
                            errorLocation = true;
                          });
                          return "Please enter a valid location";
                        }
                        setState(() {
                          errorLocation = false;
                        });
                      },
                    ),
                    if (controller.business.value)
                      Container(
                          margin: const EdgeInsets.only(left: 6, bottom: 10),
                          child: const HeadingText(text: "Add a Course Link")),
                    if (controller.business.value)
                      CustomTextField(
                        controller: link,
                        hintText: "Attach A Link",
                        multiline: false,
                        errorText: errorLink,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Link";
                          }
                          if (!GetUtils.isURL(value)) {
                            setState(() {
                              errorLink = true;
                            });
                            return "Please enter a valid location";
                          }
                          setState(() {
                            errorLink = false;
                          });
                        },
                      ),
                    if (!controller.business.value)
                      Container(
                          margin: const EdgeInsets.only(left: 6, bottom: 10),
                          child: const HeadingText(
                            text: "Apply Before",
                          )),
                    if (!controller.business.value)
                      Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xffE3E3E3))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                date,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).focusColor),
                              ),
                              SvgPicture.asset("assets/icons/note-text.svg")
                            ],
                          )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          CustomButton(
              margin: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: (controller.business.value) ? 20 : 24),
              textSize: 16,
              height: 59,
              fontWeight: FontWeight.w600,
              borderRadius: 8,
              primaryColor: Theme.of(context).focusColor,
              buttonText: (controller.business.value)
                  ? "Create"
                  : (update)
                      ? "Update"
                      : "Post",
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
                // Get.toNamed("/more-apply-details");
              })
        ],
      ),
    );
  }
}

class _ChooseCategoryModal extends StatefulWidget {
  _ChooseCategoryModal({
    Key? key,
    required this.category,
    required this.selected,
  }) : super(key: key);

  final List<String> category;
  String selected;

  @override
  State<_ChooseCategoryModal> createState() => _ChooseCategoryModalState();
}

class _ChooseCategoryModalState extends State<_ChooseCategoryModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose a Category",
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
            for (int i = 0; i < widget.category.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selected = i.toString();
                  });
                },
                child: Container(
                  width: 327,
                  height: (widget.selected == i.toString()) ? 55 : null,
                  margin: EdgeInsets.only(top: (i == 0) ? 5 : 8, bottom: 6),
                  padding: (widget.selected == i.toString())
                      ? const EdgeInsets.symmetric(
                          horizontal: 18,
                        )
                      : null,
                  decoration: BoxDecoration(
                      color: (widget.selected == i.toString())
                          ? const Color(0xffEBF9F9)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: (widget.selected == i.toString())
                              ? Theme.of(context).focusColor
                              : Colors.transparent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.category[i],
                          style: TextStyle(
                              fontSize: 18,
                              color: (widget.selected == i.toString())
                                  ? Theme.of(context).focusColor
                                  : const Color(0xffA5A5A5))),
                      if (widget.selected == i.toString())
                        Radio(
                            activeColor: Theme.of(context).focusColor,
                            splashRadius: 9,
                            value: i.toString(),
                            focusColor: Theme.of(context).focusColor,
                            groupValue: widget.selected,
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

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.borderColor,
      this.validator,
      this.textStyle,
      this.errorText = false,
      this.multiline = true,
      this.maxLength})
      : super(key: key);

  final TextEditingController controller;
  final Color? borderColor;
  final String hintText;
  final bool multiline;
  final TextStyle? textStyle;
  final int? maxLength;
  final bool errorText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 30,
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: (multiline) ? TextInputType.multiline : null,
          maxLines: (multiline) ? null : 1,
          maxLength: maxLength,
          style: textStyle ??
              TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: (errorText)
                      ? const Color(0xffEB5757)
                      : Theme.of(context).focusColor),
          decoration: InputDecoration(
              hintText: hintText,
              counterText: "",
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffEB5757))),
              errorStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffEB5757)),
              labelStyle:
                  const TextStyle(fontSize: 16, color: Color(0xff252529)),
              hintStyle:
                  const TextStyle(fontSize: 16, color: Color(0xff9D9D9D)),
              contentPadding: const EdgeInsets.all(16),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffEB5757))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: borderColor ?? const Color(0xffE3E3E3))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffE3E3E3))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: borderColor ?? const Color(0xffE3E3E3))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: borderColor ?? const Color(0xffE3E3E3)))),
        ));
  }
}

class _MoreApplyDetailsAppBar extends StatelessWidget {
  _MoreApplyDetailsAppBar({
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
              Get.back();
            },
            image: "assets/images/back.png",
            fillColor: Colors.white70,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
            child: Text((controller.business.value) ? "Back" : "Apply Now",
                style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
