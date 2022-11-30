import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesh/feature/home_screens/controllers/post_like_controller.dart';
import 'package:mesh/widgets/icon_button.dart';

class BottomTextBar extends StatelessWidget {
  BottomTextBar({Key? key, this.emoji = false, required this.postId})
      : super(key: key);

  final bool emoji;
  final String postId;
  TextEditingController controller = TextEditingController();
  final PostLikeController postLikeController = PostLikeController();

  @override
  Widget build(BuildContext context) {
    print(postId);
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
          border: (emoji)
              ? null
              : const Border(top: BorderSide(color: Color(0xffDCDBDB))),
          color: const Color(0xffF7F7F7)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        // TextField(),
        Container(
          height: 48,
          width: 283,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              postLikeController.textFieldValue.value = value;
            },
            decoration: InputDecoration(
                prefixIcon: (emoji)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/icons/smile.svg",
                            width: 10, height: 10),
                      )
                    : null,
                contentPadding: const EdgeInsets.all(8),
                border: InputBorder.none,
                hintText: 'Write a comment...',
                hintStyle: TextStyle(
                    color: const Color(0xff1B1A57).withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        AppBarIconButton(
          image: "assets/images/send-white.png",
          onTap: () {
            postLikeController.commentOnAPost(
                postLikeController.textFieldValue.value, postId);
          },
          circle: true,
          green: true,
          size: 48,
        )
      ]),
    );
  }
}
