import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';

class ChatScreen extends StatelessWidget {
  String? phone_2;

  ChatScreen(this.phone_2);

  TextEditingController textEditingController = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);
    print("------------------------${this.phone_2}");

    return Scaffold(
      resizeToAvoidBottomInset: true, // assign true
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Chat",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(Controller.doc_id_sender)
                .collection('chat')
                .doc("$phone_2")
                .collection("message")
                .where("time")
                .orderBy("time")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return Align(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                      controller: scrollController,
                      separatorBuilder: (context, index) {
                      return Center(child: Text("----------",style: TextStyle(color: Colors.white),));
                    },
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {

                      final time = DateTime.parse(snapshot.data?.docs[index]['time']).toLocal();
                      int h=time.hour;
                      int m=time.minute;
                      String am_or_pm = "";
                      if(time.hour>=12){
                        if(time.hour>=13){
                          h = time.hour - 12;
                        }
                        am_or_pm = "pm";
                      }
                      else{
                        if(time.hour==0){
                          h = 12;
                        }
                        else{
                          h = time.hour;
                        }
                        am_or_pm = "am";
                      }

                      return UnconstrainedBox(
                        alignment: snapshot.data?.docs[index]['from'] ==
                            Controller.mobile_number
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            color: snapshot.data?.docs[index]['from'] ==
                                Controller.mobile_number
                                ? Colors.deepPurple.shade400
                                : Colors.green.shade500,
                          ),
                          alignment: Alignment.center,
                          child: snapshot.data?.docs[index].data()['image']==""? Row(

                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [



                              Text("${snapshot.data?.docs[index]['message']} ",
                                  style: TextStyle(fontSize: 18, color: Colors.white)),
                              Text("${h}:${m}   ${am_or_pm}")
                            ],
                          ):Stack(alignment: Alignment.bottomRight,children: [
                            Image.network(fit: BoxFit.fill,height: 200,width: 200,"${snapshot.data?.docs[index]['image']}"),
                            Align(child: Container(decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.black,offset: Offset(0, 0),blurRadius: 20),
                              ]
                            ),child: Text("${h}:${m} ${am_or_pm}",style: TextStyle(color: Colors.white),)))
                          ]),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
          Container(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(

                  onTap: () async {
                    await controller.get_image();
                    controller.send_image(to: '${phone_2}');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
                    child: Transform.rotate(
                        angle: 45,
                        child: const Icon(
                          Icons.attach_file_sharp,
                          color: Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      print("object");
                      scrollController.animateTo(scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    onChanged: (value) {
                      scrollController.animateTo(scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
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
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 11.0),
                  child: Transform.rotate(
                    angle: -3.14 / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () async {
                          await controller.send_massage(
                              message: textEditingController.text, to: phone_2 ?? "");

                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          textEditingController.clear();
                        },
                        onLongPress: () {},
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
          )
        ],
      ),
    );
  }
}
