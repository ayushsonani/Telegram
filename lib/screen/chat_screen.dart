import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telegram/controller/logics.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('user').doc(Controller.doc_id_sender).collection('chat').doc("${Controller.mobile_number}").collection("${Controller.mobile_rsever}").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(itemBuilder: (context, index) {
                return Container(
                  alignment: snapshot.data?.docs[index]['from']==Controller.mobile_number?Alignment.centerRight:Alignment.centerLeft,
                  child: Text("${snapshot.data?.docs[index]['message']}"),
                );
              },);
            }
            else{
              return CircularProgressIndicator();
            }
          },),
    );
  }
}
