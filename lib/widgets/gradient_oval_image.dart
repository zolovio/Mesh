import 'package:flutter/material.dart';

class GradientOvalImage extends StatelessWidget {
  final Color? color;
  final double? imageSize;
  final String img;
  const GradientOvalImage({
    Key? key,
    this.color,
    this.imageSize,
    this.img =
        "https://images.unsplash.com/photo-1582610285985-a42d9193f2fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fHdvbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        // gradient: (!seenStory)
        //     ? LinearGradient(colors: [
        //         Theme.of(context).focusColor.withOpacity(0.7),
        //         const Color(0xffD2D7FF),
        //       ])
        //     : null,
        // color: (seenStory) ? Theme.of(context).indicatorColor : null,
        color: color ?? const Color(0xffF7D86C),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Container(
          // margin: const EdgeInsets.all(4),
          width: imageSize ?? 52.0,
          height: imageSize ?? 52.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(this.img)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 0.0),
        ),
      ),
    );
  }
}

class OvalImage extends StatelessWidget {
  const OvalImage({Key? key, this.imageSize}) : super(key: key);

  final double? imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageSize ?? 48.0,
      width: imageSize ?? 48.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1582610285985-a42d9193f2fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fHdvbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80")),
      ),
    );
  }
}
