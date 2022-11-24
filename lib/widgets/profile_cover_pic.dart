import 'package:flutter/material.dart';

class ProfileCoverPic extends StatelessWidget {
  const ProfileCoverPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/star.png",
                            color: Colors.white, fit: BoxFit.cover),
                        const Spacer(),
                        Image.asset("assets/images/star.png",
                            color: Colors.white),
                      ],
                    )),
              )
            ],
          ),
          Positioned(
            bottom: -35,
            child: Container(
              height: 86.0,
              width: 86.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://cdn.ppcorn.com/us/wp-content/uploads/sites/14/2016/01/Mark-Zuckerberg-pop-art-ppcorn.jpg'),
                  ),
                  border: Border.all(color: Colors.white, width: 4.0)),
            ),
          ),
        ],
      ),
    );
  }
}
