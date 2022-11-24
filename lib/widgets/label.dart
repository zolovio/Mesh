import 'package:flutter/material.dart';

// class InputFieldText extends StatelessWidget {
//   final String text;
//   // final AlignmentGeometry? alignment;
//   // final TextAlign? textAlign;
//   // final TextStyle? style;
//   const InputFieldText({
//     Key? key,
//     required this.text,
//     // this.alignment,
//     // this.textAlign,
//     // this.style,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       margin: const EdgeInsets.only(top: 20, bottom: 10),
//       child: Text(
//         text,
//         style: Theme.of(context)
//             .textTheme
//             .bodySmall!
//             .copyWith(fontSize: 13, color: Theme.of(context).hintColor),
//         // textAlign: textAlign,
//       ),
//     );
//   }
// }

// class Subtitle extends StatelessWidget {
//   final String text;

//   final TextStyle? style;
//   const Subtitle({
//     Key? key,
//     required this.text,
//     this.style,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       margin: const EdgeInsets.only(bottom: 15),
//       child: Text(
//         text,
//         style: style ??
//             Theme.of(context)
//                 .textTheme
//                 .labelSmall!
//                 .copyWith(letterSpacing: 0.7, fontSize: 11, height: 1.7),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class Heading extends StatelessWidget {
//   final String text;
//   const Heading({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.only(top: 15, bottom: 3),
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.titleLarge!.copyWith(
//             fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1),
//       ),
//     );
//   }
// }

// class TopImage extends StatelessWidget {
//   const TopImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       'assets/images/doctor.png',
//       width: double.infinity,
//       fit: BoxFit.cover,
//     );
//   }
// }

// // class CommunityTitle extends StatelessWidget {
// //   final bool showIcon;
// //   final bool edit;
// //   final FontWeight? fontWeight;
// //   final double? fontSize;
// //   final bool interfont;
// //   const CommunityTitle(
// //       {Key? key,
// //       required this.title,
// //       this.showIcon = true,
// //       this.edit = false,
// //       this.fontWeight,
// //       this.fontSize,
// //       this.interfont = true})
// //       : super(key: key);

// //   final String title;

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     return Row(
// //       children: [
// //         Container(
// //             margin: EdgeInsets.only(left: screenWidth * 0.05),
// //             child: Text(title,
// //                 style: TextStyle(
// //                     fontFamily: (interfont) ? "Inter" : null,
// //                     fontWeight: fontWeight ?? FontWeight.bold,
// //                     fontSize: fontSize ?? 14,
// //                     letterSpacing: 1,
// //                     color: Theme.of(context).hintColor.withOpacity(0.9)))),
// //         const Spacer(),
// //         if (showIcon)
// //           Container(
// //             margin: EdgeInsets.only(right: screenWidth * 0.05),
// //             child: (edit)
// //                 ? Image.asset("assets/images/edit.png", color: Colors.black)
// //                 : Icon(FontAwesomeIcons.angleRight,
// //                     color: Theme.of(context).hintColor.withOpacity(0.8),
// //                     size: 20),
// //           )
// //       ],
// //     );
// //   }
// // }

// class HeadingTitle extends StatelessWidget {
//   final String title;
//   const HeadingTitle({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12, top: 20),
//         child: Text(title,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium!
//                 .copyWith(color: Colors.black, fontWeight: FontWeight.bold)));
//   }
// }

class CustomRichText extends StatelessWidget {
  final double? fontSize;
  final Color? color;
  final String? fontFamily;
  final double? height;
  final String? text;
  final String? user;
  final String? hashtag;
  const CustomRichText(
      {Key? key,
      this.fontSize,
      this.color,
      this.fontFamily,
      this.height,
      this.user,
      this.hashtag,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize ?? 16.0,
          wordSpacing: 3,
          height: height,
          color: color ?? const Color(0xff615858),
        ),
        children: <TextSpan>[
          if (user != null)
            TextSpan(
                text: user,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff252529))),
          TextSpan(
              text: (text != null)
                  ? ((text!.length <= 70) ? text : text!.substring(0, 70))
                  : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam porta tellus vitae diam mollis netus in a. Enim, Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: TextStyle(fontFamily: fontFamily, height: height)),
        ],
      ),
    );
  }
}

class UnderLinedText extends StatelessWidget {
  const UnderLinedText({Key? key, required this.text, this.italics = true})
      : super(key: key);

