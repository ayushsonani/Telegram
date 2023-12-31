import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/screen/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});

  TextEditingController phone = TextEditingController();
  bool list_avalabel = false;
  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);

    list_avalabel = Controller.show;

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! data sender := ${Controller.doc_id_sender}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: list_avalabel
            ? StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc('${Controller.doc_id_sender}')
              .collection('chat')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(
                  "^^^^^^^^^^^^^^^^^^^^^^^   Data := ${FirebaseFirestore.instance.collection('user').doc(Controller.doc_id_sender).get()}");

              return ListView.builder(
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(Controller.doc_id_sender)
                        .collection('chat')
                        .snapshots(),
                    builder: (context, snapshot2) {
                      if (snapshot2.hasData) {
                        return Card(
                          elevation: 10,
                          color: Colors.deepPurple.shade400,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChangeNotifierProvider(
                                    create: (context) => Controller(),
                                    child: ChatScreen(
                                        snapshot.data?.docs[index].id),
                                  );
                                },
                              ));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot2
                                  .data?.docs[index]['profile_img']),
                            ),
                            title: Text(
                                "${snapshot2.data?.docs[index]['name']}",style: TextStyle(color: Colors.white)),
                          ),
                        );
                      } else {
                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ChangeNotifierProvider(
                                  create: (context) => Controller(),
                                  child: ChatScreen(
                                      snapshot.data?.docs[index].id),
                                );
                              },
                            ));
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          title: Text("${snapshot.data?.docs[index].id}"),
                        );
                      }
                    },
                  );
                },
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Chat User"),
                  content: TextField(
                    controller: phone,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          await controller.chat_user_add(phone.text);
                          Navigator.pop(context);
                        },
                        child: Text("Add User"))
                  ],
                );
              },
            );
          },
          label: Text("Add User")),
    );
  }
}
