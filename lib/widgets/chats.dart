import 'package:flutter/material.dart';

import 'messages.dart';

class Chats extends StatelessWidget {
  final Message message;
  const Chats({Key? key, required this.message}) : super(key: key);

  bool isMe() => message.user == "You";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment:
          (isMe()) ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            crossAxisAlignment:
                isMe() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                alignment: isMe() ? Alignment.topRight : null,
                constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: (isMe())
                      ? Theme.of(context).focusColor
                      : const Color(0xffF7F7F7),
                  borderRadius: BorderRadius.only(
                      topLeft: isMe() ? const Radius.circular(20) : Radius.zero,
                      topRight:
                          isMe() ? Radius.zero : const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20)),
                ),
                child: Text(
                  message.message ?? "",
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: (isMe()) ? Colors.white : const Color(0xff252529),
                      fontSize: 16),
                ),
              ),
              SizedBox(
                  child: Text(message.time,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xff949292))))
            ],
          ),
        )
      ],
    );
  }
}