  final String text;
  final bool italics;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              color: const Color(0xffF7D86C),
            )),
        Text(text,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontFamily: (!italics) ? "Manrope" : null,
                fontStyle: (italics) ? FontStyle.italic : null,
                color: const Color(0xff252529))),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 13),
        child: const Divider());
  }
}

// class BlackText extends StatelessWidget {
//   final String text;
//   final bool bold;
//   final double fontSize;
//   const BlackText(
//       {Key? key, required this.text, required this.fontSize, this.bold = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(text,
//         style: TextStyle(
//             fontSize: fontSize,
//             fontWeight: bold ? FontWeight.bold : FontWeight.normal));
//   }
// }

// class LightBlackText extends StatelessWidget {
//   final String title;
//   const LightBlackText({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: TextStyle(
//           height: 1.5,
//           fontSize: 13,
//           color: Colors.black.withOpacity(0.7),
//           fontWeight: FontWeight.w400),
//       textAlign: TextAlign.center,
//     );
//   }
// }

// class CustomDivider extends StatelessWidget {
//   const CustomDivider({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         child: const Divider());
//   }
// }

// class ErrorDialogBox extends StatelessWidget {
//   const ErrorDialogBox({
//     Key? key,
//     required this.body,
//   }) : super(key: key);

//   final Map<String, dynamic> body;

//   @override
//   Widget build(BuildContext context) {
//     // print(body["errors"][0]["message"]);
//     return AlertDialog(
//       content: SizedBox(
//           child: Text(
//         "The error is ${body["errors"][0]["message"] as String}",
//         // maxLines: null,
//       )),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Close", style: TextStyle(color: Colors.purple)))
//       ],
//     );
//   }
// }

// // class SocialDialogBox extends StatelessWidget {
// //   SocialDialogBox({Key? key, required this.text, required this.controller})
// //       : super(key: key);

// //   final String text;
// //   final TextEditingController controller;

// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     // print(body["errors"][0]["message"]);
// //     return AlertDialog(
// //       shape: const RoundedRectangleBorder(
// //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
// //       contentPadding: const EdgeInsets.all(5.0),

// //       content: Container(
// //           height: 224,
// //           width: 273,
// //           padding: const EdgeInsets.all(10),
// //           color: Colors.white,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 // crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text("Links",
// //                       style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontFamily: 'TT Norms Pro',
// //                           fontSize: 16,
// //                           color: Color(0xff243448))),
// //                   const Spacer(),
// //                   GestureDetector(
// //                       onTap: () {
// //                         Navigator.pop(context);
// //                       },
// //                       child: const Icon(Icons.close, size: 15))
// //                 ],
// //               ),
// //               const SizedBox(height: 8),
// //               Container(
// //                 margin: const EdgeInsets.only(right: 50),
// //                 child: Text("Add a link that will appear on your profile",
// //                     style: TextStyle(
// //                         fontSize: 12,
// //                         letterSpacing: 0.9,
// //                         color: const Color(0xff7E8A98).withOpacity(0.78))),
// //               ),
// //               const Divider(),
// //               const SizedBox(height: 5),
// //               Padding(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
// //                 child: Row(
// //                   children: [
// //                     Text(text,
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontFamily: 'TT Norms Pro',
// //                             fontSize: 16,
// //                             color: Color(0xff243448))),
// //                     const Spacer(),
// //                     const Icon(Icons.keyboard_arrow_down, size: 20)
// //                   ],
// //                 ),
// //               ),
// //               Form(
// //                 key: _formKey,
// //                 child: CustomTextFormField(
// //                     controller: controller,
// //                     // contentPadding: Edge
// //                     borderColor: Colors.black.withOpacity(0.12),
// //                     height: 35,
// //                     borderRadius: 4,
// //                     maxLines: 1,
// //                     // style: TextStyle(fontSize: 11),
// //                     validator: RequiredValidator(errorText: "Add link"),
// //                     hintText: "Add link"),
// //               ),
// //               const SizedBox(height: 7),
// //               CustomButton(
// //                   buttonText: "+ Add",
// //                   height: 36,
// //                   borderRadius: 4,
// //                   margin: const EdgeInsets.all(0),
// //                   onPressed: () {
// //                     if (_formKey.currentState!.validate()) {
// //                       Navigator.pop(context);
// //                     }
// //                   })
// //             ],
// //           )),
// //       // actions: [
// //       //   TextButton(
// //       //       onPressed: () {
// //       //         Navigator.pop(context);
// //       //       },
// //       //       child: const Text("Close", style: TextStyle(color: Colors.purple)))
// //       // ],
// //     );
// //   }
// // }
