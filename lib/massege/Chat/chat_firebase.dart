import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  String uid;
  ChatPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat Page'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Chat")
                    .where("message")
                    .get()
                    .then((snapshot) => snapshot.docs.last.reference.delete());
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    //color: Color.fromARGB(255, 235, 176, 81),
                    child: Column(
                  children: [
                    // PersInfo(uid: user!.uid),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Chat')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return (snapshot.data as QuerySnapshot)
                                    .docs
                                    .isNotEmpty
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: ListView.builder(
                                        itemCount:
                                            (snapshot.data! as QuerySnapshot)
                                                .docs
                                                .length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot task =
                                              (snapshot.data! as QuerySnapshot)
                                                  .docs[index];
                                          return Column(children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                    onLongPress: () {
                                                      String title = 'Delite';
                                                      String message =
                                                          'Do you want to Delete';
                                                      showAlertDialog(context,
                                                          title, message);
                                                    },
                                                    tileColor:
                                                        user?.uid == task["id"]
                                                            ? Colors.lime
                                                            : Colors.limeAccent,
                                                    title: Align(
                                                      alignment: user?.uid ==
                                                              task["id"]
                                                          ? Alignment
                                                              .centerRight
                                                          : Alignment
                                                              .centerLeft,
                                                      child: Text(
                                                        '${task['message']}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )))
                                          ]);
                                        }),
                                  )
                                : Center(
                                    child: Text("empty"),
                                  );
                          }
                        }),
                  ],
                )),
              ),
            ),
            Container(
              color: Colors.lightGreenAccent,
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(hintText: "Data"),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'enter data';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  _formkey.currentState!.save();
                  String mssage = 'data added ';
                  Map<String, dynamic> message = {
                    "message": textController.text,
                   // 'id': user!.uid,
                  };
                  FirebaseFirestore.instance
                      .collection(
                        "Chat",
                      )
                      .add(message);
                  // .toString();
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String message) {
    Widget delitebtn = ElevatedButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("Chat")
            .where("message")
            .get()
            .then((snapshot) => snapshot.docs.elementAt(0).reference.delete());
      },
      child: const Text("delete"),
      style: ElevatedButton.styleFrom(primary: Colors.red),
    );
    Widget cancelbtn = ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("cancel"));
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: [delitebtn, cancelbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
