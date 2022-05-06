import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.isMe, this.userId, {Key? key})
      : super(key: key);
  final bool isMe;
  final String message;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomLeft: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12))),
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            children: [
              Text(
                message,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 19),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Text(
                    snapshot.data['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
