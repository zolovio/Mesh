import 'package:flutter/material.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';
import 'package:mesh/widgets/icon_button.dart';
import 'package:mesh/widgets/label.dart';

class PostDate extends StatelessWidget {
  const PostDate(
      {Key? key,
      required this.screenWidth,
      required,
      this.startDate,
      this.endDate})
      : super(key: key);

  final double screenWidth;
  final String? startDate;
  final String? endDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 25.0),
        child: Row(
          children: [
            Image.asset("assets/images/post-calendar.png",
                height: 15, width: 15, fit: BoxFit.contain),
            SizedBox(width: screenWidth * 0.015),
            Text(startDate ?? "26 May 2022",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).focusColor)),
            SizedBox(width: screenWidth * 0.015),
            Text("to",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).indicatorColor, fontSize: 10)),
            SizedBox(width: screenWidth * 0.015),
            Text(endDate ?? "28 May 2022",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).focusColor)),
          ],
        ));
  }
}

class PostCaption extends StatelessWidget {
  const PostCaption({
    Key? key,
    this.user,
    required this.text,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;
  final String? user;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 13.0, right: 13, top: 10, bottom: 10),
      child: SizedBox(
        width: screenWidth * 0.85,
        // padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              user: user,
              text: text,
            ),
            const SizedBox(height: 5),
            Text("#Gameon #Reels #2022 #Mesh2022",
                style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}

class PostLikes extends StatelessWidget {
  const PostLikes({
    Key? key,
    required this.likes,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;
  final String likes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
      child: Row(
        children: [
          // Container(
          //   height: 13.0,
          //   width: 13.0,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: NetworkImage(
          //             "https://images.unsplash.com/photo-1582610285985-a42d9193f2fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fHdvbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80")),
          //   ),
          // ),
          SizedBox(width: screenWidth * 0.015),
          RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.titleSmall,
                children: <TextSpan>[
                  TextSpan(
                    text: likes,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 9),
                  ),
                  const TextSpan(
                    text: " other liked it",
                    style: TextStyle(fontSize: 9),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class PostTitle extends StatelessWidget {
  const PostTitle({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   height: 48.0,
              //   width: 48.0,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(
              //             "https://images.unsplash.com/photo-1582610285985-a42d9193f2fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fHdvbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80")),
              //   ),
              // ),
              const GradientOvalImage(
                imageSize: 48,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Harley James",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff252529),
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text("30 Minutes",
                      style: TextStyle(fontSize: 14, color: Color(0xff949292)))
                ],
              )
            ],
          ),
          AppBarIconButton(image: "assets/images/more.png", onTap: () {})
        ],
      ),
    );
  }
}
