import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  AboutTab({Key? key, this.exp = false}) : super(key: key);

  final bool exp;

  final List<String> tags = [
    "Theatre",
    "Music",
    "Art",
    "Model",
    "Painting",
    "Science"
  ];

  final List<String> tags2 = [
    "Videography 1 year",
    "Painting 2 year",
    "Art 3 year",
    "Modelling 4 year"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _AboutContent(),
        const SizedBox(height: 15),
        if (!exp)
          const Text("Skills",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff252529))),
        if (!exp) const SizedBox(height: 15),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children: (exp ? tags2 : tags)
              .map((item) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  decoration: BoxDecoration(
                      color: const Color(0xffE7F8F8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(item,
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600))))
              .toList(),
        )
      ]),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xff3D3D3D),
          ),
          children: <TextSpan>[
            const TextSpan(
              text:
                  "scientist 👀, visionary ✌, optimistic️, traveller🛫, physics, mathematics, neuro science, biology scientist 👀.... ",
            ),
            TextSpan(
                text: "More",
                style: TextStyle(color: Theme.of(context).focusColor)),
          ],
        ),
      ),
    );
  }
}
