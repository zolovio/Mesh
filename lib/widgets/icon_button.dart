import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton(
      {Key? key,
      required this.image,
      required this.onTap,
      this.circle = false,
      this.fillColor,
      this.iconColor,
      this.green = false,
      this.size})
      : super(key: key);

  final void Function()? onTap;
  final String image;
  final bool green;
  final Color? fillColor;
  final Color? iconColor;
  final bool circle;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: size ?? 40,
          height: size ?? 36,
          decoration: BoxDecoration(
              shape: (circle) ? BoxShape.circle : BoxShape.rectangle,
              color: (green)
                  ? Theme.of(context).focusColor
                  : fillColor ?? Colors.white,
              borderRadius: (!circle) ? BorderRadius.circular(10) : null,
              border: (!green)
                  ? Border.all(
                      color: const Color(0xffF0F0F0),
                    )
                  : null),
          child: Center(
            child: Image.asset(image,
                color: iconColor ?? ((green) ? Colors.white : null)),
          )),
    );
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({Key? key, this.text, this.height, this.width})
      : super(key: key);
  final String? text;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(8)),
        width: width ?? 101,
        height: height ?? 36,
        child: Text(text ?? "Follow",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white)));
  }
}

class CrossSymbol extends StatelessWidget {
  const CrossSymbol({Key? key, required this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2,
      right: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xffC9C9C9).withOpacity(0.5),
            ),
            width: 34,
            height: 16,
            child: const Icon(Icons.close, color: Colors.white, size: 9)),
      ),
    );
  }
}
