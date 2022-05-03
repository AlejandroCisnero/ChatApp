import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App"),
        actions: [
          DropdownButton(
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
                  FirebaseAuth.instance.signOut();
                  break;
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chats/7jEjMX6s5qSOv276OT1P/messages")
              .snapshots(),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            // final document = snapshot.data.docs;
            return ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: Text(snapshot.data.docs[index]['text']),
                  );
                },
                itemCount: snapshot.data.docs.length);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/7jEjMX6s5qSOv276OT1P/messages")
              .add({'text': 'This message is from add button'});
        },
      ),
    );
  }
}
