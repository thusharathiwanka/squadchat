import 'package:flutter/foundation.dart';

enum Typing { start, stop }

extension TypingParser on Typing {
  String value() {
    return toString().split('.').last;
  }

  static Typing fromString(String event) {
    return Typing.values.firstWhere((element) => element.value() == event);
  }
}

class TypingEvent {
  String _id;
  final String from;
  final String to;
  final Typing event;
  final String chatId;

  TypingEvent(
      {@required this.from,
      @required this.to,
      @required this.event,
      @required this.chatId});

  String get id => _id;

  Map<String, dynamic> toJson() =>
      {'from': from, 'to': to, 'event': event.value(), 'chat_id': chatId};

  factory TypingEvent.fromJson(Map<String, dynamic> json) {
    var event = TypingEvent(
      chatId: json['chat_id'],
      from: json['from'],
      to: json['to'],
      event: TypingParser.fromString(
        json['event'],
      ),
    );
    event._id = json['id'];
    return event;
  }
}
