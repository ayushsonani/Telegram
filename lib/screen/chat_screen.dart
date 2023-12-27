import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';

class ChatScreen extends StatelessWidget {
  String? phone_2;

  ChatScreen(this.phone_2);

  TextEditingController textEditingController =TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);
    print("------------------------${this.phone_2}");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('user').doc(Controller.doc_id_sender).collection('chat').doc("$phone_2").collection("message").where("time").orderBy("time").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(padding: EdgeInsets.all(10),itemCount: snapshot.data?.size,itemBuilder: (context, index) {
                return UnconstrainedBox(
                  alignment: snapshot.data?.docs[index]['from']==Controller.mobile_number?Alignment.centerRight:Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: snapshot.data?.docs[index]['from']==Controller.mobile_number?Colors.blue:Colors.yellow,
                    ),
                    alignment: Alignment.center,
                    child: Text("${snapshot.data?.docs[index]['message']}",style: TextStyle(fontSize: 25,color: Colors.white)),
                  ),
                );
              },);
            }
            else{
              return CircularProgressIndicator();
            }
          },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin:
            const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
            child: Transform.rotate(
                angle: 45,
                child: const Icon(
                  Icons.attach_file_sharp,
                  color: Colors.white,
                )),
          ),
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              cursorColor: Colors.white,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 6,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin:
            const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 11.0),
            child: Transform.rotate(
              angle: -3.14 / 5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: GestureDetector(
                  onTap: () async {
                    await controller.send_massage(message: textEditingController.text, to: phone_2??"");
                    textEditingController.clear();
                  },
                  onLongPress: () {

                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
