import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:telegram/controller/user_data.dart';

import '../screen/otp_screen.dart';

class Controller extends ChangeNotifier {
  String phone_verify_id ="";
 static String mobile_number = "";
  phone_auth(String phone,BuildContext context) async {
    phone = "+91" + phone;
    mobile_number = phone;
    print("=============================\n\n\n\n\n\n         phone := ${phone}");
   await FirebaseAuth.instance.verifyPhoneNumber(
       verificationCompleted: (phoneAuthCredential) {},
       verificationFailed: (error) {},
       codeSent: (verificationId, forceResendingToken) {
     phone_verify_id = verificationId;
     print("---------------------------\n\n\n\n\n--------------------verify id := ${phone_verify_id}");
    },
       codeAutoRetrievalTimeout: (verificationId) {},
    phoneNumber: phone
    );

    notifyListeners();
    if(phone_verify_id!=""){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChangeNotifierProvider(create: (context) => Controller(),child: OtpScreen(phone_verify_id),);
      },));
    }


  }

  otp_chack(String otp,String verifyId){
    print("---------------------------\n\n\n\n\n--------------------verify id := ${verifyId}");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    // print("Id := ${credential.token}");

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Fluttertoast.showToast(
          msg: "Add User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
    notifyListeners();
  }

  File? image;
  ImagePicker imagePicker = ImagePicker();
  bool image_Null = true;
   imageUploading(BuildContext context) async {
    XFile? img =await imagePicker.pickImage(source: ImageSource.gallery);
    if(img!=null){
      image = File(img.path);
    }
    else{
    }
    notifyListeners();
  }
  user_id_get(){
    user_id = FirebaseAuth.instance.currentUser?.uid ?? "";
    print("---------------------\n\n\n\n\n---------user id := ${user_id}");
    return user_id;
  }






   String progile_image_url = "";
   String user_id = "";
  online_data_insert(String name) async {
    UploadTask uploadTask = FirebaseStorage.instance.ref('user').child("${FirebaseAuth.instance.currentUser?.uid}").putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    progile_image_url =await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("user").add({
      "name":"${name}",
      "profile_img":"${progile_image_url}",
      "user_id":"${user_id}",
      "mobile":"${mobile_number}"
    });
   }


  user_data_add(String name){
  UserData userData = UserData(name: name, userid: user_id, profile_img: progile_image_url);
  }

  chat_user_add(String phone2) async {

    phone2 = "+91" + phone2;
    print("--_____________-----${phone2}--------");
  var data =await  FirebaseFirestore.instance.collection('user').get();

  for(int i=0; i<data.docs.length; i++){
    print("%%%%%%%%% ${data.docs[i].data()['mobile']}%%%%%%%%%");

    if(data.docs[i].data()['mobile']==mobile_number){
      await FirebaseFirestore.instance.collection('user').doc(data.docs[i].id).collection('chat').doc("${mobile_number}").collection("${phone2}").add({
        "number":phone2
      });
    }

    if(data.docs[i].data()['mobile']=="${phone2}"){
      print("=============================\n\n\n\n\n\n         phone := ${mobile_number}");
      await FirebaseFirestore.instance.collection('user').doc(data.docs[i].id).collection('chat').doc("${phone2}").collection("${mobile_number}").add({
        "number":mobile_number
      });
    }
  }


  }
  static String doc_id_sender ="";
  static String mobile_rsever ="";
  static String doc_id_rsever ="";
  send_massage({required String message,required String to,}) async {

   var data =await  FirebaseFirestore.instance.collection('user').get();


   for(int i=0; i<data.docs.length; i++){
     if(data.docs[i].data()['mobile']==mobile_number){
       doc_id_sender= data.docs[i].id;

       print("-----------=========== doc_id_sender =======${data.docs[i].id}");
     }
     if(data.docs[i].data()['mobile']==to){
       doc_id_rsever = data.docs[i].id;
       mobile_rsever = data.docs[i].data()['mobile'];
       print("-----------==============     mobile_rsever   ====${mobile_rsever}");

     }
   }

    FirebaseFirestore.instance.collection('user').doc(doc_id_sender).collection('chat').doc("${mobile_number}").collection("${mobile_rsever}").add({
      "to":mobile_rsever,
      "from":mobile_rsever,
      "time":"${DateTime.now()}",
      "message":message
    });

   FirebaseFirestore.instance.collection('user').doc(doc_id_rsever).collection('chat').doc("${mobile_rsever}").collection("${mobile_number}").add({
     "to":mobile_rsever,
     "from":mobile_rsever,
     "time":"${DateTime.now()}",
     "message":message
   });

  }
  

}