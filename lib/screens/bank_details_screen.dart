import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesh/feature/home_screens/home_tab/user_tab.dart';

import 'package:mesh/screens/more_apply_details_screen.dart';
import 'package:mesh/screens/user_info_screen.dart';
import 'package:mesh/widgets/button.dart';
import 'package:mesh/widgets/icon_button.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  int _selectedIndex = 0;
  final accName = TextEditingController();
  final accNumber = TextEditingController();
  final ifscCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: const _BankDetailsAppBar(),
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: const Text("Select Account Type",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: TabOption(
                    text: "Savings",
                    radio: true,
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
                    text: "Current",
                    selectedIndex: _selectedIndex,
                    radio: true,
                    index: 1,
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 6, bottom: 10),
                      child: const HeadingText(
                        text: "Account Name",
                      )),
                  CustomTextField(
                    controller: accName,
                    hintText: "Enter your Account Name",
                    textStyle:
                        const TextStyle(fontSize: 14, color: Color(0xff2A2A2B)),
                    multiline: false,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 6, bottom: 10),
                      child: const HeadingText(text: "Account Number")),
                  CustomTextField(
                    controller: accNumber,
                    hintText: "Enter your Account Number",
                    textStyle:
                        const TextStyle(fontSize: 14, color: Color(0xff2A2A2B)),
                    multiline: false,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 6, bottom: 10),
                      child: const HeadingText(text: "IFSC Code")),
                  CustomTextField(
                    controller: ifscCode,
                    hintText: "Enter your IFSC Code",
                    textStyle:
                        const TextStyle(fontSize: 14, color: Color(0xff2A2A2B)),
                    multiline: false,
                  ),
                ]),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      textSize: 16,
                      height: 59,
                      fontWeight: FontWeight.w600,
                      borderRadius: 8,
                      primaryColor: Theme.of(context).focusColor,
                      buttonText: "Save",
                      onPressed: () {
                        // Get.toNamed("/more-apply-details");
                      })))
        ]));
  }
}

class _BankDetailsAppBar extends StatelessWidget {
  const _BankDetailsAppBar({
    Key? key,
  }) : super(key: key);
  // _ApplyOfferAppBar

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
            onTap: () {
              Get.back();
            },
            image: "assets/images/back.png",
            fillColor: Colors.white70,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 20.0),
            child: Text("Bank Details",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff252529),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
