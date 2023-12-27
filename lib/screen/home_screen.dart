import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';
import 'package:telegram/screen/chat_screen.dart';
class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});

  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return MyChatApp();
          // },));
        },title: Text("${index}"),);
      },),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Chat User"),
            content: TextField(controller: phone,),
            actions: [
              ElevatedButton(onPressed: () {
                controller.chat_user_add(phone.text);
                }, child: Text("Add User"))
            ],
          );
        },);
      }, label: Text("Add User")),
    );
  }
}
