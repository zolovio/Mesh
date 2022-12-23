import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mesh/feature/home_screens/services/remote_home_services.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/gradient_oval_image.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).hintColor, //change your color here
        ),
        title: Text("Notification", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<http.Response>(
        future: RemoteHomeServices.getNotifications(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData || snapshot.hasError) {
            print("waiting");
            return const Center(child: CircularProgressIndicator());
          }
          var body = json.decode(snapshot.data!.body) as Map<String, dynamic>;

          print(snapshot.data!.statusCode);

          if (snapshot.data!.statusCode != 200) {
            print("error");
            return Container(
              child: Text(snapshot.data!.body),
            );
          }

          print("Status code : 200");
          print(body["data"]);
          return ListView.builder(
            itemCount: (body["data"] as List<dynamic>).length,
            itemBuilder: (ctx, i) {
              return _Notification(
                response: body["data"][i] as Map<String, dynamic>,
              );
            },
          );
        }),
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  final bool notSeen;
  final Map<String, dynamic> response;
  const _Notification(
      {Key? key,
      this.notSeen = false,
      // this.moreinfo = false,
      required this.response})
      : super(key: key);

  bool moreinfo() => response["type_of_notification"] == "post";
  String time() {
    DateTime dateCreated = DateTime.parse(response["date_created"]);
    Duration difference = DateTime.now().difference(dateCreated);
    String time = "";
    if (difference.inSeconds < 60) {
      time = difference.inSeconds.toString() + "s";
    }
    if (difference.inHours > 0) {
      time = difference.inHours.toString() + "h";
    }
    if (difference.inDays > 0) {
      time = difference.inDays.toString() + "d";
    }
    if (DateTime.now().year - dateCreated.year > 0) {
      time = (DateTime.now().year - dateCreated.year).toString() + "yr";
    }
    if ((DateTime.now().year - dateCreated.year == 0 && DateTime.now().month - dateCreated.month > 0) ||
        (DateTime.now().year - dateCreated.year == 1 && DateTime.now().month - dateCreated.month < 0)) {
      time = ((DateTime.now().month - dateCreated.month) > 0
                  ? (DateTime.now().month - dateCreated.month)
                  : (DateTime.now().month - dateCreated.month + 12))
              .toString() +
          "m";
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    // print(response);
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 13),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: (notSeen) ? const Color(0xffedefff) : const Color(0xffF0F0F0)),
        child: Stack(
          children: [
            ListTile(
              leading: OvalImage(imageSize: 45, imageUrl: "https://d4d.agpro.co.in/assets/${response["image"]}"),
              contentPadding: const EdgeInsets.only(left: 5, right: 3, top: 0, bottom: 0),
              minVerticalPadding: 0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(response["description"], style: const TextStyle(color: Colors.black, fontSize: 10, height: 1.5)),
                  if (moreinfo())
                    CustomButton(
                      padding: const EdgeInsets.all(1),
                      margin: const EdgeInsets.only(top: 10),
                      width: 65,
                      height: 25,
                      textSize: 9,
                      fontWeight: FontWeight.w500,
                      buttonText: "View Event",
                      onPressed: () {},
                      shadowColor: Colors.transparent,
                      primaryColor: Colors.transparent,
                      borderColor: Theme.of(context).focusColor,
                      textColor: Theme.of(context).focusColor,
                    ),
                ],
              ),
              trailing: Icon(Icons.more_vert, color: Colors.black.withOpacity(0.5)),
            ),
            Positioned(
              right: screenWidth * 0.03,
              top: (moreinfo()) ? 5 : 6,
              child: Text(time(), style: const TextStyle(color: Colors.black, fontSize: 8)),
            )
          ],
        ),
      ),
    );
  }
}
