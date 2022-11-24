class Reactions {
  bool thumbsup;
  bool thumbsdown;
  bool heart;
  Reactions(
      {this.heart = false, this.thumbsdown = false, this.thumbsup = false});
}

class Message {
  String user;
  String time;
  String? message;

  Message({
    required this.user,
    required this.time,
    this.message,
  });
}

List<Message> messages = [
  Message(
    user: "Other",
    time: "2:20pm",
    message: "hey antari ! how are you? thanks for adding me ✌🏻❤️",
  ),
  Message(
    user: "You",
    time: "2:20pm",
    message: "hey raymond. im good ✌🏻❤️ thanks for asking",
  ),
  Message(
    user: "Other",
    time: "2:20pm",
    message: "hey antari ! how are you? thanks for adding me ✌🏻❤️",
  ),
  Message(
    user: "You",
    time: "2:20pm",
    message: "hey raymond. im good ✌🏻❤️ thanks for asking",
  ),
  Message(
    user: "Other",
    time: "2:20pm",
    message: "hey antari ! how are you? thanks for adding me ✌🏻❤️",
  ),
];
