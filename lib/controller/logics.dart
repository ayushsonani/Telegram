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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/controller/user_data.dart';
import 'package:telegram/screen/home_screen.dart';

import '../screen/otp_screen.dart';

class Controller extends ChangeNotifier {

  Controller(){
    get_share_preference();
  }

  String phone_verify_id = "";
  static String mobile_number = "";
  static List<UserData> userDataList = [];
  static SharedPreferences? sharedPreferences;

  phone_auth(String phone, BuildContext context) async {
    phone = "+91" + phone;
    mobile_number = phone;
    print(
        "=============================\n\n\n\n\n\n         phone := ${phone}");
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          Fluttertoast.showToast(msg: "${error.message}");
        },
        codeSent: (verificationId, forceResendingToken) {
          phone_verify_id = verificationId;
          print(
              "---------------------------\n\n\n\n\n--------------------verify id := ${phone_verify_id}");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChangeNotifierProvider(
                create: (context) => Controller(),
                child: OtpScreen(phone_verify_id),
              );
            },
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        phoneNumber: phone);

    notifyListeners();
  }

  otp_chack(String otp, String verifyId) {
    print(
        "---------------------------\n\n\n\n\n--------------------verify id := ${verifyId}");

    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    // print("Id := ${credential.token}");

    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Fluttertoast.showToast(
          msg: "Add User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    notifyListeners();
  }

  File? image;
  ImagePicker imagePicker = ImagePicker();
  bool image_Null = true;

  imageUploading(BuildContext context) async {
    XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
    } else {}
    notifyListeners();
  }

  user_id_get() {
    user_id = FirebaseAuth.instance.currentUser?.uid ?? "";
    print("---------------------\n\n\n\n\n---------user id := ${user_id}");
    return user_id;
  }

  String progile_image_url = "";
  static String user_id = "";

  online_data_insert(String name, BuildContext context) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref('user')
        .child("${FirebaseAuth.instance.currentUser?.uid}")
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    progile_image_url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("user").add({
      "name": "${name}",
      "profile_img": "${progile_image_url}",
      "user_id": "${user_id}",
      "mobile": "${mobile_number}"
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider(
              create: (context) => Controller(), child: HomeScreen());
        },
      ));
    });
  }

  user_data_add(String name, String mobile) {
    UserData userData = UserData(
        mobile: mobile,
        name: name,
        userid: user_id,
        profile_img: progile_image_url);

    userDataList.add(userData);

    notifyListeners();
  }

  chat_user_add(String phone2) async {
    phone2 = "+91" + phone2;
    print("--_____________-----${phone2}--------");
    var data = await FirebaseFirestore.instance.collection('user').get();

    var courent_user_data = await FirebaseFirestore.instance
        .collection('user')
        .doc('${doc_id_sender}')
        .get();

    for (int i = 0; i < data.docs.length; i++) {
      print("%%%%%%%%% ${data.docs[i].data()['mobile']}%%%%%%%%%");
      if (data.docs[i].data()['mobile'] == "${phone2}") {
        print(
            "=============================\n\n\n\n\n\n         phone := ${mobile_number}");

        print(
            "@@@@@@@@ \n\n    courent_user := ${courent_user_data.data()} \n\n");
        print("@@@@@@@@ \n\n    courent_user := ${data.docs[i].data()} \n\n");

        user_chat_data_online(phone2, doc_id_sender,
            data.docs[i].data()['name'], data.docs[i].data()['profile_img']);
        doc_id_rsever.add(data.docs[i].id);
        user_chat_data_online(
            mobile_number,
            data.docs[i].id,
            courent_user_data.data()?['name'],
            courent_user_data.data()?['profile_img']);

        show = true;
        sharedPreferences?.setBool('show', show);
      }
    }
    notifyListeners();
  }

  user_chat_data_online(
      String phone, String doc_id, String name, String profile_img) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(doc_id)
        .collection('chat')
        .doc("${phone}")
        .set({
      "join time": "${DateTime.now()}",
      "name": name,
      "profile_img": profile_img
    });
    notifyListeners();
  }

  static String doc_id_sender = "";
  static List<String> mobile_rsever = [];
  static List<String> doc_id_rsever = [];

  send_massage({required String message,required String to,String image_url=""}) async {
    var data = await FirebaseFirestore.instance.collection('user').get();
    print("~~~~~~~~~~~~~~~~~~~~~~ image url := ${image_url}");
    for (int i = 0; i < data.docs.length; i++) {
      print("object");
      if (data.docs[i].data()['mobile'] == mobile_number) {
        doc_id_sender = data.docs[i].id;
        FirebaseFirestore.instance
            .collection('user')
            .doc(doc_id_sender)
            .collection('chat')
            .doc("${to}")
            .collection("message")
            .add({
          "to": to,
          "from": mobile_number,
          "time": "${DateTime.now()}",
          "message": message,
          "image":image_url
        });
        print("-----------=========== doc_id_sender =======${data.docs[i].id}");
      }
      if (data.docs[i].data()['mobile'] == to) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(data.docs[i].id)
            .collection('chat')
            .doc("${mobile_number}")
            .collection("message")
            .add({
          "to": to,
          "from": mobile_number,
          "time": "${DateTime.now()}",
          "message": message,
          "image":image_url
        });
        // doc_id_rsever.add(data.docs[i].id);
        // mobile_rsever.add(data.docs[i].data()['mobile']);
        print("-----------==============     mobile_rsever   ====${to}");
      }
    }

    notifyListeners();
  }

  ImagePicker picker = ImagePicker();
  File? user_send_img;
  get_image() async {
    XFile? images =await picker.pickImage(source: ImageSource.gallery);
    if(images!=null){
      user_send_img = File(images.path);
    }
  }

  send_image({required String to}) async {

    String image_url = "";
    print("user_inmg is null := ${user_send_img?.path}");
    if(user_send_img!=null){
        UploadTask uploadTask =  FirebaseStorage.instance.ref('user').child("chat").child("${to}").child("${DateTime.now()}").putFile(user_send_img!);

      TaskSnapshot taskSnapshot = await uploadTask;

      image_url =await taskSnapshot.ref.getDownloadURL();

      print("---------- image url := ${image_url}");

      send_massage(message: "", to: to,image_url: image_url);

    }


  }

  static bool show = false;

  get_share_preference() async {
    Controller.sharedPreferences = await SharedPreferences.getInstance();

    show = Controller.sharedPreferences?.getBool('show') ?? false;
    print(" show is := ${show}");
    notifyListeners();
  }

}
