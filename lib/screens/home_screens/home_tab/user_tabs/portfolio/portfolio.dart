import 'package:mesh/widgets/video_player/play_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:mesh/widgets/label.dart';

class Portfolio extends StatefulWidget {
  Portfolio({Key? key, this.edit = false}) : super(key: key);
  final bool edit;
  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  int _selectedIndex = 0;
  final List<String> _tabs = ["Pictures", "Videos", "Social"];
  pages() => <Widget>[
        Pictures(edit: widget.edit),
        Pictures(
          video: true,
          edit: widget.edit,
        ),
        (widget.edit) ? EditSocial() : Social(),
      ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          for (int i = 0; i < _tabs.length; i++)
            Stack(clipBehavior: Clip.none, children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
                child: Text(
                  _tabs[i],
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
                    right: 5,
                    left: 5,
                    child: Container(
                      width: 25,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Theme.of(context).focusColor),
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

class Pictures extends StatelessWidget {
  const Pictures({Key? key, this.video = false, this.edit = false})
      : super(key: key);
  final bool video;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 15,
              runSpacing: 15,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < 9; i++)
                  Stack(
                    children: [
                      (video)
                          ? VideoPlayer()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/vertical-image.png",
                                height: 104,
                                width: 103,
                                fit: BoxFit.cover,
                              ),
                            ),
                      if (edit && !video) CrossSymbol(onTap: () {}),
                    ],
                  )
              ],
            ),
            if (edit) const SizedBox(height: 20),
            if (edit)
              Container(
                width: double.infinity,
                height: 51,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(10)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset("assets/icons/plus-circle.svg"),
                  const SizedBox(width: 10),
                  const Text("Add Media",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff9D9D9D)))
                ]),
              )
          ],
        ));
  }
}

class Link {
  final String svg;
  final void Function()? onTap;
  Link({required this.svg, required this.onTap});
}

class Social extends StatelessWidget {
  Social({Key? key}) : super(key: key);

  final List<Link> links = [
    Link(svg: "facebook", onTap: () {}),
    Link(svg: "whatsapp", onTap: () {}),
    Link(svg: "twitter", onTap: () {}),
    Link(svg: "linkedin", onTap: () {})
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        width: double.infinity,
        alignment: Alignment.center,
        child: Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: links
                .map((e) => Container(
                      alignment: Alignment.center,
                      width: 163,
                      height: 139,
                      decoration: BoxDecoration(
                        color: const Color(0xffEBF9F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          SvgPicture.asset("assets/icons/${e.svg}.svg"),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: e.onTap,
                            child: Container(
                                // alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 19),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).focusColor),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text("Connect",
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))),
                          )
                        ],
                      ),
                    ))
                .toList()));
  }
}

class ControllerSocial {
  final String svg;
  final TextEditingController controller;
  ControllerSocial({required this.svg, required this.controller});
}

class EditSocial extends StatelessWidget {
  EditSocial({Key? key}) : super(key: key);

  List<ControllerSocial> icon = [
    ControllerSocial(svg: "Facebook", controller: TextEditingController()),
    ControllerSocial(svg: "Whatsapp", controller: TextEditingController()),
    ControllerSocial(svg: "Twitter", controller: TextEditingController()),
    ControllerSocial(svg: "Linkedin", controller: TextEditingController())
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: icon
              .map((i) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/${i.svg.toLowerCase()}.svg",
                        width: 32,
                        height: 32,
                        fit: BoxFit.fill,
                        color: const Color(0xffBBBBBB),
                      ),
                      SizedBox(width: (i.svg == "Twitter") ? 13 : 20),
                      SizedBox(
                          // height: 30,
                          width: 280,
                          child: TextField(
                            controller: i.controller,
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xff252529)),
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 8, left: 8),
                                  child: Text("${i.svg}.com/",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                ),
                                hintText: "Your ${i.svg}ID",
                                labelStyle: const TextStyle(
                                    fontSize: 16, color: Color(0xff252529)),
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Color(0xff9D9D9D)),
                                contentPadding: const EdgeInsets.all(8),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffE3E3E3))),
                                disabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffE3E3E3))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffE3E3E3))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xffE3E3E3)))),
                          )),
                    ],
                  )))
              .toList(),
        ));
  }
}
