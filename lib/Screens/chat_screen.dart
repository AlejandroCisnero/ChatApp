import 'dart:developer';
import 'dart:math' as math;

import 'package:chat_app/Providers/applicationState.dart';
import 'package:chat_app/Widgets/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const route = '/';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  String? messageString = "";

  Future<void> sendMessage(context) async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': messageController.text.trim(),
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid
    });
    messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Chat App",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Row(children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Sign out')
                  ]),
                  value: 0,
                )
              ],
              onChanged: (dynamic value) {
                switch (value) {
                  case 0:
                    Provider.of<ApplicationState>(context, listen: false)
                        .signOut();
                    break;
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: Chat()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          messageString = value;
                        });
                      },
                      controller: messageController,
                      style: const TextStyle(color: Colors.black, fontSize: 19),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 12.5, left: 15),
                          hintText: 'Type a message',
                          suffixIcon: IconButton(
                            onPressed: messageString!.trim() == ''
                                ? null
                                : () {
                                    sendMessage(context);
                                  },
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.shadow,
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // FirebaseFirestore.instance
      //     .collection("chats/7jEjMX6s5qSOv276OT1P/messages")
      //     .add({'text': 'This message is from add button'});
    );
  }
}
