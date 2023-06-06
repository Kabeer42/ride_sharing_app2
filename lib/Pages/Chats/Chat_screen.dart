import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  // final String userId = "bXmoix3XbcO4M0RCuPHPg8LP4Pg2";
  // ChatScreen({required this.userId});
  final String userId = "User123";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _messageText = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userId}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection('chats')
                  .doc(widget.userId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message.data()['text'] as String?;
                  final messageSender = message.data()['sender'] as String?;
                  if (messageText != null && messageSender != null) {
                    final messageWidget =
                        Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  }
                }
                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      setState(() {
                        _messageText = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _messageText.isEmpty
                      ? null
                      : () {
                          _firestore
                              .collection('chats')
                              .doc(widget.userId)
                              .collection('messages')
                              .add({
                            'text': _messageText,
                            'sender': 'Me',
                            'timestamp': DateTime.now(),
                          });
                          setState(() {
                            _messageController.clear();
                            _messageText = "";
                          });
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
