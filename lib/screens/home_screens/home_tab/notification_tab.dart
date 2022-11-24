import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/controller/home_controller.dart';
import 'package:mesh/screens/home_screens/home_tab/notification_tabs/notification_content.dart';
import 'package:mesh/screens/user_info_screen.dart';
import 'package:mesh/widgets/icon_button.dart';

class NotificationTab extends StatefulWidget {
  NotificationTab({Key? key}) : super(key: key);

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  int _selectedIndex = 0;
  final controller = Get.find<HomeController>();

  List<Widget> _pages() => <Widget>[
        const CompetitionTab(),
        (controller.business.value)
            ? NotificationContent(
                competition: true,
                earnings: true,
              )
            : Container()
      ];
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: ScrollController(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: TabOption(
                          text: (controller.business.value)
                              ? "My Training"
                              : "Competiton",
                          selectedIndex: _selectedIndex,
                          index: 0,
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: TabOption(
                          text: (controller.business.value)
                              ? "My Earnings"
                              : "Auditions",
                          selectedIndex: _selectedIndex,
                          index: 1,
                        ))
                  ],
                )),
            flexibleSpace: _NotificationAppBar(),
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
          )
        ];
      },
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
              color: Colors.white, child: _pages().elementAt(_selectedIndex))),
    );
  }
}

class _NotificationAppBar extends StatelessWidget {
  _NotificationAppBar({
    Key? key,
  }) : super(key: key);
  // final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffF5F6F6),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      ),
      padding: const EdgeInsets.only(top: 50, left: 20, bottom: 0, right: 20),
      child: Row(
        children: [
          AppBarIconButton(
            onTap: () {},
            image: "assets/images/back.png",
            fillColor: Colors.white70,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
            child: Text("Notifications",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          AppBarIconButton(
            onTap: () {},
            image: "assets/images/more.png",
          ),
        ],
      ),
    );
  }
}
