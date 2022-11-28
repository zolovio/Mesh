import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mesh/screens/user_info_screen.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:image_picker/image_picker.dart';

import '../feature/home_screens/controllers/home_controller.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[PostQues(), PostQues(ques: true)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: TabOption(
                          text: "Posts",
                          selectedIndex: _selectedIndex,
                          index: 0,
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: TabOption(
                          text: "Questions",
                          selectedIndex: _selectedIndex,
                          index: 1,
                        ))
                  ],
                )),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            toolbarHeight: 40,
            flexibleSpace: _UploadAppBar()),
        body: _pages.elementAt(_selectedIndex));
  }
}

class _UploadAppBar extends StatelessWidget {
  _UploadAppBar({
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
        padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0, right: 20),
        child: Obx(
          () => Row(
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
                child: Text("Upload",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff252529),
                        fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              if (controller.tags.value)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
                  child: Text("Draft",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        ));
  }
}

class PostQues extends StatefulWidget {
  PostQues({Key? key, this.ques = false}) : super(key: key);
  final bool ques;

  @override
  State<PostQues> createState() => _PostQuesState();
}

class _PostQuesState extends State<PostQues> {
  final caption = TextEditingController();
  final tag = TextEditingController();
  final controller = Get.find<HomeController>();
  XFile? _image;

  final List<String> tagList = ["Dancing", "Trekking"];
  pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        // physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffE3E3E3),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OvalImage(imageSize: 40),
                      const SizedBox(width: 10),
                      Container(
                          // height: 30,
                          width: 258,
                          padding: const EdgeInsets.only(bottom: 15),
                          child: TextField(
                            controller: caption,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff252529)),
                            decoration: const InputDecoration(
                                hintText: "What's Happening?",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Color(0xff252529)),
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Color(0xff9D9D9D)),
                                contentPadding: EdgeInsets.all(0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffDCDBE0))),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffDCDBE0)))),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (!widget.ques)
                    (_image == null)
                        ? GestureDetector(
                            onTap: () => pickImageFromGallery(),
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [4, 4],
                                color: const Color(0xffC1BEC6),
                                child: Container(
                                  width: 312,
                                  height: 99,
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Add Media Files",
                                            style: TextStyle(
                                                color: Color(0xff9D9D9D),
                                                fontSize: 16)),
                                        const SizedBox(width: 10),
                                        SvgPicture.asset(
                                            "assets/icons/download.svg")
                                      ]),
                                )),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(File(_image!.path),
                                    fit: BoxFit.cover, width: 313, height: 210),
                              ),
                              CrossSymbol(
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                              )
                            ],
                          ),
                  if (!widget.ques) const SizedBox(height: 15),
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: const Text("Type Tag to Enter",
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w600,
                  //           color: Color(0xff9D9D9D))),
                  // ),
                  Form(
                    child: TextFormField(
                      controller: tag,
                      // readOnly: controller.tags.value,

                      onFieldSubmitted: (val) {
                        print(tagList);
                        tagList.add(val.toString());
                        tag.clear();
                        setState(() {});
                      },
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xff252529)),
                      decoration: const InputDecoration(
                          hintText: "Type Tag to Enter",
                          labelStyle:
                              TextStyle(fontSize: 14, color: Color(0xff252529)),
                          hintStyle:
                              TextStyle(fontSize: 14, color: Color(0xff9D9D9D)),
                          contentPadding: EdgeInsets.all(0),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffDCDBE0))),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    // height: 61,
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF7F7F7)),
                    child: Wrap(runSpacing: 0, spacing: 0, children: [
                      if (!controller.tags.value)
                        GestureDetector(
                          onTap: () {
                            controller.tags.value = true;
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FollowButton(
                                text: "Add Tags", width: 91, height: 45),
                          ),
                        ),
                      if (controller.tags.value)
                        for (String i in tagList)
                          GestureDetector(
                            onTap: () {
                              // controller.tags.value = false;
                              tagList.remove(i);
                              setState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      i,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Theme.of(context).focusColor),
                                    ),
                                    const SizedBox(width: 3),
                                    Icon(Icons.close,
                                        color: Theme.of(context).focusColor,
                                        size: 12)
                                  ],
                                )),
                          )
                    ]),
                  ),
                  const SizedBox(height: 20)
                ],
              )),
          Expanded(
            child: SizedBox(
                height: (!widget.ques && _image == null) ? 200 : null,
                child: Align(
                    alignment: ((!widget.ques && _image == null))
                        ? Alignment.bottomCenter
                        : Alignment.topCenter,
                    child: (controller.isupLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          )
                        : CustomButton(
                            margin: const EdgeInsets.all(13),
                            textSize: 16,
                            height: 59,
                            fontWeight: FontWeight.w600,
                            borderRadius: 8,
                            primaryColor: (!widget.ques && _image == null ||
                                    widget.ques && !controller.tags.value)
                                ? const Color(0xffC9CBCB)
                                : Theme.of(context).focusColor,
                            buttonText: (!widget.ques && _image == null ||
                                    widget.ques && !controller.tags.value)
                                ? "Post"
                                : "Upload",
                            onPressed: () {
                              controller.UploadPostMedia(
                                filepath: _image!.path,
                                postbody: caption.text.toString(),
                                posttags: tagList,
                                posttype: 'image',
                              );
                            })))),
          ),
        ],
      ),
    );
  }
}
