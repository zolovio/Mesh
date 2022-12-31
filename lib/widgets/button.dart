import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/controllers/profile_controller.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? primaryColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.width,
      this.margin,
      this.fontWeight,
      this.padding,
      this.textSize,
      this.borderRadius,
      this.borderColor,
      this.shadowColor,
      this.primaryColor,
      this.textColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? const EdgeInsets.only(top: 25, bottom: 18),
        // alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: padding,
              primary: primaryColor ?? Theme.of(context).focusColor,
              shadowColor: shadowColor,
              alignment: Alignment.center,
              side: BorderSide(color: borderColor ?? Colors.transparent, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
              )),
          child: Text(buttonText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor ?? Colors.white, fontSize: textSize, fontWeight: fontWeight)),
        ));
  }
}

class CancelOrSave extends StatelessWidget {
  ProfileController controller = Get.find<ProfileController>();
  final bool video;
  final bool isSocial;

  CancelOrSave({
    Key? key,
    required this.video,
    required this.isSocial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          buttonText: "Cancel",
          onPressed: () {},
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          borderColor: Theme.of(context).focusColor,
          primaryColor: Colors.transparent,
          shadowColor: Colors.transparent,
          borderRadius: 8,
          height: 48,
          width: 144,
          textSize: 16,
          textColor: Theme.of(context).focusColor,
          fontWeight: FontWeight.w600,
        ),
        CustomButton(
          buttonText: "Save",
          onPressed: isSocial
              ? () {
                  print("social");
                  controller.updateUserSocials(
                    facebookURl: "facebookURl",
                    whatsAppURL: "whatsAppURL",
                    twitterURL: "twitterURL",
                    linkedinURL: "linkedinURL",
                  );
                }
              : () {
                  var data = controller.uploadMedia(
                      filepath: video ? controller.videoPath.value : controller.imagePath.value, mediaType: video ? "video" : "image");
                },
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          primaryColor: Theme.of(context).focusColor,
          borderRadius: 8,
          height: 48,
          width: 144,
          textSize: 16,
          textColor: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

// class CustomMaterialButton extends StatelessWidget {
//   final bool twolines;
//   final double? height;
//   final double? width;
//   final void Function()? onPressed;
//   final String text;
//   final String subText;
//   CustomMaterialButton(
//       {this.twolines = true,
//       this.text = "",
//       required this.subText,
//       required this.onPressed,
//       this.height,
//       this.width});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       minWidth: width,
//       height: height,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18.0),
//           side: const BorderSide(color: Color(0xffF0F0F0), width: 1)),
//       padding: const EdgeInsets.all(20),
//       onPressed: onPressed,
//       child: Row(
//         children: [
//           const Icon(
//             Icons.add,
//             color: Color(0xff292D32),
//           ),
//           SizedBox(
//             width: (twolines) ? 15 : 20,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (twolines)
//                 Text(text,
//                     style: kHeaderStyle.copyWith(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 10,
//                         color: Colors.black.withOpacity(0.6))),
//               const SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 subText,
//                 style: kHeaderStyle.copyWith(
//                     color:
//                         twolines ? Colors.black : Colors.black.withOpacity(0.7),
//                     fontWeight: twolines ? FontWeight.w500 : FontWeight.w400,
//                     fontSize: 12),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
