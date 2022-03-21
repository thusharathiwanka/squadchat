import 'dart:async';
import 'package:chat/src/models/message.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/message/message_service_contract.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class MessageService implements IMessageService {
  final Rethinkdb rethinkdb;
  final Connection _connection;
  final _controller = StreamController<Message>.broadcast();
  StreamSubscription _changefeed;

  MessageService(this.rethinkdb, this._connection);

  @override
  Future<bool> send(Message message) async {
    Map record = await rethinkdb
        .table('messages')
        .insert(message.toJson())
        .run(_connection);
    return record['inserted'] == 1;
  }

  @override
  Stream<Message> messages({User activeUser}) {
    _startReceivingMessages(activeUser);
    return _controller.stream;
  }

  @override
  void dispose() {
    _changefeed?.cancel();
    _controller?.close();
  }

  void _startReceivingMessages(User activeUser) {
    _changefeed = rethinkdb
        .table('messages')
        .filter({'to': activeUser.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event.forEach((feedData) {
            if (feedData['new_val'] == null) return;

            final message = messageFromFeed(feedData);
            _controller.sink.add(message);
            _removeDeliveredMessage(message);
          }).catchError((error) {
            print(error);
          }).onError((error, stackTrace) => print(error));
        });
  }

  Message messageFromFeed(feedData) {
    return Message.fromJson(feedData['new_val']);
  }

  void _removeDeliveredMessage(Message message) {
    rethinkdb
        .table('messages')
        .get(message.id)
        .delete({'return_changes': false}).run(_connection);
  }
}