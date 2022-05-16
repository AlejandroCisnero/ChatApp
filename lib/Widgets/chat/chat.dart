import 'package:chat_app/Providers/applicationState.dart';
import 'package:chat_app/Widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final chatDocs = chatSnapshot.data.docs;
            if (chatDocs.length == 0) {
              return const Center(child: Text('No messages to show'));
            } else {
              return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    return MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['userId'] ==
                          FirebaseAuth.instance.currentUser!.uid,
                      chatDocs[index]['userId'],
                      key: ValueKey(chatDocs[index].id),
                    );
                  });
            }
          }
        });
  }
}
