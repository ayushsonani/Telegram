import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Controller extends ChangeNotifier {
  String phone_verify_id ="";
  phone_auth(String phone) async {
    phone = "+91" + phone;
    print("phone := ${phone}");
   await FirebaseAuth.instance.verifyPhoneNumber(verificationCompleted: (phoneAuthCredential) {

    }, verificationFailed: (error) {

    }, codeSent: (verificationId, forceResendingToken) {
      phone_verify_id = verificationId;
    }, codeAutoRetrievalTimeout: (verificationId) {

    },
    phoneNumber: phone
    );

    print("verify id := ${phone_verify_id}");
    notifyListeners();
  }

  otp_chack(String otp){
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: phone_verify_id, smsCode: otp);

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

}