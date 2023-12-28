
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/logics.dart';
import 'dart:io';
class ProfileEditScreen extends StatelessWidget {
  // ProfileEditScreen({super.key});


  TextEditingController name = TextEditingController();
  @override

  Widget build(BuildContext context) {

    Controller controller = Provider.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                controller.imageUploading(context);
                },
              child: controller.image!=null?Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color:  Colors.grey.shade300,
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.cover,image: FileImage(controller.image!))
                ),
              ):Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                    color:  Colors.grey.shade300,
                    shape: BoxShape.circle,
                ),
                child: Icon(Icons.add),
              ),
            ),
            TextField(
              controller: name,
            ),
            ElevatedButton(onPressed: () async {
              controller.user_id_get();
              print("####\n\n\n\n\n##################### phone numbers  := ${Controller.mobile_number}");
              await controller.online_data_insert(name.text);
              controller.user_data_add(name.text,Controller.mobile_number);
            }, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
